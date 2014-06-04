#import "InsulinInjection.h"


@implementation InsulinInjection {

}
- (instancetype)initWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime userTimezone:(NSTimeZone *)userTimezone eventTime:(NSDate *)eventTime insulinType:(InsulinType)insulinType unitValue:(float)unitValue insulinName:(NSString *)insulinName timestamp:(long long)timestamp {
    self = [super initWithInternalTime:internalTime userTime:userTime userTimezone:userTimezone eventTime:eventTime timestamp:timestamp];
    if (self) {
        _insulinType = insulinType;
        _insulinName = insulinName;
        _unitValue = unitValue;
    }
    return self;
}

+ (instancetype)valueWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime userTimezone:(NSTimeZone *)userTimezone eventTime:(NSDate *)eventTime insulinType:(InsulinType)insulinType unitValue:(float)unitValue insulinName:(NSString *)insulinName timestamp:(long long)timestamp {
    return [[self alloc] initWithInternalTime:internalTime userTime:userTime userTimezone:userTimezone eventTime:eventTime insulinType:insulinType unitValue:unitValue insulinName:insulinName timestamp:timestamp];
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString string];
    [description appendFormat:@"self.insulinName=%@", self.insulinName];
    [description appendFormat:@", self.insulinType=%d", self.insulinType];
    [description appendFormat:@", self.unitValue=%f", self.unitValue];

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