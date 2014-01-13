//
//  EncodingUtilsTests.m
//  blood-sheltie
//
//  Created by Alexandre Normand on 1/11/2014.
//  Copyright (c) 2014 glukit. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EncodingUtils.h"

@interface EncodingUtilsTests : XCTestCase

@end

@implementation EncodingUtilsTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCrc16
{
    NSData *testData = [EncodingUtils dataFromHexString:@"01 06 00 2e b8 01"];
    uint16_t crc = [EncodingUtils crc16:testData :0 :(uint16_t) (testData.length - 2)];
    XCTAssertEqual(crc, [EncodingUtils getPacketCrc16:testData], @"Wrong crc value");
}

@end
