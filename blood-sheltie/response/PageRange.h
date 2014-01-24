//
// Created by Alexandre Normand on 1/23/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponsePayload.h"


@interface PageRange : ResponsePayload
@property(readonly) uint32_t firstPage;
@property(readonly) uint32_t lastPage;

- (instancetype)initWithFirstPage:(uint32_t)firstPage lastPage:(uint32_t)lastPage;

+ (instancetype)rangeWithFirstPage:(uint32_t)firstPage lastPage:(uint32_t)lastPage;

@end