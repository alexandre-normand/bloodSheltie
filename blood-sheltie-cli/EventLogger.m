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
    ORSSerialPort *port = [ORSSerialPort serialPortWithPath:event.devicePath];
    SessionController *delegate = [[SessionController alloc] init];
    [port setDelegate:delegate];
    [port setBaudRate:@9600];
    [port setNumberOfStopBits:1];
    [port setParity:ORSSerialPortParityNone];
    [port setShouldEchoReceivedData:true];

    [port open];

    printf("Opened the device after receiving event: %s, port open? %s\n", [event.devicePath UTF8String],
            [port isOpen] ? "true" : "false");
    DefaultEncoder *encoder = [[DefaultEncoder alloc] init];
    ReceiverRequest *request = [[ReadDatabasePageRangeRequest alloc] initWithRecordType:ManufacturingData];
    void const *bytes = [encoder encodeRequest:request];
    NSData *dataToSend = [NSData dataWithBytes:&bytes length:request.getCommandSize];
    printf("Sending request to the device: %s\n", [[EncodingUtils bytesToString:bytes :request.getCommandSize] UTF8String]);
    BOOL status = [port sendData:dataToSend];
    printf("Sent manufacturing data request to the device: %s\n", !status ? "false" : "true");
    printf("Closed the device after receiving event: %s\n", [event.devicePath UTF8String]);
    char buf[256];
    long lengthRead = read([port descriptor], buf, sizeof(buf));
    if (lengthRead > 0) {
        NSData *readData = [NSData dataWithBytes:buf length:lengthRead];
        if (readData != nil)
            [delegate serialPort:port didReceiveData:readData];

    }
    [NSThread sleepForTimeInterval:10.0f];
    [port close];
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
