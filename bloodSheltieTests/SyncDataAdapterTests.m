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
    [glucoseRecords addObject:[GlucoseReadRecord recordWithRawInternalTimeInSeconds:0 rawDisplayTimeInSeconds:1800 glucoseValue:76 trendArrowAndNoise:0 recordNumber:0 pageNumber:0 dexcomOffsetWithStandardInSeconds:-1800 timezone:[NSTimeZone timeZoneWithName:@"America/Montreal"]]];

    NSMutableArray *empty = [NSMutableArray array];
    SyncData *syncData = [SyncDataAdapter convertSyncData:[InternalSyncData dataWithGlucoseUnit:mgPerDL glucoseReads:glucoseRecords calibrationReads:empty userEvents:empty manufacturingParameters:nil dexcomOffsetFromStandardEpoch:0]];

    NSDate *expectedUserTime = [NSDate dateWithTimeIntervalSince1970:3600];
    NSDate *expectedInternalTime = [NSDate dateWithTimeIntervalSince1970:1800];
    GlucoseRead *expectedRead = [GlucoseRead valueWithInternalTime:expectedInternalTime userTime:expectedUserTime timezone:[NSTimeZone timeZoneWithName:@"America/Montreal"] value:76.f unit:MG_PER_DL timestamp:(long long) ([expectedInternalTime timeIntervalSince1970] * 1000)];
    GlucoseRead *convertedRead = [syncData glucoseReads][0];
    XCTAssertEqualObjects(convertedRead, expectedRead);
}

- (void)testGlucoseReadTimestamp {
    NSMutableArray *glucoseRecords = [NSMutableArray array];
    // 25200 amounts to a user time offset of -7 hours
    [glucoseRecords addObject:[GlucoseReadRecord recordWithRawInternalTimeInSeconds:25200 rawDisplayTimeInSeconds:0 glucoseValue:76 trendArrowAndNoise:0 recordNumber:0 pageNumber:0 dexcomOffsetWithStandardInSeconds:0 timezone:[NSTimeZone timeZoneWithName:@"America/Montreal"]]];

    NSMutableArray *empty = [NSMutableArray array];
    SyncData *syncData = [SyncDataAdapter convertSyncData:[InternalSyncData dataWithGlucoseUnit:mgPerDL glucoseReads:glucoseRecords calibrationReads:empty userEvents:empty manufacturingParameters:nil dexcomOffsetFromStandardEpoch:0]];

    NSDate *expectedUserTime = [NSDate dateWithTimeIntervalSince1970:0];
    NSDate *expectedInternalTime = [NSDate dateWithTimeIntervalSince1970:25200];
    GlucoseRead *expectedRead = [GlucoseRead valueWithInternalTime:expectedInternalTime userTime:expectedUserTime timezone:[NSTimeZone timeZoneWithName:@"America/Montreal"] value:76.f unit:MG_PER_DL timestamp:(long long) ([expectedInternalTime timeIntervalSince1970] * 1000)];
    GlucoseRead *convertedRead = [syncData glucoseReads][0];
    XCTAssertEqualObjects(convertedRead, expectedRead);

    XCTAssertEqual(convertedRead.timestamp, ([[NSDate dateWithTimeIntervalSince1970:25200] timeIntervalSince1970] * 1000));
}

- (void)testGlucoseReadConversionWithMmolPerL {
    NSMutableArray *glucoseRecords = [NSMutableArray array];
    [glucoseRecords addObject:[GlucoseReadRecord recordWithRawInternalTimeInSeconds:0 rawDisplayTimeInSeconds:1800 glucoseValue:76 trendArrowAndNoise:0 recordNumber:0 pageNumber:0 dexcomOffsetWithStandardInSeconds:0 timezone:[NSTimeZone timeZoneWithName:@"America/Montreal"]]];

    NSMutableArray *empty = [NSMutableArray array];
    SyncData *syncData = [SyncDataAdapter convertSyncData:[InternalSyncData dataWithGlucoseUnit:mmolPerL glucoseReads:glucoseRecords calibrationReads:empty userEvents:empty manufacturingParameters:nil dexcomOffsetFromStandardEpoch:0]];

    NSDate *expectedUserTime = [NSDate dateWithTimeIntervalSince1970:1800];
    NSDate *expectedInternalTime = [NSDate dateWithTimeIntervalSince1970:0];
    GlucoseRead *expectedRead = [GlucoseRead valueWithInternalTime:expectedInternalTime userTime:expectedUserTime timezone:[NSTimeZone timeZoneWithName:@"America/Montreal"] value:4.217957398630274 unit:MMOL_PER_L timestamp:(long long) ([expectedInternalTime timeIntervalSince1970] * 1000)];
    GlucoseRead *convertedRead = [syncData glucoseReads][0];
    XCTAssertEqualWithAccuracy([convertedMeterRead glucoseValue], [expectedMeterRead glucoseValue], 0.001);
}

- (void)testInsulinInjectionConversion {
    NSMutableArray *injections = [NSMutableArray array];
    [injections addObject:[UserEventRecord recordWithEventType:Insulin subType:0 eventValue:325 rawEventTimeInSeconds:1800 rawInternalTimeInSeconds:0 rawDisplayTimeInSeconds:1800 recordNumber:0 pageNumber:0 dexcomOffsetWithStandardInSeconds:0 timezone:[NSTimeZone timeZoneWithName:@"America/Montreal"]]];

    NSMutableArray *empty = [NSMutableArray array];
    SyncData *syncData = [SyncDataAdapter convertSyncData:[InternalSyncData dataWithGlucoseUnit:mgPerDL glucoseReads:empty calibrationReads:empty userEvents:injections manufacturingParameters:nil dexcomOffsetFromStandardEpoch:0]];

    NSDate *expectedUserTime = [NSDate dateWithTimeIntervalSince1970:1800];
    NSDate *expectedInternalTime = [NSDate dateWithTimeIntervalSince1970:0];
    NSDate *expectedEventTime = [NSDate dateWithTimeIntervalSince1970:1800 - 1800];
    InsulinInjection *expectedInjection = [InsulinInjection valueWithInternalTime:expectedInternalTime userTime:expectedUserTime userTimezone:[NSTimeZone timeZoneWithName:@"America/Montreal"] eventTime:expectedEventTime insulinType:UnknownInsulinType unitValue:3.25f insulinName:nil timestamp:0];
    InsulinInjection *convertedInjection = [syncData insulinInjections][0];
    XCTAssertEqualObjects(convertedInjection, expectedInjection);
}

- (void)testExerciseEventConversion {
    NSMutableArray *userEvents = [NSMutableArray array];
    [userEvents addObject:[UserEventRecord recordWithEventType:Exercise subType:Light eventValue:15 rawEventTimeInSeconds:1800 rawInternalTimeInSeconds:0 rawDisplayTimeInSeconds:1800 recordNumber:0 pageNumber:0 dexcomOffsetWithStandardInSeconds:0 timezone:[NSTimeZone timeZoneWithName:@"America/Montreal"]]];

    NSMutableArray *empty = [NSMutableArray array];
    SyncData *syncData = [SyncDataAdapter convertSyncData:[InternalSyncData dataWithGlucoseUnit:mgPerDL glucoseReads:empty calibrationReads:empty userEvents:userEvents manufacturingParameters:nil dexcomOffsetFromStandardEpoch:0]];

    NSDate *expectedUserTime = [NSDate dateWithTimeIntervalSince1970:1800];
    NSDate *expectedInternalTime = [NSDate dateWithTimeIntervalSince1970:0];
    NSDate *expectedEventTime = [NSDate dateWithTimeIntervalSince1970:1800 - 1800];
    ExerciseEvent *expectedExercise = [ExerciseEvent valueWithInternalTime:expectedInternalTime userTime:expectedUserTime userTimezone:[NSTimeZone timeZoneWithName:@"America/Montreal"] eventTime:expectedEventTime duration:15 * 60.f intensity:LightExercise details:nil timestamp:0];
    ExerciseEvent *convertedExercise = [syncData exerciseEvents][0];
    XCTAssertEqualObjects(convertedExercise, expectedExercise);
}

- (void)testFoodEventConversion {
    NSMutableArray *userEvents = [NSMutableArray array];
    [userEvents addObject:[UserEventRecord recordWithEventType:Carbs subType:0 eventValue:15 rawEventTimeInSeconds:1800 rawInternalTimeInSeconds:0 rawDisplayTimeInSeconds:1800 recordNumber:0 pageNumber:0 dexcomOffsetWithStandardInSeconds:0 timezone:[NSTimeZone timeZoneWithName:@"America/Montreal"]]];

    NSMutableArray *empty = [NSMutableArray array];
    SyncData *syncData = [SyncDataAdapter convertSyncData:[InternalSyncData dataWithGlucoseUnit:mgPerDL glucoseReads:empty calibrationReads:empty userEvents:userEvents manufacturingParameters:nil dexcomOffsetFromStandardEpoch:0]];

    NSDate *expectedUserTime = [NSDate dateWithTimeIntervalSince1970:1800];
    NSDate *expectedInternalTime = [NSDate dateWithTimeIntervalSince1970:0];
    // Expected Event time is adjusted by the user vs internal time offset
    NSDate *expectedEventTime = [NSDate dateWithTimeIntervalSince1970:1800 - 1800];
    FoodEvent *expectedFoodEvent = [FoodEvent valueWithInternalTime:expectedInternalTime userTime:expectedUserTime userTimezone:[NSTimeZone timeZoneWithName:@"America/Montreal"] eventTime:expectedEventTime carbohydrates:15.f proteins:UnknownNutrientValue fat:UnknownNutrientValue timestamp:0];
    FoodEvent *convertedFoodEvent = [syncData foodEvents][0];
    XCTAssertEqualObjects(convertedFoodEvent, expectedFoodEvent);
}

- (void)testEventTimestampConversion {
    NSMutableArray *userEvents = [NSMutableArray array];
    [userEvents addObject:[UserEventRecord recordWithEventType:Carbs subType:0 eventValue:15 rawEventTimeInSeconds:4000 rawInternalTimeInSeconds:25200 rawDisplayTimeInSeconds:0 recordNumber:0 pageNumber:0 dexcomOffsetWithStandardInSeconds:0 timezone:[NSTimeZone timeZoneWithName:@"America/Montreal"]]];

    NSMutableArray *empty = [NSMutableArray array];
    SyncData *syncData = [SyncDataAdapter convertSyncData:[InternalSyncData dataWithGlucoseUnit:mgPerDL glucoseReads:empty calibrationReads:empty userEvents:userEvents manufacturingParameters:nil dexcomOffsetFromStandardEpoch:0]];

    NSDate *expectedUserTime = [NSDate dateWithTimeIntervalSince1970:0];
    NSDate *expectedInternalTime = [NSDate dateWithTimeIntervalSince1970:25200];
    NSDate *expectedEventTime = [NSDate dateWithTimeIntervalSince1970:4000 - -25200];
    long long expectedTimestamp = (long long int) ([[NSDate dateWithTimeIntervalSince1970:29200] timeIntervalSince1970] * 1000);
    FoodEvent *expectedFoodEvent = [FoodEvent valueWithInternalTime:expectedInternalTime userTime:expectedUserTime userTimezone:[NSTimeZone timeZoneWithName:@"America/Montreal"] eventTime:expectedEventTime carbohydrates:15.f proteins:UnknownNutrientValue fat:UnknownNutrientValue timestamp:expectedTimestamp];
    FoodEvent *convertedFoodEvent = [syncData foodEvents][0];
    XCTAssertEqualObjects(convertedFoodEvent, expectedFoodEvent);

    XCTAssertEqual(convertedFoodEvent.timestamp, expectedTimestamp);
}

- (void)testHealthEventConversion {
    NSMutableArray *userEvents = [NSMutableArray array];
    [userEvents addObject:[UserEventRecord recordWithEventType:Health subType:Stress eventValue:0 rawEventTimeInSeconds:1800 rawInternalTimeInSeconds:0 rawDisplayTimeInSeconds:1800 recordNumber:0 pageNumber:0 dexcomOffsetWithStandardInSeconds:0 timezone:[NSTimeZone timeZoneWithName:@"America/Montreal"]]];

    NSMutableArray *empty = [NSMutableArray array];
    SyncData *syncData = [SyncDataAdapter convertSyncData:[InternalSyncData dataWithGlucoseUnit:mgPerDL glucoseReads:empty calibrationReads:empty userEvents:userEvents manufacturingParameters:nil dexcomOffsetFromStandardEpoch:0]];

    NSDate *expectedUserTime = [NSDate dateWithTimeIntervalSince1970:1800];
    NSDate *expectedInternalTime = [NSDate dateWithTimeIntervalSince1970:0];
    NSDate *expectedEventTime = [NSDate dateWithTimeIntervalSince1970:1800 - 1800];
    HealthEvent *expectedHealthEvent = [HealthEvent valueWithInternalTime:expectedInternalTime userTime:expectedUserTime userTimezone:[NSTimeZone timeZoneWithName:@"America/Montreal"] eventTime:expectedEventTime type:@"Stress" details:nil timestamp:0];
    HealthEvent *convertedHealthEvent = [syncData healthEvents][0];
    XCTAssertEqualObjects(convertedHealthEvent, expectedHealthEvent);
}

- (void)testMeterReadConversionWithMgPerDL {
    NSMutableArray *meterReadRecords = [NSMutableArray array];
    [meterReadRecords addObject:[MeterReadRecord recordWithMeterRead:75 rawInternalTimeInSeconds:0 rawDisplayTimeInSeconds:1800 rawMeterTimeInSeconds:1800 recordNumber:0 pageNumber:0 dexcomOffsetWithStandardInSeconds:0 timezone:[NSTimeZone timeZoneWithName:@"America/Montreal"]]];

    NSMutableArray *empty = [NSMutableArray array];
    SyncData *syncData = [SyncDataAdapter convertSyncData:[InternalSyncData dataWithGlucoseUnit:mgPerDL glucoseReads:empty calibrationReads:meterReadRecords userEvents:empty manufacturingParameters:nil dexcomOffsetFromStandardEpoch:0]];

    NSDate *expectedInternalTime = [NSDate dateWithTimeIntervalSince1970:0];
    NSDate *expectedUserTime = [NSDate dateWithTimeIntervalSince1970:1800];
    NSDate *expectedMeterTime = [NSDate dateWithTimeIntervalSince1970:1800 - 1800];
    MeterRead *expectedMeterRead = [MeterRead valueWithInternalTime:expectedInternalTime userTime:expectedUserTime timezone:[NSTimeZone timeZoneWithName:@"America/Montreal"] meterTime:expectedMeterTime meterRead:75.f glucoseMeasurementUnit:MG_PER_DL timestamp:(long long) ([expectedInternalTime timeIntervalSince1970] * 1000)];
    MeterRead *convertedMeterRead = [syncData calibrationReads][0];
    XCTAssertEqualObjects(convertedMeterRead, expectedMeterRead);
}

- (void)testMeterReadConversionWithMmolPerL {
    NSMutableArray *meterReadRecords = [NSMutableArray array];
    [meterReadRecords addObject:[MeterReadRecord recordWithMeterRead:47 rawInternalTimeInSeconds:0 rawDisplayTimeInSeconds:1800 rawMeterTimeInSeconds:1800 recordNumber:0 pageNumber:0 dexcomOffsetWithStandardInSeconds:0 timezone:[NSTimeZone timeZoneWithName:@"America/Montreal"]]];

    NSMutableArray *empty = [NSMutableArray array];
    SyncData *syncData = [SyncDataAdapter convertSyncData:[InternalSyncData dataWithGlucoseUnit:mmolPerL glucoseReads:empty calibrationReads:meterReadRecords userEvents:empty manufacturingParameters:nil dexcomOffsetFromStandardEpoch:0]];

    NSDate *expectedInternalTime = [NSDate dateWithTimeIntervalSince1970:0];
    NSDate *expectedUserTime = [NSDate dateWithTimeIntervalSince1970:1800];
    NSDate *expectedMeterTime = [NSDate dateWithTimeIntervalSince1970:1800 - 1800];
    MeterRead *expectedMeterRead = [MeterRead valueWithInternalTime:expectedInternalTime userTime:expectedUserTime timezone:[NSTimeZone timeZoneWithName:@"America/Montreal"] meterTime:expectedMeterTime meterRead:2.608474 glucoseMeasurementUnit:MMOL_PER_L timestamp:(long long) ([expectedInternalTime timeIntervalSince1970] * 1000)];
    MeterRead *convertedMeterRead = [syncData calibrationReads][0];

    XCTAssertEqualWithAccuracy([convertedMeterRead meterRead], [expectedMeterRead meterRead], 0.001);
}

- (void)testGlucoseReadTimeResolution {
    NSMutableArray *glucoseRecords = [NSMutableArray array];
    [glucoseRecords addObject:[GlucoseReadRecord recordWithRawInternalTimeInSeconds:178778995 rawDisplayTimeInSeconds:178753913 glucoseValue:76 trendArrowAndNoise:20 recordNumber:157549 pageNumber:4146 dexcomOffsetWithStandardInSeconds:-1230768181 timezone:[NSTimeZone timeZoneWithName:@"America/Montreal"]]];

    NSMutableArray *empty = [NSMutableArray array];
    SyncData *syncData = [SyncDataAdapter convertSyncData:[InternalSyncData dataWithGlucoseUnit:mgPerDL glucoseReads:glucoseRecords calibrationReads:empty userEvents:empty manufacturingParameters:nil dexcomOffsetFromStandardEpoch:0]];

    NSDate *expectedUserTime = [NSDate dateWithTimeIntervalSince1970:178753913 + 1230768181];
    NSDate *expectedInternalTime = [NSDate dateWithTimeIntervalSince1970:178778995 + 1230768181];
    GlucoseRead *expectedRead = [GlucoseRead valueWithInternalTime:expectedInternalTime userTime:expectedUserTime timezone:[NSTimeZone timeZoneWithName:@"America/Montreal"] value:76.f unit:MG_PER_DL timestamp:(long long) ([expectedInternalTime timeIntervalSince1970] * 1000)];
    GlucoseRead *convertedRead = [syncData glucoseReads][0];
    XCTAssertEqualObjects(convertedRead, expectedRead);

    XCTAssertEqual(convertedRead.timestamp, ([expectedInternalTime timeIntervalSince1970] * 1000));
}
@end
