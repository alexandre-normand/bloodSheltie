//
// Created by Alexandre Normand on 1/16/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseHeader.h"
#import "ResponsePayload.h"

@interface ReceiverResponse : NSObject
@property(readonly) ResponseHeader *header;
@property(readonly) ResponsePayload *payload;
@end