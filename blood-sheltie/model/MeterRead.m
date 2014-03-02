#import "MeterRead.h"


@implementation MeterRead {

}

- (instancetype)initWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime timezone:(NSTimeZone *)userTimezone meterTime:(NSDate *)meterTime meterRead:(float)meterRead {
    self = [super initWithInternalTime:internalTime userTime:userTime timezone:userTimezone];
    if (self) {
        _meterRead = meterRead;
        _meterTime = meterTime;
    }
    return self;
}

+ (instancetype)valueWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime timezone:(NSTimeZone *)userTimezone meterTime:(NSDate *)meterTime meterRead:(float)meterRead {
    return [[self alloc] initWithInternalTime:internalTime userTime:userTime timezone:userTimezone meterTime:meterTime meterRead:meterRead];
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString string];
    [description appendFormat:@"self.meterTime=%@", self.meterTime];
    [description appendFormat:@", self.meterRead=%f", self.meterRead];

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