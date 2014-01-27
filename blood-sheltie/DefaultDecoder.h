//
// Created by Alexandre Normand on 1/16/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReceiverResponse.h"


static const int PAGE_HEADER_SIZE = 28;

@interface DefaultDecoder : NSObject

- (ReceiverResponse *)decodeResponse:(NSData *)response forCommand:(ReceiverCommand)command;
@end