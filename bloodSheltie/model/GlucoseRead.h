#import <Foundation/Foundation.h>
#import "TimestampedValue.h"
#import "ModelTypes.h"

@interface GlucoseRead : TimestampedValue
@property(readonly) float glucoseValue;
@property(readonly) GlucoseMeasurementUnit glucoseMeasurementUnit;

- (instancetype)initWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime timezone:(NSTimeZone *)userTimezone value:(float)value unit:(GlucoseMeasurementUnit)unit timestamp:(long long)timestamp;

- (NSString *)description;

+ (instancetype)valueWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime timezone:(NSTimeZone *)userTimezone value:(float)value unit:(GlucoseMeasurementUnit)unit timestamp:(long long)timestamp;

@end