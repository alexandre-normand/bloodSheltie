#import <XCTest/XCTest.h>
#import "GlucoseReadRecord.h"
#import "SyncDataAdapter.h"
#import "GlucoseRead.h"
#import "UserEventRecord.h"
#import "InsulinInjection.h"
#import "ExerciseEvent.h"
#import "FoodEvent.h"
#import "HealthEvent.h"
#import "MeterReadRecord.h"
#import "MeterRead.h"

@interface SyncDataAdapterTests : XCTestCase

@end

@implementation SyncDataAdapterTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testGlucoseReadConversionWithMgPerDL {
    NSMutableArray *glucoseRecords = [NSMutableArray array];
    [glucoseRecords addObject:[GlucoseReadRecord recordWithInternalSecondsSinceDexcomEpoch:0 localSecondsSinceDexcomEpoch:1800 glucoseValue:76 trendArrowAndNoise:0 recordNumber:0 pageNumber:0]];

    NSMutableArray *empty = [NSMutableArray array];
    SyncData *syncData = [SyncDataAdapter convertSyncData:[InternalSyncData dataWithGlucoseUnit:mgPerDL glucoseReads:glucoseRecords calibrationReads:empty userEvents:empty manufacturingParameters:nil]];

    NSDate *expectedUserTime = [Types dateTimeFromSecondsSinceDexcomEpoch:1800];
    NSDate *expectedInternalTime = [Types dateTimeFromSecondsSinceDexcomEpoch:0];
    GlucoseRead *expectedRead = [GlucoseRead valueWithInternalTime:expectedInternalTime userTime:expectedUserTime timezone:[Types timezoneFromLocalTime:expectedUserTime andInternalTime:expectedInternalTime] value:76.f unit:MG_PER_DL timestamp:(long long) ([expectedInternalTime timeIntervalSince1970] * 1000)];
    GlucoseRead *convertedRead = [[syncData glucoseReads] objectAtIndex:0];
    XCTAssertEqualObjects(convertedRead, expectedRead);
}

- (void)testGlucoseReadTimestamp {
    NSMutableArray *glucoseRecords = [NSMutableArray array];
    // 25200 amounts to a user time offset of -7 hours
    [glucoseRecords addObject:[GlucoseReadRecord recordWithInternalSecondsSinceDexcomEpoch:25200 localSecondsSinceDexcomEpoch:0 glucoseValue:76 trendArrowAndNoise:0 recordNumber:0 pageNumber:0]];

    NSMutableArray *empty = [NSMutableArray array];
    SyncData *syncData = [SyncDataAdapter convertSyncData:[InternalSyncData dataWithGlucoseUnit:mgPerDL glucoseReads:glucoseRecords calibrationReads:empty userEvents:empty manufacturingParameters:nil]];

    NSDate *expectedUserTime = [Types dateTimeFromSecondsSinceDexcomEpoch:0];
    NSDate *expectedInternalTime = [Types dateTimeFromSecondsSinceDexcomEpoch:25200];
    GlucoseRead *expectedRead = [GlucoseRead valueWithInternalTime:expectedInternalTime userTime:expectedUserTime timezone:[Types timezoneFromLocalTime:expectedUserTime andInternalTime:expectedInternalTime] value:76.f unit:MG_PER_DL timestamp:(long long) ([expectedInternalTime timeIntervalSince1970] * 1000)];
    GlucoseRead *convertedRead = [[syncData glucoseReads] objectAtIndex:0];
    XCTAssertEqualObjects(convertedRead, expectedRead);

    XCTAssertEqual(convertedRead.timestamp, ([[Types dexcomEpoch] timeIntervalSince1970] + 25200) * 1000);
}

- (void)testGlucoseReadConversionWithMmolPerL {
    NSMutableArray *glucoseRecords = [NSMutableArray array];
    [glucoseRecords addObject:[GlucoseReadRecord recordWithInternalSecondsSinceDexcomEpoch:0 localSecondsSinceDexcomEpoch:1800 glucoseValue:76 trendArrowAndNoise:0 recordNumber:0 pageNumber:0]];

    NSMutableArray *empty = [NSMutableArray array];
    SyncData *syncData = [SyncDataAdapter convertSyncData:[InternalSyncData dataWithGlucoseUnit:mmolPerL glucoseReads:glucoseRecords calibrationReads:empty userEvents:empty manufacturingParameters:nil]];

    NSDate *expectedUserTime = [Types dateTimeFromSecondsSinceDexcomEpoch:1800];
    NSDate *expectedInternalTime = [Types dateTimeFromSecondsSinceDexcomEpoch:0];
    GlucoseRead *expectedRead = [GlucoseRead valueWithInternalTime:expectedInternalTime userTime:expectedUserTime timezone:[Types timezoneFromLocalTime:expectedUserTime andInternalTime:expectedInternalTime] value:7.6f unit:MMOL_PER_L timestamp:(long long) ([expectedInternalTime timeIntervalSince1970] * 1000)];
    GlucoseRead *convertedRead = [[syncData glucoseReads] objectAtIndex:0];
    XCTAssertEqualObjects(convertedRead, expectedRead);
}

- (void)testInsulinInjectionConversion {
    NSMutableArray *injections = [NSMutableArray array];
    [injections addObject:[UserEventRecord recordWithEventType:Insulin subType:0 eventValue:325 eventSecondsSinceDexcomEpoch:1800 internalSecondsSinceDexcomEpoch:0 localSecondsSinceDexcomEpoch:1800 recordNumber:0 pageNumber:0]];

    NSMutableArray *empty = [NSMutableArray array];
    SyncData *syncData = [SyncDataAdapter convertSyncData:[InternalSyncData dataWithGlucoseUnit:mgPerDL glucoseReads:empty calibrationReads:empty userEvents:injections manufacturingParameters:nil]];

    NSDate *expectedUserTime = [Types dateTimeFromSecondsSinceDexcomEpoch:1800];
    NSDate *expectedInternalTime = [Types dateTimeFromSecondsSinceDexcomEpoch:0];
    NSDate *expectedEventTime = [Types dateTimeFromSecondsSinceDexcomEpoch:1800];
    InsulinInjection *expectedInjection = [InsulinInjection valueWithInternalTime:expectedInternalTime userTime:expectedUserTime userTimezone:[Types timezoneFromLocalTime:expectedUserTime andInternalTime:expectedInternalTime] eventTime:expectedEventTime insulinType:UnknownInsulinType unitValue:3.25f insulinName:nil timestamp:1230768000000];
    InsulinInjection *convertedInjection = [[syncData insulinInjections] objectAtIndex:0];
    XCTAssertEqualObjects(convertedInjection, expectedInjection);
}

- (void)testExerciseEventConversion {
    NSMutableArray *userEvents = [NSMutableArray array];
    [userEvents addObject:[UserEventRecord recordWithEventType:Exercise subType:Light eventValue:15 eventSecondsSinceDexcomEpoch:1800 internalSecondsSinceDexcomEpoch:0 localSecondsSinceDexcomEpoch:1800 recordNumber:0 pageNumber:0]];

    NSMutableArray *empty = [NSMutableArray array];
    SyncData *syncData = [SyncDataAdapter convertSyncData:[InternalSyncData dataWithGlucoseUnit:mgPerDL glucoseReads:empty calibrationReads:empty userEvents:userEvents manufacturingParameters:nil]];

    NSDate *expectedUserTime = [Types dateTimeFromSecondsSinceDexcomEpoch:1800];
    NSDate *expectedInternalTime = [Types dateTimeFromSecondsSinceDexcomEpoch:0];
    NSDate *expectedEventTime = [Types dateTimeFromSecondsSinceDexcomEpoch:1800];
    ExerciseEvent *expectedExercise = [ExerciseEvent valueWithInternalTime:expectedInternalTime userTime:expectedUserTime userTimezone:[Types timezoneFromLocalTime:expectedUserTime andInternalTime:expectedInternalTime] eventTime:expectedEventTime duration:15 * 60.f intensity:LightExercise details:nil timestamp:1230768000000];
    ExerciseEvent *convertedExercise = [[syncData exerciseEvents] objectAtIndex:0];
    XCTAssertEqualObjects(convertedExercise, expectedExercise);
}

- (void)testFoodEventConversion {
    NSMutableArray *userEvents = [NSMutableArray array];
    [userEvents addObject:[UserEventRecord recordWithEventType:Carbs subType:0 eventValue:15 eventSecondsSinceDexcomEpoch:1800 internalSecondsSinceDexcomEpoch:0 localSecondsSinceDexcomEpoch:1800 recordNumber:0 pageNumber:0]];

    NSMutableArray *empty = [NSMutableArray array];
    SyncData *syncData = [SyncDataAdapter convertSyncData:[InternalSyncData dataWithGlucoseUnit:mgPerDL glucoseReads:empty calibrationReads:empty userEvents:userEvents manufacturingParameters:nil]];

    NSDate *expectedUserTime = [Types dateTimeFromSecondsSinceDexcomEpoch:1800];
    NSDate *expectedInternalTime = [Types dateTimeFromSecondsSinceDexcomEpoch:0];
    NSDate *expectedEventTime = [Types dateTimeFromSecondsSinceDexcomEpoch:1800];
    FoodEvent *expectedFoodEvent = [FoodEvent valueWithInternalTime:expectedInternalTime userTime:expectedUserTime userTimezone:[Types timezoneFromLocalTime:expectedUserTime andInternalTime:expectedInternalTime] eventTime:expectedEventTime carbohydrates:15.f proteins:UnknownNutrientValue fat:UnknownNutrientValue timestamp:1230768000000];
    FoodEvent *convertedFoodEvent = [[syncData foodEvents] objectAtIndex:0];
    XCTAssertEqualObjects(convertedFoodEvent, expectedFoodEvent);
}

- (void)testEventTimestampConversion {
    NSMutableArray *userEvents = [NSMutableArray array];
    [userEvents addObject:[UserEventRecord recordWithEventType:Carbs subType:0 eventValue:15 eventSecondsSinceDexcomEpoch:4000 internalSecondsSinceDexcomEpoch:25200 localSecondsSinceDexcomEpoch:0 recordNumber:0 pageNumber:0]];

    NSMutableArray *empty = [NSMutableArray array];
    SyncData *syncData = [SyncDataAdapter convertSyncData:[InternalSyncData dataWithGlucoseUnit:mgPerDL glucoseReads:empty calibrationReads:empty userEvents:userEvents manufacturingParameters:nil]];

    NSDate *expectedUserTime = [Types dateTimeFromSecondsSinceDexcomEpoch:0];
    NSDate *expectedInternalTime = [Types dateTimeFromSecondsSinceDexcomEpoch:25200];
    NSDate *expectedEventTime = [Types dateTimeFromSecondsSinceDexcomEpoch:4000];
    long long expectedTimestamp = (long long) ([[Types dexcomEpoch] timeIntervalSince1970] + 29200) * 1000;
    FoodEvent *expectedFoodEvent = [FoodEvent valueWithInternalTime:expectedInternalTime userTime:expectedUserTime userTimezone:[Types timezoneFromLocalTime:expectedUserTime andInternalTime:expectedInternalTime] eventTime:expectedEventTime carbohydrates:15.f proteins:UnknownNutrientValue fat:UnknownNutrientValue timestamp:expectedTimestamp];
    FoodEvent *convertedFoodEvent = [[syncData foodEvents] objectAtIndex:0];
    XCTAssertEqualObjects(convertedFoodEvent, expectedFoodEvent);

    XCTAssertEqual(convertedFoodEvent.timestamp, expectedTimestamp);
}

- (void)testHealthEventConversion {
    NSMutableArray *userEvents = [NSMutableArray array];
    [userEvents addObject:[UserEventRecord recordWithEventType:Health subType:Stress eventValue:0 eventSecondsSinceDexcomEpoch:1800 internalSecondsSinceDexcomEpoch:0 localSecondsSinceDexcomEpoch:1800 recordNumber:0 pageNumber:0]];

    NSMutableArray *empty = [NSMutableArray array];
    SyncData *syncData = [SyncDataAdapter convertSyncData:[InternalSyncData dataWithGlucoseUnit:mgPerDL glucoseReads:empty calibrationReads:empty userEvents:userEvents manufacturingParameters:nil]];

    NSDate *expectedUserTime = [Types dateTimeFromSecondsSinceDexcomEpoch:1800];
    NSDate *expectedInternalTime = [Types dateTimeFromSecondsSinceDexcomEpoch:0];
    NSDate *expectedEventTime = [Types dateTimeFromSecondsSinceDexcomEpoch:1800];
    HealthEvent *expectedHealthEvent = [HealthEvent valueWithInternalTime:expectedInternalTime userTime:expectedUserTime userTimezone:[Types timezoneFromLocalTime:expectedUserTime andInternalTime:expectedInternalTime] eventTime:expectedEventTime type:@"Stress" details:nil timestamp:1230768000000];
    HealthEvent *convertedHealthEvent = [[syncData healthEvents] objectAtIndex:0];
    XCTAssertEqualObjects(convertedHealthEvent, expectedHealthEvent);
}

- (void)testMeterReadConversionWithMgPerDL {
    NSMutableArray *meterReadRecords = [NSMutableArray array];
    [meterReadRecords addObject:[MeterReadRecord recordWithMeterRead:75 internalSecondsSinceDexcomEpoch:0 localSecondsSinceDexcomEpoch:1800 meterTimeInSecondsSinceDexcomEpoch:1800 recordNumber:0 pageNumber:0]];

    NSMutableArray *empty = [NSMutableArray array];
    SyncData *syncData = [SyncDataAdapter convertSyncData:[InternalSyncData dataWithGlucoseUnit:mgPerDL glucoseReads:empty calibrationReads:meterReadRecords userEvents:empty manufacturingParameters:nil]];

    NSDate *expectedInternalTime = [Types dateTimeFromSecondsSinceDexcomEpoch:0];
    NSDate *expectedUserTime = [Types dateTimeFromSecondsSinceDexcomEpoch:1800];
    NSDate *expectedMeterTime = [Types dateTimeFromSecondsSinceDexcomEpoch:1800];
    MeterRead *expectedMeterRead = [MeterRead valueWithInternalTime:expectedInternalTime userTime:expectedUserTime timezone:[Types timezoneFromLocalTime:expectedUserTime andInternalTime:expectedInternalTime] meterTime:expectedMeterTime meterRead:75.f glucoseMeasurementUnit:MG_PER_DL timestamp:(long long) ([expectedInternalTime timeIntervalSince1970] * 1000)];
    MeterRead *convertedMeterRead = [[syncData calibrationReads] objectAtIndex:0];
    XCTAssertEqualObjects(convertedMeterRead, expectedMeterRead);
}

- (void)testMeterReadConversionWithMmolPerL {
    NSMutableArray *meterReadRecords = [NSMutableArray array];
    [meterReadRecords addObject:[MeterReadRecord recordWithMeterRead:47 internalSecondsSinceDexcomEpoch:0 localSecondsSinceDexcomEpoch:1800 meterTimeInSecondsSinceDexcomEpoch:1800 recordNumber:0 pageNumber:0]];

    NSMutableArray *empty = [NSMutableArray array];
    SyncData *syncData = [SyncDataAdapter convertSyncData:[InternalSyncData dataWithGlucoseUnit:mmolPerL glucoseReads:empty calibrationReads:meterReadRecords userEvents:empty manufacturingParameters:nil]];

    NSDate *expectedInternalTime = [Types dateTimeFromSecondsSinceDexcomEpoch:0];
    NSDate *expectedUserTime = [Types dateTimeFromSecondsSinceDexcomEpoch:1800];
    NSDate *expectedMeterTime = [Types dateTimeFromSecondsSinceDexcomEpoch:1800];
    MeterRead *expectedMeterRead = [MeterRead valueWithInternalTime:expectedInternalTime userTime:expectedUserTime timezone:[Types timezoneFromLocalTime:expectedUserTime andInternalTime:expectedInternalTime] meterTime:expectedMeterTime meterRead:4.7f glucoseMeasurementUnit:MMOL_PER_L timestamp:(long long) ([expectedInternalTime timeIntervalSince1970] * 1000)];
    MeterRead *convertedMeterRead = [[syncData calibrationReads] objectAtIndex:0];
    XCTAssertEqualObjects(convertedMeterRead, expectedMeterRead);
}
@end
