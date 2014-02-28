#import "GlucoseRead.h"


@implementation GlucoseRead {

}
- (instancetype)initWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime timezone:(NSTimeZone *)userTimezone value:(float)value unit:(GlucoseMeasurementUnit)unit {
    self = [super initWithInternalTime:internalTime userTime:userTime timezone:userTimezone];
    if (self) {
        _value = value;
        _unit=unit;
    }
    return self;
}

+ (instancetype)valueWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime timezone:(NSTimeZone *)userTimezone value:(float)value unit:(GlucoseMeasurementUnit)unit {
    return [[self alloc] initWithInternalTime:internalTime userTime:userTime timezone:userTimezone value:value unit:unit];
}

@end