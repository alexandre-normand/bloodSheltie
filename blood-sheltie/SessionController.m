//
// Created by Alexandre Normand on 1/17/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import "SessionController.h"
#import "EncodingUtils.h"
#import "DefaultEncoder.h"
#import "ReceiverRequest.h"
#import "ReadDatabasePageRangeRequest.h"
#import "FreshDataFetcher.h"


@implementation SessionController {
    FreshDataFetcher *fetcher;
}

- (void)receiverPlugged:(ReceiverEvent *)event {
    NSLog(@"Receiver plugged %s", [event.devicePath UTF8String]);
    fetcher = [[FreshDataFetcher alloc] initWithSerialPortPath:event.devicePath since:[NSDate dateWithTimeIntervalSince1970:0]];
    [fetcher run];
}

- (void)receiverUnplugged:(ReceiverEvent *)event {

}


@end