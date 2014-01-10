//
// Created by Alexandre Normand on 1/9/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import "ReceiverRequest.h"


@implementation ReceiverRequest {

}
- (id)initWithCommand:(ReceiverCommand)command {
    if (self = [super init]) {
        _command = command;
        _commandSize = 6;
        _sizeOfField = 1;
    }

    return self;
}

@end