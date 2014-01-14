//
//  DefaultCommandEncoderTests.m
//  blood-sheltie
//
//  Created by Alexandre Normand on 1/13/2014.
//  Copyright (c) 2014 glukit. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DefaultCommandEncoder.h"
#import "ReceiverRequest.h"
#import "Common.h"
#import "EncodingUtils.h"

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
    DefaultCommandEncoder *encoder = [[DefaultCommandEncoder alloc] init];
    Byte *actual = [encoder encodeRequest:[[ReceiverRequest alloc] initWithCommand:Ping]];

    Byte *expected = [[EncodingUtils dataFromHexString:@"01 06 00 0A 5E 65"] bytes];
    printf("encoded packet is: %s", [[EncodingUtils bytesToString:expected :6] UTF8String]);
    XCTAssertTrue(memcmp(actual, expected, 6) == 0);
}

@end
