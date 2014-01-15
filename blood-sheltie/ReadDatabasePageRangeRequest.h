//
// Created by Alexandre Normand on 1/14/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReceiverRequest.h"


@interface ReadDatabasePageRangeRequest : ReceiverRequest
@property(readonly) RecordType recordType;

- (instancetype)initWithRecordType:(RecordType)recordType;

+ (instancetype)requestWithRecordType:(RecordType)recordType;


@end