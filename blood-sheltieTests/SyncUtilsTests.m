//
//  SyncUtilsTests.m
//  blood-sheltie
//
//  Created by Alexandre Normand on 2/23/2014.
//  Copyright (c) 2014 glukit. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GlucoseReadRecord.h"
#import "SyncUtils.h"

@interface SyncUtilsTests : XCTestCase

@end

@implementation SyncUtilsTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testSort
{
    NSMutableArray *records = [NSMutableArray array];
    [records addObject:[GlucoseReadRecord recordWithInternalSecondsSinceDexcomEpoch:1500 localSecondsSinceDexcomEpoch:100 glucoseValue:50 trendArrowAndNoise:0 recordNumber:3 pageNumber:1]];
    [records addObject:[GlucoseReadRecord recordWithInternalSecondsSinceDexcomEpoch:0 localSecondsSinceDexcomEpoch:100 glucoseValue:60 trendArrowAndNoise:0 recordNumber:1 pageNumber:1]];
    [records addObject:[GlucoseReadRecord recordWithInternalSecondsSinceDexcomEpoch:800 localSecondsSinceDexcomEpoch:100 glucoseValue:83 trendArrowAndNoise:0 recordNumber:2 pageNumber:1]];
    
    NSArray *sorted = [SyncUtils sortRecords:records];
    
    GenericRecord *oldest = [sorted objectAtIndex:0];
    XCTAssertEqual(oldest.recordNumber, 1u);
    GenericRecord *second = [sorted objectAtIndex:1];
    XCTAssertEqual(second.recordNumber, 2u);
    GenericRecord *mostRecent = [sorted objectAtIndex:2];
    XCTAssertEqual(mostRecent.recordNumber, 3u);
}

- (void)testGenerateRecordSyncTag
{
    NSMutableArray *records = [NSMutableArray array];
    [records addObject:[GlucoseReadRecord recordWithInternalSecondsSinceDexcomEpoch:1500 localSecondsSinceDexcomEpoch:100 glucoseValue:50 trendArrowAndNoise:0 recordNumber:3 pageNumber:4]];
    [records addObject:[GlucoseReadRecord recordWithInternalSecondsSinceDexcomEpoch:0 localSecondsSinceDexcomEpoch:100 glucoseValue:60 trendArrowAndNoise:0 recordNumber:1 pageNumber:2]];
    [records addObject:[GlucoseReadRecord recordWithInternalSecondsSinceDexcomEpoch:800 localSecondsSinceDexcomEpoch:100 glucoseValue:83 trendArrowAndNoise:0 recordNumber:2 pageNumber:3]];

    RecordSyncTag *tag = [SyncUtils generateRecordSyncTag:records previousSyncTag:nil ];

    XCTAssertEqualObjects(tag.recordNumber, @3);
    XCTAssertEqualObjects(tag.pageNumber, @4);
}

-(void)testInitialSyncTagIsNotNil
{
    XCTAssertNotNil([SyncTag initialSyncTag]);
    XCTAssertNotNil([RecordSyncTag initialSyncTag]);
}

-(void)testInitialSyncTagIsMarkedAsSuch
{
    SyncTag *initialSyncTag = [SyncTag initialSyncTag];
    XCTAssertTrue([initialSyncTag isInitialSync]);

    SyncTag *normalTag = [SyncTag tagWithSerialNumber:@"test" lastGlucoseRead:nil lastUserEvent:nil lastCalibrationRead:nil];
    XCTAssertFalse([normalTag isInitialSync]);
}

-(void)testInitialRecordSyncTagIsMarkedAsSuch
{
    RecordSyncTag *initialSyncTag = [RecordSyncTag initialSyncTag];
    XCTAssertTrue([initialSyncTag isInitialSync]);

    RecordSyncTag *normalTag = [RecordSyncTag tagWithRecordNumber:@0 pageNumber:@0];
    XCTAssertFalse([normalTag isInitialSync]);
}

@end
