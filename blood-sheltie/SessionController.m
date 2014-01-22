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
    NSLog(@"Received data: %s\n", [[EncodingUtils bytesToString:(Byte *)[data bytes] withSize:data.length] UTF8String]);
}

- (void)serialPortWasRemovedFromSystem:(ORSSerialPort *)serialPort {
    NSLog(@"serial port disconnected: %s\n", [serialPort.name UTF8String]);
}

- (void)serialPort:(ORSSerialPort *)serialPort didEncounterError:(NSError *)error {
    NSLog(@"Error: %@", error);
}

- (void)serialPortWasOpened:(ORSSerialPort *)serialPort {
    port = serialPort;
    NSLog(@"SessionController saw port open: %s\n", [[serialPort name] UTF8String]);
}

- (void)serialPortWasClosed:(ORSSerialPort *)serialPort {
    NSLog(@"SessionController saw port closed: %s\n", [[serialPort name] UTF8String]);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"%s %@ %@", __PRETTY_FUNCTION__, object, keyPath);
    NSLog(@"Change dictionary: %@", change);

    NSString *portName = ((ORSSerialPort *) object).name;
    if (port == nil) {
        NSLog(@"Port not open, this must mean this CTS change is for another device [%s]", portName);
    }

    if (![portName isEqual:port.name]) {
        NSLog(@"Received CTS change for another device [%s], ignoring...", portName);
        return;
    }

    DefaultEncoder *encoder = [[DefaultEncoder alloc] init];
    ReceiverRequest *request = [[ReadDatabasePageRangeRequest alloc] initWithRecordType:ManufacturingData];
    void const *bytes = [encoder encodeRequest:request];
    NSData *dataToSend = [NSData dataWithBytes:bytes length:request.getCommandSize];
    NSLog(@"Sending request to the device: %s\n", [[EncodingUtils bytesToString:(Byte *)bytes withSize:request.getCommandSize] UTF8String]);
    BOOL status = [port sendData:dataToSend];
    NSLog(@"Sent manufacturing data request to the device: %s\n", !status ? "false" : "true");
}


@end