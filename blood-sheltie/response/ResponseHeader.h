//
// Created by Alexandre Normand on 1/16/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Common.h"


@interface ResponseHeader : NSObject
@property(readonly) ReceiverCommand command;
@property(readonly) uint16_t packetSize;

- (instancetype)initWithCommand:(ReceiverCommand)command packetSize:(uint16_t)packetSize;

+ (instancetype)headerWithCommand:(ReceiverCommand)command packetSize:(uint16_t)packetSize;

@end