//
// Created by Alexandre Normand on 1/9/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import "DefaultCommandEncoder.h"
#import "ReceiverRequest.h"
#import "EncodingUtils.h"


@implementation DefaultCommandEncoder {

}
- (const void *)encodeRequest:(ReceiverRequest *)request {
    NSMutableData *encodedData = [NSMutableData dataWithCapacity:request.commandSize];
    Byte byte = request.sizeOfField;
    [encodedData appendBytes:(void const *) &byte length:1];
    uint16_t commandSize = CFSwapInt16HostToLittle(request.commandSize);
    [encodedData appendBytes:(void const *) &commandSize length:sizeof(request.commandSize)];
    ReceiverCommand command = request.command;
    [encodedData appendBytes:(void const *) &command length:1];
    // No content

    // Calculate crc16
    uint16_t crc16 = CFSwapInt16HostToLittle([EncodingUtils crc16:encodedData :0 :(uint16_t) encodedData.length]);
    printf("crc is %d\n", crc16);
    [encodedData appendBytes:(void const *) &crc16 length:sizeof(crc16)];
    return [encodedData bytes];
}

@end