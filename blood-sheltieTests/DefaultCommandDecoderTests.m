//
//  DefaultCommandDecoderTests.m.m
//  blood-sheltie
//
//  Created by Alexandre Normand on 1/21/2014.
//  Copyright (c) 2014 glukit. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DefaultDecoder.h"
#import "EncodingUtils.h"
#import "PageRange.h"

@interface DefaultCommandDecoderTests_m : XCTestCase
@property(readonly) DefaultDecoder *decoder;
@end

@implementation DefaultCommandDecoderTests_m

- (void)setUp
{
    [super setUp];
    _decoder = [[DefaultDecoder alloc] init];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testDatabasePageRangeResponseDecoding
{
    NSString *input = @"01 0E 00 01 01 00 00 00 02 00 00 00 97 11";
    NSData *data = [EncodingUtils dataFromHexString:input];

    ReceiverResponse *response = [_decoder decodeResponse:data forCommand:(ReadDatabasePageRange)];
    XCTAssertNotNil(response, @"response should not be nil for input [%s]", [input UTF8String]);
    XCTAssertNotNil(response.payload, @"response.payload should not be nil for input [%s]", [input UTF8String]);
    PageRange *pageRange = (PageRange *) response.payload;
    XCTAssertEqual(pageRange.firstPage, 1u);
    XCTAssertEqual(pageRange.lastPage, 2u);
}

@end
