//
// Created by Alexandre Normand on 1/9/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Common.h"

@interface ReceiverRequest : NSObject
@property(readonly) Byte sizeOfField;
@property(readonly) uint16_t commandSize;
@property(readonly) ReceiverCommand command;

- (id)initWithCommand:(ReceiverCommand) command;
@end