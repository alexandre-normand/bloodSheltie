//
// Created by Alexandre Normand on 1/14/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import "ReadDatabasePagesRequest.h"


@implementation ReadDatabasePagesRequest {

}
- (instancetype)initWithRecordType:(RecordType)recordType pageNumber:(uint)pageNumber numberOfPages:(Byte)numberOfPages {
    self = [super initWithCommand:ReadDatabasePages];
    if (self) {
        _recordType = recordType;
        _pageNumber = pageNumber;
        _numberOfPages = numberOfPages;
        _commandSize = 12;
    }

    return self;
}

+ (instancetype)requestWithRecordType:(RecordType)recordType pageNumber:(uint)pageNumber numberOfPages:(Byte)numberOfPages {
    return [[self alloc] initWithRecordType:recordType pageNumber:pageNumber numberOfPages:numberOfPages];
}

- (NSString *)description {
    return [NSString stringWithFormat: @"%s recordType=%s pageNumber=%d numberOfPages=%d",
                    [[super description] UTF8String], [[Types recordTypeIdentifier:_recordType] UTF8String],
                    _pageNumber, _numberOfPages];
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToRequest:other];
}

- (BOOL)isEqualToRequest:(ReadDatabasePagesRequest *)request {
    if (self == request)
        return YES;
    if (request == nil)
        return NO;
    if (self.recordType != request.recordType)
        return NO;
    if (self.pageNumber != request.pageNumber)
        return NO;
    if (self.numberOfPages != request.numberOfPages)
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = (NSUInteger) self.recordType;
    hash = hash * 31u + self.pageNumber;
    hash = hash * 31u + self.numberOfPages;
    return hash;
}


@end