//
// Created by Alexandre Normand on 1/14/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import "ReadDatabasePageRangeRequest.h"


@implementation ReadDatabasePageRangeRequest {

}
- (instancetype)initWithRecordType:(RecordType)recordType {
    self = [super initWithCommand: ReadDatabasePageRange];
    if (self) {
        _recordType = recordType;
        _commandSize = 7;
    }

    return self;
}

+ (instancetype)requestWithRecordType:(RecordType)recordType {
    return [[self alloc] initWithRecordType:recordType];
}

- (NSString *)description {
    return [NSString stringWithFormat: @"%s recordType=%s", [[super description] UTF8String],
                    [[Types recordTypeIdentifier:_recordType] UTF8String]];
}
@end