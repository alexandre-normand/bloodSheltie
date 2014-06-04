#import "GlucoseRead.h"


@implementation GlucoseRead {

}
- (instancetype)initWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime timezone:(NSTimeZone *)userTimezone value:(float)value unit:(GlucoseMeasurementUnit)unit timestamp:(long long)timestamp {
    self = [super initWithInternalTime:internalTime userTime:userTime timestamp:timestamp timezone:userTimezone];
    if (self) {
        _glucoseValue = value;
        _glucoseMeasurementUnit =unit;
    }
    return self;
}

+ (instancetype)valueWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime timezone:(NSTimeZone *)userTimezone value:(float)value unit:(GlucoseMeasurementUnit)unit timestamp:(long long)timestamp {
    return [[self alloc] initWithInternalTime:internalTime userTime:userTime timezone:userTimezone value:value unit:unit timestamp:timestamp];
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString string];
    [description appendFormat:@"self.glucoseValue=%f", self.glucoseValue];
    [description appendFormat:@", self.glucoseMeasurementUnit=%d", self.glucoseMeasurementUnit];

    NSMutableString *superDescription = [[super description] mutableCopy];
    NSUInteger length = [superDescription length];

    if (length > 0 && [superDescription characterAtIndex:length - 1] == '>') {
        [superDescription insertString:@", " atIndex:length - 1];
        [superDescription insertString:description atIndex:length + 1];
        return superDescription;
    }
    else {
        return [NSString stringWithFormat:@"<%@: %@>", NSStringFromClass([self class]), description];
    }
}


@end