//
//  EventLogger.h
//  blood-sheltie
//
//  Created by Alexandre Normand on 1/7/2014.
//  Copyright (c) 2014 glukit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReceiverObserver.h"

@protocol ORSSerialPortDelegate;

@interface EventLogger : NSObject<ReceiverObserver>
@property(readonly) NSObject<ORSSerialPortDelegate> *sessionController;

- (instancetype)initWithSessionController:(NSObject <ORSSerialPortDelegate> *)sessionController;

+ (instancetype)loggerWithDelegate:(NSObject <ORSSerialPortDelegate> *)delegate;

@end
