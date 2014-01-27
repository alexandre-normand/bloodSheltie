//
// Created by Alexandre Normand on 1/9/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import "DefaultEncoder.h"
#import "ReceiverRequest.h"
#import "EncodingUtils.h"
#import "ReadDatabasePageRangeRequest.h"
#import "ReadDatabasePagesRequest.h"


@implementation DefaultEncoder {

}
- (const void *)encodeRequest:(ReceiverRequest *)request {
    NSMutableData *encodedData = [NSMutableData dataWithCapacity:request.getCommandSize];
    Byte byte = request.sizeOfField;
    [encodedData appendBytes:(void const *) &byte length:1];
    uint16_t commandSize = CFSwapInt16HostToLittle(request.getCommandSize);
    [encodedData appendBytes:(void const *) &commandSize length:sizeof(request.getCommandSize)];
    ReceiverCommand command = request.command;
    [encodedData appendBytes:(void const *) &command length:1];

    [self encodeContent: encodedData : request];

    // Calculate crc16
    CRC crc16 = CFSwapInt16HostToLittle([EncodingUtils crc16:encodedData withOffset:0 andLength:(uint16_t) encodedData.length]);
    [encodedData appendBytes:(void const *) &crc16 length:sizeof(crc16)];
    return [encodedData bytes];
}

- (void)encodeContent:(NSMutableData *)data :(ReceiverRequest *)request {
    switch (request.command) {
        case ReadDatabasePageRange: {
            RecordType recordType = ((ReadDatabasePageRangeRequest *) request).recordType;
            [data appendBytes:(void const *) &recordType length:sizeof(recordType)];
            break;
        }
        case ReadDatabasePages: {
            ReadDatabasePagesRequest *databasePagesRequest = (ReadDatabasePagesRequest *) request;
            RecordType recordType = databasePagesRequest.recordType;
            [data appendBytes:(void const *) &recordType length:sizeof(recordType)];

            uint pageNumber = CFSwapInt32HostToLittle(databasePagesRequest.pageNumber);
            [data appendBytes:(void const *) &pageNumber length:sizeof(pageNumber)];

            Byte numberOfPages = databasePagesRequest.numberOfPages;
            [data appendBytes:(void const *) &numberOfPages length:sizeof(numberOfPages)];
            break;
        }
        default:
            // No content
            break;
    }
}

@end