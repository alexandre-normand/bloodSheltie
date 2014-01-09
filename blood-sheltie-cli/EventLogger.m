//
//  EventLogger.m
//  blood-sheltie
//
//  Created by Alexandre Normand on 1/7/2014.
//  Copyright (c) 2014 glukit. All rights reserved.
//

#import "EventLogger.h"
#import "ORSSerialPort.h"

@implementation EventLogger

- (void)receiverPlugged:(ReceiverEvent *)event {
    ORSSerialPort *port = [ORSSerialPort serialPortWithPath:event.devicePath];
    [port setBaudRate:@9600];
    [port setNumberOfStopBits:1];
    [port setParity:ORSSerialPortParityNone];
    [port open];

    printf("Opened the device after receiving event: %s\n", [event.devicePath UTF8String]);


    [port close];
    printf("Closed the device after receiving event: %s\n", [event.devicePath UTF8String]);
}

- (void)receiverUnplugged:(ReceiverEvent *)event {
    printf("Received a received unplugged event: %s\n", [event.devicePath UTF8String]);
}

- (void)syncStarted:(ReceiverEvent *)event {
    printf("Received a sync started event: %s\n", [event.devicePath UTF8String]);
}

- (void)errorReadingReceiver:(ReceiverEvent *)event {
    printf("Received an error reading receiver event: %s\n", [event.devicePath UTF8String]);
}

- (void)syncProgress:(ReceiverEvent *)event {
    printf("Received a sync progress event: %s\n", [event.devicePath UTF8String]);
}

@end
