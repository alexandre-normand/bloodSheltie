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
    // TODO: We know the size of the header, get the bytes for the whole header and split that into a function
    NSUInteger currentPosition = 0;
    Byte sof;
    [response getBytes:&sof range:NSMakeRange(0, 1)];
    if (sof != 1) {
        NSLog(@"Invalid value [%d] for sof, always expecting 1", sof);
        return nil;
    }
    currentPosition++;

    uint16_t packetLength;
    [response getBytes:&packetLength range:NSMakeRange(currentPosition, 2)];
    packetLength = CFSwapInt16LittleToHost(packetLength);
    NSLog(@"Packet length is [%d]", packetLength);
    currentPosition += 2;

    ReceiverCommand command;
    [response getBytes:&command range:NSMakeRange(currentPosition, 1)];
    currentPosition++;

    ResponseHeader *header = [[ResponseHeader alloc] initWithCommand:command packetSize:packetLength];
    ReceiverResponse *receiverResponse = [[ReceiverResponse alloc] initWithHeader:header andPayload:nil];

    return receiverResponse;
}

@end