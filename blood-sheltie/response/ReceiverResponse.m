//
// Created by Alexandre Normand on 1/16/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import "ReceiverResponse.h"


@implementation ReceiverResponse {

}
- (instancetype)initWithHeader:(ResponseHeader *)header andPayload:(ResponsePayload *)payload {
    self = [super init];
    if (self) {
        _header = header;
        _payload=payload;
    }

    return self;
}

+ (instancetype)responseWithHeader:(ResponseHeader *)header andPayload:(ResponsePayload *)payload {
    return [[self alloc] initWithHeader:header andPayload:payload];
}

- (NSString *)description {
    return [NSString stringWithFormat: @"Response: Header=%@ Payload=%@", _header, _payload];
}

@end