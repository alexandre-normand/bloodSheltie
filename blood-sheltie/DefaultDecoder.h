//
// Created by Alexandre Normand on 1/16/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponsePayload.h"


@interface DefaultDecoder : NSObject

- (ResponsePayload *)decodePayload:(Byte *)response;
@end