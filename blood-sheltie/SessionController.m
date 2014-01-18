//
// Created by Alexandre Normand on 1/17/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import "SessionController.h"
#import "EncodingUtils.h"


@implementation SessionController {

}

- (void)serialPort:(ORSSerialPort *)serialPort didReceiveData:(NSData *)data {
    printf("Received data: %s", [[EncodingUtils bytesToString:[data bytes] :data.length] UTF8String]);
}

- (void)serialPortWasRemovedFromSystem:(ORSSerialPort *)serialPort {
    printf("serial port disconnected: %s", [serialPort.name UTF8String]);
}

- (void)serialPort:(ORSSerialPort *)serialPort didEncounterError:(NSError *)error {
    NSLog(@"Error: %@", error);
}

- (void)serialPortWasOpened:(ORSSerialPort *)serialPort {
    printf("SessionController saw port open: %s", [[serialPort name] UTF8String]);
}

- (void)serialPortWasClosed:(ORSSerialPort *)serialPort {
    printf("SessionController saw port closed: %s", [[serialPort name] UTF8String]);
}

@end