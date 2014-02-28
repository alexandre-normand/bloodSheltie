#import <XCTest/XCTest.h>
#import "DefaultEncoder.h"
#import "ReceiverRequest.h"
#import "EncodingUtils.h"
#import "ReadDatabasePageRangeRequest.h"
#import "ReadDatabasePagesRequest.h"

@interface DefaultCommandEncoderTests : XCTestCase

@end

@implementation DefaultCommandEncoderTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testPingEncoding {
    DefaultEncoder *encoder = [[DefaultEncoder alloc] init];
    Byte *actual = (Byte *) [encoder encodeRequest:[[ReceiverRequest alloc] initWithCommand:Ping]];

    Byte *expected = (Byte *) [[EncodingUtils dataFromHexString:@"01 06 00 0A 5E 65"] bytes];
    XCTAssertTrue(memcmp(actual, expected, 6) == 0, @"Expected [%s] but received [%s]",
    [[EncodingUtils bytesToString:expected withSize:6] UTF8String],
    [[EncodingUtils bytesToString:actual withSize:6] UTF8String]);
}

- (void)testReadDatabasePageRangeGlucoseData {
    DefaultEncoder *encoder = [[DefaultEncoder alloc] init];
    Byte *actual = (Byte *) [encoder encodeRequest:[[ReadDatabasePageRangeRequest alloc] initWithRecordType:EGVData]];

    Byte *expected = (Byte *) [[EncodingUtils dataFromHexString:@"01 07 00 10 04 8b b8"] bytes];
    XCTAssertTrue(memcmp(actual, expected, 7) == 0, @"Expected [%s] but received [%s]",
    [[EncodingUtils bytesToString:expected withSize:7] UTF8String],
    [[EncodingUtils bytesToString:actual withSize:7] UTF8String]);
}

- (void)testReadDatabasePageRangeManufacturingData {
    DefaultEncoder *encoder = [[DefaultEncoder alloc] init];
    Byte *actual = (Byte *) [encoder encodeRequest:[[ReadDatabasePageRangeRequest alloc] initWithRecordType:ManufacturingData]];

    Byte *expected = (Byte *) [[EncodingUtils dataFromHexString:@"01 07 00 10 00 0F F8"] bytes];
    XCTAssertTrue(memcmp(actual, expected, 7) == 0, @"Expected [%s] but received [%s]",
    [[EncodingUtils bytesToString:expected withSize:7] UTF8String],
    [[EncodingUtils bytesToString:actual withSize:7] UTF8String]);
}

- (void)testReadDatabasePageRangeUserData {
    DefaultEncoder *encoder = [[DefaultEncoder alloc] init];
    Byte *actual = (Byte *) [encoder encodeRequest:[[ReadDatabasePageRangeRequest alloc] initWithRecordType:UserEventData]];

    Byte *expected = (Byte *) [[EncodingUtils dataFromHexString:@"01 07 00 10 0b 64 49"] bytes];
    XCTAssertTrue(memcmp(actual, expected, 7) == 0, @"Expected [%s] but received [%s]",
    [[EncodingUtils bytesToString:expected withSize:7] UTF8String],
    [[EncodingUtils bytesToString:actual withSize:7] UTF8String]);
}

- (void)testReadDatabasePagesGlucoseData {
    DefaultEncoder *encoder = [[DefaultEncoder alloc] init];
    Byte *actual = (Byte *) [encoder encodeRequest:[[ReadDatabasePagesRequest alloc] initWithRecordType:EGVData pageNumber:1465 numberOfPages:4]];

    Byte *expected = (Byte *) [[EncodingUtils dataFromHexString:@"01 0C 00 11 04 B9 05 00 00 04 6D 29"] bytes];
    XCTAssertTrue(memcmp(actual, expected, 12) == 0, @"Expected [%s] but received [%s]",
    [[EncodingUtils bytesToString:expected withSize:12] UTF8String],
    [[EncodingUtils bytesToString:actual withSize:12] UTF8String]);
}

- (void)testReadDatabasePagesUserData {
    DefaultEncoder *encoder = [[DefaultEncoder alloc] init];
    Byte *actual = (Byte *) [encoder encodeRequest:[[ReadDatabasePagesRequest alloc] initWithRecordType:UserEventData pageNumber:1465 numberOfPages:4]];

    Byte *expected = (Byte *) [[EncodingUtils dataFromHexString:@"01 0c 00 11 0b b9 05 00 00 04 6e ec"] bytes];
    XCTAssertTrue(memcmp(actual, expected, 12) == 0, @"Expected [%s] but received [%s]",
    [[EncodingUtils bytesToString:expected withSize:12] UTF8String],
    [[EncodingUtils bytesToString:actual withSize:12] UTF8String]);
}

- (void)testReadDatabasePagesManufacturingData {
    DefaultEncoder *encoder = [[DefaultEncoder alloc] init];
    Byte *actual = (Byte *) [encoder encodeRequest:[[ReadDatabasePagesRequest alloc] initWithRecordType:ManufacturingData pageNumber:0 numberOfPages:1]];

    Byte *expected = (Byte *) [[EncodingUtils dataFromHexString:@"01 0C 00 11 00 00 00 00 00 01 6E 45"] bytes];
    XCTAssertTrue(memcmp(actual, expected, 12) == 0, @"Expected [%s] but received [%s]",
    [[EncodingUtils bytesToString:expected withSize:12] UTF8String],
    [[EncodingUtils bytesToString:actual withSize:12] UTF8String]);
}

@end
