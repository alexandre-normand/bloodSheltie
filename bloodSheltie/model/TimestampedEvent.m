#import "TimestampedEvent.h"


@implementation TimestampedEvent {

}
- (instancetype)initWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime userTimezone:(NSTimeZone *)userTimezone eventTime:(NSDate *)eventTime timestamp:(long long)timestamp {    
    self = [super initWithInternalTime:internalTime userTime:userTime timestamp:timestamp timezone:userTimezone];
    if (self) {
        _eventTime = eventTime;
    }
    return self;
}

+ (instancetype)valueWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime userTimezone:(NSTimeZone *)userTimezone eventTime:(NSDate *)eventTime timestamp:(long long)timestamp {
    return [[self alloc] initWithInternalTime:internalTime userTime:userTime userTimezone:userTimezone eventTime:eventTime timestamp:timestamp];
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString string];
    [description appendFormat:@"self.eventTime=%@", self.eventTime];

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