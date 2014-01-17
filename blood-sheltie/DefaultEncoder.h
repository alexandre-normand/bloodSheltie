//
// Created by Alexandre Normand on 1/9/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ReceiverRequest;


@interface DefaultEncoder : NSObject
- (const void *)encodeRequest:(ReceiverRequest *)request;
@end