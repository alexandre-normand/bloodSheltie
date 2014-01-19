//
//  EventLogger.m
//  blood-sheltie
//
//  Created by Alexandre Normand on 1/7/2014.
//  Copyright (c) 2014 glukit. All rights reserved.
//

#import "EventLogger.h"
#import "ORSSerialPort.h"
#import "EncodingUtils.h"
#import "DefaultEncoder.h"
#import "ReadDatabasePageRangeRequest.h"
#import "SessionController.h"
#import "ORSSerialPortManager.h"

@implementation EventLogger

- (void)receiverPlugged:(ReceiverEvent *)event {
    NSString *portDevice = event.devicePath;
    ORSSerialPort *port = [ORSSerialPort serialPortWithPath:portDevice];
    SessionController *delegate = [[SessionController alloc] init];
    [port addObserver:delegate forKeyPath:@"CTS" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];

    [port setDelegate:delegate];
    [port setBaudRate:@9600];
    [port setNumberOfStopBits:1];
    [port setParity:ORSSerialPortParityNone];
    [port setShouldEchoReceivedData:true];
//    [port setRTS:true];
//    [port setDTR:false];
    [port setUsesRTSCTSFlowControl:true];
    [port open];

    printf("Opened the device after receiving event: %s, port open? %s\n", [portDevice UTF8String],
            [port isOpen] ? "true" : "false");
    printf("Is clear to send? [%s]\n", [port CTS] ? "true" : "false");

    [NSThread sleepForTimeInterval:30.0f];
    //[port close];
    printf("Closed the device after receiving event: %s\n", [portDevice UTF8String]);
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
