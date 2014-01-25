//
// Created by Alexandre Normand on 1/24/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ORSSerialPort.h"

@protocol DeviceObserver;
@class SessionData;
@protocol SessionObserver;


@interface FreshDataFetcher : NSObject<ORSSerialPortDelegate>
@property(readonly) NSDate *since;
@property(readonly) NSMutableArray *observers;
@property(readonly) NSString *serialPortPath;
@property(readonly) SessionData *sessionData;

- (instancetype)initWithSerialPortPath:(NSString *)serialPortPath since:(NSDate *)since;

+ (instancetype)fetcherWithSerialPortPath:(NSString *)serialPortPath since:(NSDate *)since;

-(void) registerObserver:(id<SessionObserver>) observer;

-(void) unregisterObserver:(id<SessionObserver>) observer;

-(void) run;

@end