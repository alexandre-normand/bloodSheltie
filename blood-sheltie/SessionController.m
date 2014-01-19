//
// Created by Alexandre Normand on 1/17/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import "SessionController.h"
#import "EncodingUtils.h"
#import "DefaultEncoder.h"
#import "ReceiverRequest.h"
#import "ReadDatabasePageRangeRequest.h"


@implementation SessionController {

    ORSSerialPort *port;
}

@synthesize port;

- (void)serialPort:(ORSSerialPort *)serialPort didReceiveData:(NSData *)data {
    printf("Received data: %s", [[EncodingUtils bytesToString:(Byte *)[data bytes] withSize:data.length] UTF8String]);
}

- (void)serialPortWasRemovedFromSystem:(ORSSerialPort *)serialPort {
    printf("serial port disconnected: %s", [serialPort.name UTF8String]);
}

- (void)serialPort:(ORSSerialPort *)serialPort didEncounterError:(NSError *)error {
    NSLog(@"Error: %@", error);
}

- (void)serialPortWasOpened:(ORSSerialPort *)serialPort {
    port = serialPort;
    printf("SessionController saw port open: %s", [[serialPort name] UTF8String]);
}

- (void)serialPortWasClosed:(ORSSerialPort *)serialPort {
    printf("SessionController saw port closed: %s", [[serialPort name] UTF8String]);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"%s %@ %@", __PRETTY_FUNCTION__, object, keyPath);
    NSLog(@"Change dictionary: %@", change);

    DefaultEncoder *encoder = [[DefaultEncoder alloc] init];
    ReceiverRequest *request = [[ReadDatabasePageRangeRequest alloc] initWithRecordType:ManufacturingData];
    void const *bytes = [encoder encodeRequest:request];
    NSData *dataToSend = [NSData dataWithBytes:&bytes length:request.getCommandSize];
    printf("Sending request to the device: %s\n", [[EncodingUtils bytesToString:(Byte *)bytes withSize:request.getCommandSize] UTF8String]);
    BOOL status = [port sendData:dataToSend];
    printf("Sent manufacturing data request to the device: %s\n", !status ? "false" : "true");

}


@end