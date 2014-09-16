#import <Foundation/Foundation.h>
#import "TimestampedValue.h"
#import "ModelTypes.h"

@interface MeterRead : TimestampedValue
@property(readonly) NSDate *meterTime;
@property(readonly) double meterRead;
@property(readonly) GlucoseMeasurementUnit glucoseMeasurementUnit;

- (instancetype)initWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime timezone:(NSTimeZone *)userTimezone meterTime:(NSDate *)meterTime meterRead:(double)meterRead glucoseMeasurementUnit:(GlucoseMeasurementUnit)glucoseMeasurementUnit timestamp:(long long)timestamp;

- (NSString *)description;

+ (instancetype)valueWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime timezone:(NSTimeZone *)userTimezone meterTime:(NSDate *)meterTime meterRead:(double)meterRead glucoseMeasurementUnit:(GlucoseMeasurementUnit)glucoseMeasurementUnit timestamp:(long long)timestamp;

@end