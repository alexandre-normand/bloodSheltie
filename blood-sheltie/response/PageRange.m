//
// Created by Alexandre Normand on 1/23/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import "PageRange.h"


@implementation PageRange {

}
- (instancetype)initWithFirstPage:(uint32_t)firstPage lastPage:(uint32_t)lastPage {
    self = [super init];
    if (self) {
        _firstPage = firstPage;
        _lastPage=lastPage;
    }

    return self;
}

+ (instancetype)rangeWithFirstPage:(uint32_t)firstPage lastPage:(uint32_t)lastPage {
    return [[self alloc] initWithFirstPage:firstPage lastPage:lastPage];
}

- (NSString *)description {
    return [NSString stringWithFormat: @"[PageRange] firstPage=%d lastPage=%d", _firstPage, _lastPage];
}

@end