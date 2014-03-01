#import "TimestampedValue.h"


@implementation TimestampedValue {

}
- (instancetype)initWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime timezone:(NSTimeZone *)timezone {
    self = [super init];
    if (self) {
        _internalTime = internalTime;
        _userTime=userTime;
        _timezone=timezone;
    }

    return self;
}

+ (instancetype)valueWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime timezone:(NSTimeZone *)timezone {
    return [[self alloc] initWithInternalTime:internalTime userTime:userTime timezone:timezone];
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString string];
    [description appendFormat:@"self.internalTime=%@", self.internalTime];
    [description appendFormat:@", self.userTime=%@", self.userTime];
    [description appendFormat:@", self.timezone=%@", self.timezone];

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