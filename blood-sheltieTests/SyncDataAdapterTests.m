//
//  SyncDataAdapterTests.m
//  blood-sheltie
//
//  Created by Alexandre Normand on 2014-02-28.
//  Copyright (c) 2014 glukit. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GlucoseReadRecord.h"
#import "SyncDataAdapter.h"
#import "GlucoseRead.h"

@interface SyncDataAdapterTests : XCTestCase

@end

@implementation SyncDataAdapterTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testGlucoseReadConversionWithMgPerDL
{
    NSMutableArray *glucoseRecords = [NSMutableArray array];
    [glucoseRecords addObject:[GlucoseReadRecord recordWithInternalSecondsSinceDexcomEpoch:0 localSecondsSinceDexcomEpoch:1800 glucoseValue:76 trendArrowAndNoise:0 recordNumber:0 pageNumber:0]];
    
    NSMutableArray *empty = [NSMutableArray array];
    SyncData *syncData = [SyncDataAdapter convertSyncData:[InternalSyncData dataWithGlucoseUnit:mgPerDL glucoseReads:glucoseRecords calibrationReads:empty userEvents:empty manufacturingParameters:nil]];

    NSDate *expectedUserTime = [Types dateTimeFromSecondsSinceDexcomEpoch:1800];
    NSDate *expectedInternalTime = [Types dateTimeFromSecondsSinceDexcomEpoch:0];
    GlucoseRead *expectedRead = [GlucoseRead valueWithInternalTime:expectedInternalTime userTime:expectedUserTime timezone:[Types timezoneFromLocalTime:expectedUserTime andInternalTime:expectedInternalTime] value:76.f unit:mgPerDL];
    GlucoseRead *convertedRead = [[syncData glucoseReads] objectAtIndex:0];
    XCTAssertEqualObjects(convertedRead, expectedRead);
}

- (void)testGlucoseReadConversionWithMmolPerL
{
    NSMutableArray *glucoseRecords = [NSMutableArray array];
    [glucoseRecords addObject:[GlucoseReadRecord recordWithInternalSecondsSinceDexcomEpoch:0 localSecondsSinceDexcomEpoch:1800 glucoseValue:76 trendArrowAndNoise:0 recordNumber:0 pageNumber:0]];

    NSMutableArray *empty = [NSMutableArray array];
    SyncData *syncData = [SyncDataAdapter convertSyncData:[InternalSyncData dataWithGlucoseUnit:mmolPerL glucoseReads:glucoseRecords calibrationReads:empty userEvents:empty manufacturingParameters:nil]];

    NSDate *expectedUserTime = [Types dateTimeFromSecondsSinceDexcomEpoch:1800];
    NSDate *expectedInternalTime = [Types dateTimeFromSecondsSinceDexcomEpoch:0];
    GlucoseRead *expectedRead = [GlucoseRead valueWithInternalTime:expectedInternalTime userTime:expectedUserTime timezone:[Types timezoneFromLocalTime:expectedUserTime andInternalTime:expectedInternalTime] value:7.6f unit:mmolPerL];
    GlucoseRead *convertedRead = [[syncData glucoseReads] objectAtIndex:0];
    XCTAssertEqualObjects(convertedRead, expectedRead);
}

@end
