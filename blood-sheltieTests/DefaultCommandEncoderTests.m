//
//  DefaultCommandEncoderTests.m
//  blood-sheltie
//
//  Created by Alexandre Normand on 1/13/2014.
//  Copyright (c) 2014 glukit. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DefaultEncoder.h"
#import "ReceiverRequest.h"
#import "Types.h"
#import "EncodingUtils.h"
#import "ReadDatabasePageRangeRequest.h"
#import "ReadDatabasePagesRequest.h"

@interface DefaultCommandEncoderTests : XCTestCase

@end

@implementation DefaultCommandEncoderTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPingEncoding {
    DefaultEncoder *encoder = [[DefaultEncoder alloc] init];
    Byte *actual = (Byte *)[encoder encodeRequest:[[ReceiverRequest alloc] initWithCommand:Ping]];

    Byte *expected = (Byte *)[[EncodingUtils dataFromHexString:@"01 06 00 0A 5E 65"] bytes];
    printf("encoded packet is: %s", [[EncodingUtils bytesToString:actual withSize:6] UTF8String]);
    XCTAssertTrue(memcmp(actual, expected, 6) == 0);
}

- (void)testReadDatabasePageRangeGlucoseData {
    DefaultEncoder *encoder = [[DefaultEncoder alloc] init];
    Byte *actual = (Byte *)[encoder encodeRequest:[[ReadDatabasePageRangeRequest alloc] initWithRecordType:EGVData]];

    Byte *expected = (Byte *)[[EncodingUtils dataFromHexString:@"01 07 00 10 04 8b b8"] bytes];
    printf("encoded packet is: %s", [[EncodingUtils bytesToString:actual withSize:7] UTF8String]);
    XCTAssertTrue(memcmp(actual, expected, 7) == 0);
}

- (void)testReadDatabasePageRangeManufacturingData {
    DefaultEncoder *encoder = [[DefaultEncoder alloc] init];
    Byte *actual = (Byte *)[encoder encodeRequest:[[ReadDatabasePageRangeRequest alloc] initWithRecordType:ManufacturingData]];

    Byte *expected = (Byte *)[[EncodingUtils dataFromHexString:@"01 07 00 10 00 0F F8"] bytes];
    printf("encoded packet is: %s", [[EncodingUtils bytesToString:actual withSize:7] UTF8String]);
    XCTAssertTrue(memcmp(actual, expected, 7) == 0);
}

- (void)testReadDatabasePageRangeUserData {
    DefaultEncoder *encoder = [[DefaultEncoder alloc] init];
    Byte *actual = (Byte *)[encoder encodeRequest:[[ReadDatabasePageRangeRequest alloc] initWithRecordType:UserEventData]];

    Byte *expected = (Byte *)[[EncodingUtils dataFromHexString:@"01 07 00 10 0b 64 49"] bytes];
    printf("encoded packet is: %s", [[EncodingUtils bytesToString:actual withSize:7] UTF8String]);
    XCTAssertTrue(memcmp(actual, expected, 7) == 0);
}

- (void)testReadDatabasePagesGlucoseData {
    DefaultEncoder *encoder = [[DefaultEncoder alloc] init];
    Byte *actual = (Byte *)[encoder encodeRequest:[[ReadDatabasePagesRequest alloc] initWithRecordType:EGVData pageNumber: 1465 numberOfPages:4]];

    Byte *expected = (Byte *)[[EncodingUtils dataFromHexString:@"01 0C 00 11 04 B9 05 00 00 04 6D 29"] bytes];
    printf("encoded packet is: %s", [[EncodingUtils bytesToString:actual withSize:12] UTF8String]);
    XCTAssertTrue(memcmp(actual, expected, 12) == 0);
}

- (void)testReadDatabasePagesUserData {
    DefaultEncoder *encoder = [[DefaultEncoder alloc] init];
    Byte *actual = (Byte *)[encoder encodeRequest:[[ReadDatabasePagesRequest alloc] initWithRecordType:UserEventData pageNumber: 1465 numberOfPages:4]];

    Byte *expected = (Byte *)[[EncodingUtils dataFromHexString:@"01 0c 00 11 0b b9 05 00 00 04 6e ec"] bytes];
    printf("encoded packet is: %s", [[EncodingUtils bytesToString:actual withSize:12] UTF8String]);
    XCTAssertTrue(memcmp(actual, expected, 12) == 0);
}

- (void)testReadDatabasePagesManufacturingData {
    DefaultEncoder *encoder = [[DefaultEncoder alloc] init];
    Byte *actual = (Byte *)[encoder encodeRequest:[[ReadDatabasePagesRequest alloc] initWithRecordType:ManufacturingData pageNumber: 0 numberOfPages:1]];

    Byte *expected = (Byte *)[[EncodingUtils dataFromHexString:@"01 0C 00 11 00 00 00 00 00 01 6E 45"] bytes];
    printf("encoded packet is: %s", [[EncodingUtils bytesToString:actual withSize:12] UTF8String]);
    XCTAssertTrue(memcmp(actual, expected, 12) == 0);
}

@end
