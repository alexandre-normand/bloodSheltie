#import "SyncDataAdapter.h"
#import "GlucoseReadRecord.h"
#import "GlucoseRead.h"
#import "UserEventRecord.h"
#import "InsulinInjection.h"
#import "ExerciseEvent.h"
#import "FoodEvent.h"
#import "HealthEvent.h"
#import "MeterRead.h"
#import "MeterReadRecord.h"


@implementation SyncDataAdapter {

}
+ (SyncData *)convertSyncData:(InternalSyncData *)internalSyncData {
    NSArray *glucoseReads = [self convertGlucoseReads:[internalSyncData glucoseReads] withUnit:(internalSyncData.glucoseUnit) andTimeOffset:[internalSyncData timeOffsetInSeconds]];
    NSArray *injections = [self convertInsulinInjections:[internalSyncData userEvents] andTimeOffset:[internalSyncData timeOffsetInSeconds]];
    NSArray *exercises = [self convertExerciseEvents:[internalSyncData userEvents] andTimeOffset:[internalSyncData timeOffsetInSeconds]];
    NSArray *foodEvents = [self convertFoodEvents:[internalSyncData userEvents] andTimeOffset:[internalSyncData timeOffsetInSeconds]];
    NSArray *healthEvents = [self convertHealthEvents:[internalSyncData userEvents] andTimeOffset:[internalSyncData timeOffsetInSeconds]];
    NSArray *meterReads = [self convertMeterReads:[internalSyncData calibrationReads] unit:(internalSyncData.glucoseUnit) andTimeOffset:[internalSyncData timeOffsetInSeconds]];

    return [SyncData dataWithGlucoseReads:glucoseReads
                         calibrationReads:meterReads
                        insulinInjections:injections
                           exerciseEvents:exercises
                             healthEvents:healthEvents
                               foodEvents:foodEvents
                  manufacturingParameters:internalSyncData.manufacturingParameters];
}

+ (NSArray *)convertInsulinInjections:(NSMutableArray *)userEvents andTimeOffset:(int32_t)timeOffsetInSeconds {
    NSTimeZone *userTimezone = [Types timezoneFromOffsetInSeconds:timeOffsetInSeconds];
    NSMutableArray *converted = [NSMutableArray array];
    for (id event in userEvents) {
        UserEventRecord *record = (UserEventRecord *) event;
        if (record.eventType == Insulin) {
            InsulinInjection *injection = [InsulinInjection valueWithInternalTime:record.internalTime
                                                                         userTime:record.localTime
                                                                     userTimezone:userTimezone
                                                                        eventTime:record.eventTime
                                                                      insulinType:UnknownInsulinType
                                                                        unitValue:record.eventValue / 100.f
                                                                      insulinName:nil
                                                                        timestamp:[self getTimestampEventTime:record.eventTime timeOffsetInSeconds:timeOffsetInSeconds]];
            [converted addObject:injection];
        }
    }
    return converted;
}

+ (NSArray *)convertExerciseEvents:(NSMutableArray *)userEvents andTimeOffset:(int32_t)timeOffsetInSeconds {
    NSTimeZone *userTimezone = [Types timezoneFromOffsetInSeconds:timeOffsetInSeconds];
    NSMutableArray *converted = [NSMutableArray array];
    for (id event in userEvents) {
        UserEventRecord *record = (UserEventRecord *) event;
        if (record.eventType == Exercise) {
            ExerciseEvent *exercise = [ExerciseEvent valueWithInternalTime:record.internalTime
                                                                  userTime:record.localTime
                                                              userTimezone:userTimezone
                                                                 eventTime:record.eventTime
                                                                  duration:record.eventValue * 60
                                                                 intensity:[self convertExerciseIntensity:(ExerciseEventSubType) [record subType]]
                                                                   details:nil
                                                                 timestamp:[self getTimestampEventTime:record.eventTime timeOffsetInSeconds:timeOffsetInSeconds]];
            [converted addObject:exercise];
        }
    }
    return converted;
}

+ (NSArray *)convertHealthEvents:(NSMutableArray *)userEvents andTimeOffset:(int32_t)timeOffsetInSeconds {
    NSTimeZone *userTimezone = [Types timezoneFromOffsetInSeconds:timeOffsetInSeconds];
    NSMutableArray *converted = [NSMutableArray array];
    for (id event in userEvents) {
        UserEventRecord *record = (UserEventRecord *) event;
        if (record.eventType == Health) {
            HealthEvent *healthEvent = [HealthEvent valueWithInternalTime:record.internalTime
                                                                 userTime:record.localTime
                                                             userTimezone:userTimezone
                                                                eventTime:record.eventTime
                                                                     type:[Types healthEventSubTypeIdentifier:(HealthEventSubType) record.subType]
                                                                  details:nil
                                                                timestamp:[self getTimestampEventTime:record.eventTime timeOffsetInSeconds:timeOffsetInSeconds]];
            [converted addObject:healthEvent];
        }
    }
    return converted;
}

+ (Intensity)convertExerciseIntensity:(ExerciseEventSubType)type {
    switch (type) {
        case Heavy:
            return HeavyExercise;
        case Light:
            return LightExercise;
        case Medium:
            return MediumExercise;
        default:
            return UnknownExerciseIntensity;
    }
}

+ (NSArray *)convertFoodEvents:(NSMutableArray *)userEvents andTimeOffset:(int32_t)timeOffsetInSeconds {
    NSTimeZone *userTimezone = [Types timezoneFromOffsetInSeconds:timeOffsetInSeconds];
    NSMutableArray *converted = [NSMutableArray array];
    for (id event in userEvents) {
        UserEventRecord *record = (UserEventRecord *) event;
        if (record.eventType == Carbs) {
            FoodEvent *foodEvent = [FoodEvent valueWithInternalTime:record.internalTime
                                                           userTime:record.localTime
                                                       userTimezone:userTimezone
                                                          eventTime:record.eventTime
                                                      carbohydrates:record.eventValue
                                                           proteins:UnknownNutrientValue
                                                                fat:UnknownNutrientValue
                                                          timestamp:[self getTimestampEventTime:record.eventTime timeOffsetInSeconds:timeOffsetInSeconds]];
            [converted addObject:foodEvent];
        }
    }
    return converted;
}

+ (long long)getTimestampEventTime:(NSDate *)eventTime timeOffsetInSeconds:(int32_t)offset {
    NSTimeInterval timestamp = ([eventTime timeIntervalSince1970] - offset) * 1000;

    return (long long) timestamp;
}

+ (NSArray *)convertGlucoseReads:(NSArray *)internalReads withUnit:(GlucoseUnit)unit andTimeOffset:(int32_t)timeOffsetInSeconds {
    NSTimeZone *userTimezone = [Types timezoneFromOffsetInSeconds:timeOffsetInSeconds];
    NSMutableArray *converted = [NSMutableArray arrayWithCapacity:[internalReads count]];
    for (id read in internalReads) {
        GlucoseReadRecord *record = (GlucoseReadRecord *) read;
        GlucoseRead *glucoseRead = [GlucoseRead valueWithInternalTime:record.internalTime
                                                             userTime:record.localTime
                                                             timezone:userTimezone
                                                                value:[self convertGlucoseValue:record.glucoseValue unit:unit]
                                                                 unit:[self convertGlucoseUnit:unit]
                                                            timestamp:(long long) (([[record localTime] timeIntervalSince1970] - timeOffsetInSeconds) * 1000)];
        [converted addObject:glucoseRead];
    }
    return converted;
}

+ (float)convertGlucoseValue:(uint16_t)value unit:(GlucoseUnit)unit {
    switch (unit) {
        case mgPerDL:
            return value;
        case mmolPerL:
            return value / 10.f;
        default:
            NSLog(@"No unit, converting glucose value as is.");
            return value;
    }
}

+ (GlucoseMeasurementUnit)convertGlucoseUnit:(GlucoseUnit)type {
    switch (type) {
        case mgPerDL:
            return MG_PER_DL;
        case mmolPerL:
            return MMOL_PER_L;
        case NoUnit:
            return UNKNOWN_MEASUREMENT_UNIT;
    }

    return UNKNOWN_MEASUREMENT_UNIT;
}

+ (NSArray *)convertMeterReads:(NSMutableArray *)internalCalibrationReads unit:(GlucoseUnit)unit andTimeOffset:(int32_t)timeOffsetInSeconds {
    NSTimeZone *userTimezone = [Types timezoneFromOffsetInSeconds:timeOffsetInSeconds];
    NSMutableArray *converted = [NSMutableArray arrayWithCapacity:[internalCalibrationReads count]];
    for (id read in internalCalibrationReads) {
        MeterReadRecord *record = (MeterReadRecord *) read;
        MeterRead *meterRead = [MeterRead valueWithInternalTime:record.internalTime
                                                       userTime:record.localTime
                                                       timezone:userTimezone
                                                      meterTime:[record meterTime]
                                                      meterRead:[self convertGlucoseValue:record.meterRead unit:unit]
                                         glucoseMeasurementUnit:[self convertGlucoseUnit:unit]
                                                      timestamp:(long long) (([[record localTime] timeIntervalSince1970] - timeOffsetInSeconds) * 1000)];
        [converted addObject:meterRead];
    }
    return converted;
}

@end