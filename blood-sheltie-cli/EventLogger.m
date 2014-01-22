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
- (instancetype)initWithSessionController:(NSObject <ORSSerialPortDelegate> *)sessionController {
    self = [super init];
    if (self) {
        _sessionController = sessionController;
    }

    return self;
}

+ (instancetype)loggerWithDelegate:(NSObject <ORSSerialPortDelegate> *)delegate {
    return [[self alloc] initWithSessionController:delegate];
}


- (void)receiverPlugged:(ReceiverEvent *)event {
    NSString *portDevice = [event.devicePath copy];
    ORSSerialPort *port = [ORSSerialPort serialPortWithPath:portDevice];
    [port setDelegate:self.sessionController];
    [port setBaudRate:@115200];
    [port setNumberOfStopBits:1];
    [port setParity:ORSSerialPortParityNone];
    [port setUsesRTSCTSFlowControl:true];
    [port setRTS:true];
    [port setDTR:true];
    [port open];

    [port addObserver:self.sessionController forKeyPath:@"CTS" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];

    NSLog(@"Opened the device after receiving event: %s, port open? %s\n", [portDevice UTF8String],
            [port isOpen] ? "true" : "false");
    NSLog(@"Is clear to send? [%s]\n", [port CTS] ? "true" : "false");

    //[NSThread sleepForTimeInterval:30.0f];
    //[port close];
}

- (void)receiverUnplugged:(ReceiverEvent *)event {
    NSLog(@"Received a received unplugged event: %s\n", [event.devicePath UTF8String]);
}

- (void)syncStarted:(ReceiverEvent *)event {
    NSLog(@"Received a sync started event: %s\n", [event.devicePath UTF8String]);
}

- (void)errorReadingReceiver:(ReceiverEvent *)event {
    NSLog(@"Received an error reading receiver event: %s\n", [event.devicePath UTF8String]);
}

- (void)syncProgress:(ReceiverEvent *)event {
    NSLog(@"Received a sync progress event: %s\n", [event.devicePath UTF8String]);
}

@end
