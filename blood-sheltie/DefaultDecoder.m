//
// Created by Alexandre Normand on 1/16/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import "DefaultDecoder.h"
#import "ReceiverResponse.h"
#import "ResponsePayload.h"


@implementation DefaultDecoder {

}
- (ReceiverResponse *)decodeResponse:(NSData *)response {
    NSUInteger currentPosition = 0;
    NSData *headerData = [response subdataWithRange:NSMakeRange(currentPosition, 4)];
    currentPosition += 4;

    ResponseHeader *header = [self decodeHeader:headerData];
    ReceiverResponse *receiverResponse = [[ReceiverResponse alloc] initWithHeader:header andPayload:nil];

    return receiverResponse;
}

- (ResponseHeader *) decodeHeader:(NSData *)header {
    NSUInteger currentPosition = 0;
    Byte sof;
    [header getBytes:&sof range:NSMakeRange(0, 1)];
    if (sof != 1) {
        NSLog(@"Invalid value [%d] for sof, always expecting 1", sof);
        return nil;
    }
    currentPosition++;

    uint16_t packetLength;
    [header getBytes:&packetLength range:NSMakeRange(currentPosition, 2)];
    packetLength = CFSwapInt16LittleToHost(packetLength);
    NSLog(@"Packet length is [%d]", packetLength);
    currentPosition += 2;

    ReceiverCommand command;
    [header getBytes:&command range:NSMakeRange(currentPosition, 1)];
    return [[ResponseHeader alloc] initWithCommand:command packetSize:packetLength];
}

@end