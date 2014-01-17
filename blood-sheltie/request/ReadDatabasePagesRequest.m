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

@end