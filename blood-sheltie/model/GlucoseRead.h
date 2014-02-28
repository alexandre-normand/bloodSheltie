#import <Foundation/Foundation.h>
#import "TimestampedValue.h"

typedef enum GlucoseMeasurementUnit : Byte GlucoseMeasurementUnit;
enum GlucoseMeasurementUnit : Byte {
    UNKNOWN = 0,
    MMOL_PER_L = 1,
    MG_PER_DL = 2
};

@interface GlucoseRead : TimestampedValue
@property(readonly) float value;
@property(readonly) GlucoseMeasurementUnit unit;

- (instancetype)initWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime timezone:(NSTimeZone *)userTimezone value:(float)value unit:(GlucoseMeasurementUnit)unit;

+ (instancetype)valueWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime timezone:(NSTimeZone *)userTimezone value:(float)value unit:(GlucoseMeasurementUnit)unit;

@end