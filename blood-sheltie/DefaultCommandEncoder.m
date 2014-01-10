//
// Created by Alexandre Normand on 1/9/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import "DefaultCommandEncoder.h"
#import "ReceiverRequest.h"


@implementation DefaultCommandEncoder {

}
- (const void *)encodeRequest:(ReceiverRequest *)request {
    NSMutableData *encodedData = [NSMutableData dataWithCapacity:request.commandSize];
    [encodedData appendBytes:(void const *) request.sizeOfField length:1];
    [encodedData appendBytes:(void const *) CFSwapInt16HostToLittle(request.commandSize) length:sizeof(request.commandSize)];
    [encodedData appendBytes:(void const *) request.command length:1];
    // No content

    // Calculate crc16
    void const *crc16 = 0;
    [encodedData appendBytes:crc16 length:sizeof(crc16)];
    return NULL;
}

@end