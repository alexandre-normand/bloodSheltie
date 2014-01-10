//
// Created by Alexandre Normand on 1/9/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface EncodingUtils : NSObject

-(uint16_t) crc16:(NSData *)data: (uint16_t) offset: (uint16_t) length;
@end