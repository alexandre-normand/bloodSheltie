//
// Created by Alexandre Normand on 1/16/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import "ResponseHeader.h"


@implementation ResponseHeader {

}
- (instancetype)initWithCommand:(ReceiverCommand)command packetSize:(uint16_t)packetSize {
    self = [super init];
    if (self) {
        _command = command;
        _packetSize=packetSize;
    }

    return self;
}

+ (instancetype)headerWithCommand:(ReceiverCommand)command packetSize:(uint16_t)packetSize {
    return [[self alloc] initWithCommand:command packetSize:packetSize];
}

@end