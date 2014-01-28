//
// Created by Alexandre Normand on 1/9/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Types.h"


@interface EncodingUtils : NSObject

+(CRC) crc16:(NSData *)packet withOffset:(uint16_t)offset andLength:(uint16_t)length;
+(NSData *) dataFromHexString: (NSString*)hexString;
+(CRC) getPacketCrc16:(NSData *)packet;
+(NSString *) bytesToString:(Byte *)bytes withSize:(size_t)size;

+ (bool)isCrcValid:(uint16_t)crc bytes:(NSData *)bytes;
@end