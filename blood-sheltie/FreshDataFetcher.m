//
// Created by Alexandre Normand on 1/24/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import "FreshDataFetcher.h"
#import "DeviceObserver.h"
#import "ORSSerialPort.h"
#import "EncodingUtils.h"
#import "DefaultEncoder.h"
#import "ReadDatabasePageRangeRequest.h"
#import "SessionData.h"
#import "DefaultDecoder.h"
#import "SessionObserver.h"
#import "DataPaginator.h"

static const uint HEADER_SIZE = 4;

@implementation FreshDataFetcher {
    ORSSerialPort *port;
    NSMutableArray *sessionRequests;
    DefaultEncoder *encoder;
    DefaultDecoder *decoder;
    ReceiverRequest *currentRequest;
    // TODO: move those 3 in a responseAccumulator inner class
    NSMutableData *responseBuffer;
    ResponseHeader *currentResponseHeader;
    uint expectedResponseSize;
}
- (instancetype)initWithSerialPortPath:(NSString *)serialPortPath since:(NSDate *)since {
    self = [super init];
    if (self) {
        _serialPortPath = serialPortPath;
        _since = since;
        _observers = [[NSMutableArray alloc] init];
        _sessionData = [[SessionData alloc] init];
        encoder = [[DefaultEncoder alloc] init];
        decoder = [[DefaultDecoder alloc] init];
    }

    return self;
}

+ (instancetype)fetcherWithSerialPortPath:(NSString *)serialPortPath since:(NSDate *)since {
    return [[self alloc] initWithSerialPortPath:serialPortPath since:since];
}

- (void)registerObserver:(id <DeviceObserver>)observer {
    [_observers addObject:observer];
}

- (void)unregisterObserver:(id <DeviceObserver>)observer {
    [_observers removeObject:observer];
}

- (void)run {
    sessionRequests = [self generateInitialRequestFlow];

    // Open the port and initiate the download session
    port = [ORSSerialPort serialPortWithPath:_serialPortPath];
    [port setDelegate:self];
    [port setBaudRate:@115200];
    [port setNumberOfStopBits:1];
    [port setParity:ORSSerialPortParityNone];
    [port setUsesRTSCTSFlowControl:true];
    [port setRTS:true];
    [port setDTR:true];
    [port open];

    // When we get a Clear-To-Send, we'll start the session
    [port addObserver:self forKeyPath:@"CTS" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
}

- (NSMutableArray *)generateInitialRequestFlow {
    NSMutableArray *requests = [[NSMutableArray alloc] init];
    [requests addObject:[[ReceiverRequest alloc] initWithCommand:Ping]];
    [requests addObject:[[ReadDatabasePageRangeRequest alloc] initWithRecordType:ManufacturingData]];
    // TODO add this back when MeterData parsing is implemented
    // [requests addObject:[[ReadDatabasePageRangeRequest alloc] initWithRecordType:MeterData]];
    [requests addObject:[[ReadDatabasePageRangeRequest alloc] initWithRecordType:UserEventData]];
    [requests addObject:[[ReadDatabasePageRangeRequest alloc] initWithRecordType:EGVData]];

    return requests;
}

- (void)serialPort:(ORSSerialPort *)serialPort didReceiveData:(NSData *)data {
    NSLog(@"Received data: %s\n", [[EncodingUtils bytesToString:(Byte *)[data bytes] withSize:data.length] UTF8String]);

    if (responseBuffer == nil) {
        NSLog(@"Reading response header for command %s", [[Types receiverCommandIdentifier:currentRequest.command] UTF8String]);
        NSUInteger currentPosition = 0;
        NSData *headerData = [data subdataWithRange:NSMakeRange(currentPosition, HEADER_SIZE)];
        currentPosition += HEADER_SIZE;

        currentResponseHeader = [decoder decodeHeader:headerData];
        expectedResponseSize = currentResponseHeader.packetSize - HEADER_SIZE;
        NSLog(@"Expecting [%d] bytes, minus header", expectedResponseSize);
        NSData *responseData = [data subdataWithRange:NSMakeRange(currentPosition, [data length] - currentPosition)];
        // Create a new buffer for this new response
        responseBuffer = [[NSMutableData alloc] init];
        [self handleDataAndFillBuffer:responseData];
    } else {
        [self handleDataAndFillBuffer:data];
    }
}

/**
* Handles a full response once it's fully received
*/
- (void)handleResponseData:(NSData *)data withHeader:(ResponseHeader *)header {
    ReceiverResponse *response = [decoder decodeResponse:data toRequest:currentRequest withHeader:header];
    NSLog(@"Decoded response %@ from bytes [%s]", response,
            [[EncodingUtils bytesToString:[data bytes] withSize:[data length]] UTF8String]);

    [sessionRequests removeObject:currentRequest];
    NSLog(@"Removed request [%@] from queue", currentRequest);

    NSArray *requests = [self newRequestsFromResponse:response toRequest:currentRequest];

    if (requests != nil) {
        NSLog(@"Adding [%lu] requests", [requests count]);
        [sessionRequests addObjectsFromArray:requests];
    } else {
        NSLog(@"No requests to spawn from response [%@] to request [%@]", response, currentRequest);
    }

    if ([sessionRequests count] > 0) {
        [self sendRequest: [sessionRequests firstObject]];
    } else {
        // TODO call observers
        NSLog(@"Done with session");
    }
}

/**
* Handles a chunk of data and either triggers the processing of the response (if we have all the packet)
* or it accumulates the data until we receive the rest.
*/
- (void)handleDataAndFillBuffer:(NSData *)responseData {
    [responseBuffer appendData:responseData];
    NSLog(@"Added [%lu] bytes to buffer for total of [%lu] bytes", [responseData length], [responseBuffer length]);

    if ([responseBuffer length] == expectedResponseSize) {
        NSLog(@"Packet fully received: [%s]",
                [[EncodingUtils bytesToString:[responseData bytes] withSize:[responseData length]] UTF8String]);

        ResponseHeader *header = currentResponseHeader;
        NSData *data = [[NSData alloc] initWithData:responseBuffer];

        // Reset state
        responseBuffer = nil;
        currentResponseHeader = nil;
        expectedResponseSize = 0;

        // Packet done, decode the response
        [self handleResponseData:data withHeader:header];
    }
}

- (NSArray *)newRequestsFromResponse:(ReceiverResponse *)response toRequest:(ReceiverRequest *)request {
    switch(request.command) {
        case ReadDatabasePageRange: {
            PageRange *pageRange = (PageRange *)response.payload;
            return [DataPaginator getDatabasePagesRequestsForRecordType:pageRange.recordType andPageRange:pageRange];
        }
        case ReadDatabasePages:
            return nil;
        default:
            return nil;
    }
}

- (void)serialPortWasRemovedFromSystem:(ORSSerialPort *)serialPort {
    NSLog(@"serial port disconnected: %s\n", [serialPort.name UTF8String]);
}

- (void)serialPort:(ORSSerialPort *)serialPort didEncounterError:(NSError *)error {
    NSLog(@"Error: %@", error);
}

- (void)serialPortWasOpened:(ORSSerialPort *)serialPort {
    NSLog(@"Serial port open: %s\n", [[serialPort name] UTF8String]);
}

- (void)serialPortWasClosed:(ORSSerialPort *)serialPort {
    NSLog(@"Serial port closed: %s\n", [[serialPort name] UTF8String]);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"%s %@ %@", __PRETTY_FUNCTION__, object, keyPath);
    NSLog(@"Change dictionary: %@", change);

    NSString *portName = ((ORSSerialPort *) object).name;
    if (port == nil) {
        NSLog(@"Port not open, this must mean this CTS change is for another device [%s]", [portName UTF8String]);
    }

    if (![portName isEqual:port.name]) {
        NSLog(@"Received CTS change for another device [%s], ignoring...", [portName UTF8String]);
        return;
    }

    [self sendRequest:[sessionRequests firstObject]];
}

- (void)sendRequest:(ReceiverRequest *)request {
    currentRequest = request;

    void const *bytes = [encoder encodeRequest:request];
    NSData *dataToSend = [NSData dataWithBytes:bytes length:request.getCommandSize];
    char const *bytesAsString = [[EncodingUtils bytesToString:(Byte *)bytes withSize:request.getCommandSize] UTF8String];
    NSLog(@"Sending request to the device: %@\n", request);
    BOOL status = [port sendData:dataToSend];
    NSLog(@"Sent [%s] bytes to the device with status: %s\n", bytesAsString, !status ? "false" : "true");
}


@end