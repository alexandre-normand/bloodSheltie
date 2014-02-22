//
//  SyncDataFilterTests.m
//  blood-sheltie
//
//  Created by Alexandre Normand on 2/20/2014.
//  Copyright (c) 2014 glukit. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SyncData.h"
#import "SyncDataFilter.h"
#import "Types.h"
#import "MeterReadRecord.h"
#import "UserEventRecord.h"
#import "GlucoseReadRecord.h"

@interface SyncDataFilterTests : XCTestCase

@end

@implementation SyncDataFilterTests

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

- (void)testEmptySyncDataFiltersWithoutErrors
{
    SyncData *data = [[SyncData alloc] init];
    [SyncDataFilter filterData:data since:[Types dexcomEpoch]];
}

- (void)testCalibrationReadsFilterWithDataBeforeAndAfterDate
{
    SyncData *data = [[SyncData alloc] init];
    [data.calibrationReads addObject:[MeterReadRecord recordWithMeterRead:10 internalSecondsSinceDexcomEpoch:100 localSecondsSinceDexcomEpoch:100 meterTimeInSecondsSinceDexcomEpoch:100]];
    [data.calibrationReads addObject:[MeterReadRecord recordWithMeterRead:10 internalSecondsSinceDexcomEpoch:1000 localSecondsSinceDexcomEpoch:1000 meterTimeInSecondsSinceDexcomEpoch:1000]];
    SyncData *filteredData = [SyncDataFilter filterData:data since:[NSDate dateWithTimeInterval:101 sinceDate:[Types dexcomEpoch]]];
    XCTAssertEqual([filteredData.calibrationReads count], 1ul);
}

- (void)testUserEventsFilterWithDataBeforeAndAfterDate
{
    SyncData *data = [[SyncData alloc] init];
    [data.userEvents addObject:[UserEventRecord recordWithEventType:Insulin eventValue:2 eventSecondsSinceDexcomEpoch:100 internalSecondsSinceDexcomEpoch:100 localSecondsSinceDexcomEpoch:100]];
    [data.userEvents addObject:[UserEventRecord recordWithEventType:Insulin eventValue:4 eventSecondsSinceDexcomEpoch:1000 internalSecondsSinceDexcomEpoch:1000 localSecondsSinceDexcomEpoch:1000]];
    SyncData *filteredData = [SyncDataFilter filterData:data since:[NSDate dateWithTimeInterval:101 sinceDate:[Types dexcomEpoch]]];
    XCTAssertEqual([filteredData.userEvents count], 1ul);
}

- (void)testGlucoseReadsFilterWithDataBeforeAndAfterDate
{
    SyncData *data = [[SyncData alloc] init];
    [data.glucoseReads addObject:[GlucoseReadRecord recordWithInternalSecondsSinceDexcomEpoch:100 localSecondsSinceDexcomEpoch:100 glucoseValue:83 trendArrowAndNoise:0 recordNumber:0 pageNumber:0]];
    [data.glucoseReads addObject:[GlucoseReadRecord recordWithInternalSecondsSinceDexcomEpoch:1000 localSecondsSinceDexcomEpoch:1000 glucoseValue:83 trendArrowAndNoise:0 recordNumber:0 pageNumber:0]];
    SyncData *filteredData = [SyncDataFilter filterData:data since:[NSDate dateWithTimeInterval:101 sinceDate:[Types dexcomEpoch]]];
    XCTAssertEqual([filteredData.glucoseReads count], 1ul);
}

- (void)testCalibrationReadsFilterWithDataAllBeforeDate
{
    SyncData *data = [[SyncData alloc] init];
    [data.calibrationReads addObject:[MeterReadRecord recordWithMeterRead:10 internalSecondsSinceDexcomEpoch:100 localSecondsSinceDexcomEpoch:100 meterTimeInSecondsSinceDexcomEpoch:100]];
    [data.calibrationReads addObject:[MeterReadRecord recordWithMeterRead:10 internalSecondsSinceDexcomEpoch:1000 localSecondsSinceDexcomEpoch:1000 meterTimeInSecondsSinceDexcomEpoch:1000]];
    SyncData *filteredData = [SyncDataFilter filterData:data since:[NSDate dateWithTimeInterval:1001 sinceDate:[Types dexcomEpoch]]];
    XCTAssertEqual([filteredData.calibrationReads count], 0ul);
}

- (void)testUserEventsFilterWithDataAllBeforeDate
{
    SyncData *data = [[SyncData alloc] init];
    [data.userEvents addObject:[UserEventRecord recordWithEventType:Insulin eventValue:2 eventSecondsSinceDexcomEpoch:100 internalSecondsSinceDexcomEpoch:100 localSecondsSinceDexcomEpoch:100]];
    [data.userEvents addObject:[UserEventRecord recordWithEventType:Insulin eventValue:4 eventSecondsSinceDexcomEpoch:1000 internalSecondsSinceDexcomEpoch:1000 localSecondsSinceDexcomEpoch:1000]];
    SyncData *filteredData = [SyncDataFilter filterData:data since:[NSDate dateWithTimeInterval:1001 sinceDate:[Types dexcomEpoch]]];
    XCTAssertEqual([filteredData.userEvents count], 0ul);
}

- (void)testGlucoseReadsFilterWithDataAllBeforeDate
{
    SyncData *data = [[SyncData alloc] init];
    [data.glucoseReads addObject:[GlucoseReadRecord recordWithInternalSecondsSinceDexcomEpoch:100 localSecondsSinceDexcomEpoch:100 glucoseValue:83 trendArrowAndNoise:0 recordNumber:0 pageNumber:0]];
    [data.glucoseReads addObject:[GlucoseReadRecord recordWithInternalSecondsSinceDexcomEpoch:1000 localSecondsSinceDexcomEpoch:1000 glucoseValue:83 trendArrowAndNoise:0 recordNumber:0 pageNumber:0]];
    SyncData *filteredData = [SyncDataFilter filterData:data since:[NSDate dateWithTimeInterval:1001 sinceDate:[Types dexcomEpoch]]];
    XCTAssertEqual([filteredData.glucoseReads count], 0ul);
}

- (void)testCalibrationReadsFilterWithDataAllAfterDate
{
    SyncData *data = [[SyncData alloc] init];
    [data.calibrationReads addObject:[MeterReadRecord recordWithMeterRead:10 internalSecondsSinceDexcomEpoch:100 localSecondsSinceDexcomEpoch:100 meterTimeInSecondsSinceDexcomEpoch:100]];
    [data.calibrationReads addObject:[MeterReadRecord recordWithMeterRead:10 internalSecondsSinceDexcomEpoch:1000 localSecondsSinceDexcomEpoch:1000 meterTimeInSecondsSinceDexcomEpoch:1000]];
    SyncData *filteredData = [SyncDataFilter filterData:data since:[NSDate dateWithTimeInterval:99 sinceDate:[Types dexcomEpoch]]];
    XCTAssertEqual([filteredData.calibrationReads count], 2ul);
}

- (void)testUserEventsFilterWithDataAllAfterDate
{
    SyncData *data = [[SyncData alloc] init];
    [data.userEvents addObject:[UserEventRecord recordWithEventType:Insulin eventValue:2 eventSecondsSinceDexcomEpoch:100 internalSecondsSinceDexcomEpoch:100 localSecondsSinceDexcomEpoch:100]];
    [data.userEvents addObject:[UserEventRecord recordWithEventType:Insulin eventValue:4 eventSecondsSinceDexcomEpoch:1000 internalSecondsSinceDexcomEpoch:1000 localSecondsSinceDexcomEpoch:1000]];
    SyncData *filteredData = [SyncDataFilter filterData:data since:[NSDate dateWithTimeInterval:99 sinceDate:[Types dexcomEpoch]]];
    XCTAssertEqual([filteredData.userEvents count], 2ul);
}

- (void)testGlucoseReadsFilterWithDataAllAfterDate
{
    SyncData *data = [[SyncData alloc] init];
    [data.glucoseReads addObject:[GlucoseReadRecord recordWithInternalSecondsSinceDexcomEpoch:100 localSecondsSinceDexcomEpoch:100 glucoseValue:83 trendArrowAndNoise:0 recordNumber:0 pageNumber:0]];
    [data.glucoseReads addObject:[GlucoseReadRecord recordWithInternalSecondsSinceDexcomEpoch:1000 localSecondsSinceDexcomEpoch:1000 glucoseValue:83 trendArrowAndNoise:0 recordNumber:0 pageNumber:0]];
    SyncData *filteredData = [SyncDataFilter filterData:data since:[NSDate dateWithTimeInterval:99 sinceDate:[Types dexcomEpoch]]];
    XCTAssertEqual([filteredData.glucoseReads count], 2ul);
}

- (void)testCalibrationReadsFilterWithDataExactlyOnDate
{
    SyncData *data = [[SyncData alloc] init];
    [data.calibrationReads addObject:[MeterReadRecord recordWithMeterRead:10 internalSecondsSinceDexcomEpoch:100 localSecondsSinceDexcomEpoch:100 meterTimeInSecondsSinceDexcomEpoch:100]];
    [data.calibrationReads addObject:[MeterReadRecord recordWithMeterRead:10 internalSecondsSinceDexcomEpoch:1000 localSecondsSinceDexcomEpoch:1000 meterTimeInSecondsSinceDexcomEpoch:1000]];
    SyncData *filteredData = [SyncDataFilter filterData:data since:[NSDate dateWithTimeInterval:100 sinceDate:[Types dexcomEpoch]]];
    XCTAssertEqual([filteredData.calibrationReads count], 1ul);
}

- (void)testUserEventsFilterWithDataExactlyOnDate
{
    SyncData *data = [[SyncData alloc] init];
    [data.userEvents addObject:[UserEventRecord recordWithEventType:Insulin eventValue:2 eventSecondsSinceDexcomEpoch:100 internalSecondsSinceDexcomEpoch:100 localSecondsSinceDexcomEpoch:100]];
    [data.userEvents addObject:[UserEventRecord recordWithEventType:Insulin eventValue:4 eventSecondsSinceDexcomEpoch:1000 internalSecondsSinceDexcomEpoch:1000 localSecondsSinceDexcomEpoch:1000]];
    SyncData *filteredData = [SyncDataFilter filterData:data since:[NSDate dateWithTimeInterval:100 sinceDate:[Types dexcomEpoch]]];
    XCTAssertEqual([filteredData.userEvents count], 1ul);
}

- (void)testGlucoseReadsFilterWithDataExactlyOnDate
{
    SyncData *data = [[SyncData alloc] init];
    [data.glucoseReads addObject:[GlucoseReadRecord recordWithInternalSecondsSinceDexcomEpoch:100 localSecondsSinceDexcomEpoch:100 glucoseValue:83 trendArrowAndNoise:0 recordNumber:0 pageNumber:0]];
    [data.glucoseReads addObject:[GlucoseReadRecord recordWithInternalSecondsSinceDexcomEpoch:1000 localSecondsSinceDexcomEpoch:1000 glucoseValue:83 trendArrowAndNoise:0 recordNumber:0 pageNumber:0]];
    SyncData *filteredData = [SyncDataFilter filterData:data since:[NSDate dateWithTimeInterval:100 sinceDate:[Types dexcomEpoch]]];
    XCTAssertEqual([filteredData.glucoseReads count], 1ul);
}

@end
