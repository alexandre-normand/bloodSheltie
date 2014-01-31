//
// Created by Alexandre Normand on 1/23/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import "PageRange.h"
#import "Types.h"


@implementation PageRange {

}
- (instancetype)initWithFirstPage:(uint32_t)firstPage lastPage:(uint32_t)lastPage ofRecordType:(RecordType)recordType {
    self = [super init];
    if (self) {
        _firstPage = firstPage;
        _lastPage=lastPage;
        _recordType=recordType;
    }

    return self;
}

+ (instancetype)rangeWithFirstPage:(uint32_t)firstPage lastPage:(uint32_t)lastPage ofRecordType:(RecordType)recordType {
    return [[self alloc] initWithFirstPage:firstPage lastPage:lastPage ofRecordType:recordType];
}

- (NSString *)description {
    return [NSString stringWithFormat: @"[PageRange] firstPage=%d lastPage=%d recordType=%s", _firstPage, _lastPage,
                    [[Types recordTypeIdentifier:_recordType] UTF8String]];
}

@end