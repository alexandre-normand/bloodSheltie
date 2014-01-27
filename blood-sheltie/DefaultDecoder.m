//
// Created by Alexandre Normand on 1/16/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import "DefaultDecoder.h"
#import "PageRange.h"
#import "EncodingUtils.h"
#import "RecordData.h"


@interface PagesPayloadHeader : NSObject
@property uint32_t firstRecordIndex;
@property uint32_t numberOfRecords;
@property RecordType recordType;
@property Byte revision;
@property uint32_t pageNumber;
@property uint32_t reserved2;
@property uint32_t reserved3;
@property uint32_t reserved4;
@property CRC crc;

- (instancetype)initWithFirstRecordIndex:(uint32_t)firstRecordIndex numberOfRecords:(uint32_t)numberOfRecords recordType:(RecordType)recordType revision:(Byte)revision pageNumber:(uint32_t)pageNumber reserved2:(uint32_t)reserved2 reserved3:(uint32_t)reserved3 reserved4:(uint32_t)reserved4 crc:(CRC)crc;

+ (instancetype)headerWithFirstRecordIndex:(uint32_t)firstRecordIndex numberOfRecords:(uint32_t)numberOfRecords recordType:(RecordType)recordType revision:(Byte)revision pageNumber:(uint32_t)pageNumber reserved2:(uint32_t)reserved2 reserved3:(uint32_t)reserved3 reserved4:(uint32_t)reserved4 crc:(CRC)crc;

@end

@implementation PagesPayloadHeader
- (instancetype)initWithFirstRecordIndex:(uint32_t)firstRecordIndex numberOfRecords:(uint32_t)numberOfRecords recordType:(RecordType)recordType revision:(Byte)revision pageNumber:(uint32_t)pageNumber reserved2:(uint32_t)reserved2 reserved3:(uint32_t)reserved3 reserved4:(uint32_t)reserved4 crc:(CRC)crc {
    self = [super init];
    if (self) {
        self.firstRecordIndex = firstRecordIndex;
        self.numberOfRecords = numberOfRecords;
        self.recordType = recordType;
        self.revision = revision;
        self.pageNumber = pageNumber;
        self.reserved2 = reserved2;
        self.reserved3 = reserved3;
        self.reserved4 = reserved4;
        self.crc = crc;
    }

    return self;
}

+ (instancetype)headerWithFirstRecordIndex:(uint32_t)firstRecordIndex numberOfRecords:(uint32_t)numberOfRecords recordType:(RecordType)recordType revision:(Byte)revision pageNumber:(uint32_t)pageNumber reserved2:(uint32_t)reserved2 reserved3:(uint32_t)reserved3 reserved4:(uint32_t)reserved4 crc:(CRC)crc {
    return [[self alloc] initWithFirstRecordIndex:firstRecordIndex numberOfRecords:numberOfRecords recordType:recordType revision:revision pageNumber:pageNumber reserved2:reserved2 reserved3:reserved3 reserved4:reserved4 crc:crc];
}

- (NSString *)description {
    return [NSString stringWithFormat: @"recordType=%s pageNumber=%d firstRecordindex=%d numberOfRecords=%d revision=%d", [[Types recordTypeIdentifier:_recordType] UTF8String],
                                       _pageNumber, _firstRecordIndex, _numberOfRecords, _revision];
}
@end

@implementation DefaultDecoder {

}

- (ReceiverResponse *)decodeResponse:(NSData *)response forCommand:(ReceiverCommand)command {
    NSLog(@"Decoding response for command %s", [[Types receiverCommandIdentifier:command] UTF8String]);

    NSUInteger currentPosition = 0;
    NSData *headerData = [response subdataWithRange:NSMakeRange(currentPosition, 4)];
    currentPosition += 4;

    ResponseHeader *header = [self decodeHeader:headerData];
    ResponsePayload *payload = [self decodePayload:[response subdataWithRange:NSMakeRange(currentPosition, response.length - currentPosition)]
                                        andCommand:command];

    ReceiverResponse *receiverResponse = [[ReceiverResponse alloc] initWithHeader:header andPayload:payload];

    return receiverResponse;
}

- (ResponseHeader *)decodeHeader:(NSData *)header {
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

- (ResponsePayload *)decodePayload:(NSData *)payload andCommand:(ReceiverCommand)command {
    switch (command) {
        case ReadDatabasePageRange: {
            NSUInteger currentPosition = 0;
            uint32_t firstPage;
            [payload getBytes:&firstPage range:NSMakeRange(currentPosition, sizeof(uint32_t))];
            firstPage = CFSwapInt32LittleToHost(firstPage);
            currentPosition += sizeof(uint32_t);

            uint32_t lastPage;
            [payload getBytes:&lastPage range:NSMakeRange(currentPosition, sizeof(uint32_t))];
            lastPage = CFSwapInt32LittleToHost(lastPage);

            PageRange *range = [[PageRange alloc] initWithFirstPage:firstPage lastPage:lastPage];
            return range;
        }

        case ReadDatabasePages: {
            NSData *pageHeaderData = [payload subdataWithRange:NSMakeRange(0, PAGE_HEADER_SIZE)];

            PagesPayloadHeader *pageHeader = [self readPageHeader: pageHeaderData];
            RecordData *recordData = [[RecordData alloc] initWithRecordType:pageHeader.recordType records:nil];
            return recordData;
        }

        default: {
            return nil;
        }
    }

    return nil;
}

- (PagesPayloadHeader *)readPageHeader:(NSData *)data {
    NSUInteger currentPosition = 0;

    uint32_t firstRecordIndex;
    [data getBytes:&firstRecordIndex range:NSMakeRange(currentPosition, sizeof(uint32_t))];
    firstRecordIndex = CFSwapInt32LittleToHost(firstRecordIndex);
    currentPosition += sizeof(uint32_t);

    uint32_t numberOfRecords;
    [data getBytes:&numberOfRecords range:NSMakeRange(currentPosition, sizeof(uint32_t))];
    numberOfRecords = CFSwapInt32LittleToHost(numberOfRecords);
    currentPosition += sizeof(uint32_t);

    RecordType recordType;
    [data getBytes:&recordType range:NSMakeRange(currentPosition, sizeof(RecordType))];
    currentPosition += sizeof(RecordType);

    Byte revision;
    [data getBytes:&revision range:NSMakeRange(currentPosition, sizeof(Byte))];
    currentPosition += sizeof(Byte);

    uint32_t pageNumber;
    [data getBytes:&pageNumber range:NSMakeRange(currentPosition, sizeof(uint32_t))];
    pageNumber = CFSwapInt32LittleToHost(pageNumber);
    currentPosition += sizeof(uint32_t);

    uint32_t reserved2;
    [data getBytes:&reserved2 range:NSMakeRange(currentPosition, sizeof(uint32_t))];
    reserved2 = CFSwapInt32LittleToHost(reserved2);
    currentPosition += sizeof(uint32_t);

    uint32_t reserved3;
    [data getBytes:&reserved3 range:NSMakeRange(currentPosition, sizeof(uint32_t))];
    reserved3 = CFSwapInt32LittleToHost(reserved3);
    currentPosition += sizeof(uint32_t);

    uint32_t reserved4;
    [data getBytes:&reserved4 range:NSMakeRange(currentPosition, sizeof(uint32_t))];
    reserved4 = CFSwapInt32LittleToHost(reserved4);
    currentPosition += sizeof(uint32_t);

    CRC crc;
    [data getBytes:&crc range:NSMakeRange(currentPosition, sizeof(CRC))];
    crc = CFSwapInt16LittleToHost(crc);

    CRC expectedCrc = [EncodingUtils crc16:data withOffset:0 andLength:PAGE_HEADER_SIZE - 2];


    if (crc != expectedCrc) {
        // TODO throw proper exception with something like "invalid crc, expected [%s]. received [%s].

    }

    return [[PagesPayloadHeader alloc] initWithFirstRecordIndex:firstRecordIndex
                                                numberOfRecords:numberOfRecords
                                                     recordType:recordType
                                                       revision:revision
                                                     pageNumber:pageNumber
                                                      reserved2:reserved2
                                                      reserved3:reserved3
                                                      reserved4:reserved4
                                                            crc:crc];
}

@end