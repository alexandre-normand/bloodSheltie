#import "ExerciseEvent.h"

@implementation ExerciseEvent {

}
- (instancetype)initWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime userTimezone:(NSTimeZone *)userTimezone eventTime:(NSDate *)eventTime duration:(NSTimeInterval)duration intensity:(Intensity)intensity details:(NSString *)details timestamp:(long long)timestamp {
    self = [super initWithInternalTime:internalTime userTime:userTime userTimezone:userTimezone eventTime:eventTime timestamp:timestamp];
    if (self) {
        _intensity = intensity;
        _duration = duration;
        _details = details;
    }
    return self;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString string];
    [description appendFormat:@"self.duration=%f", self.duration];
    [description appendFormat:@", self.intensity=%d", self.intensity];
    [description appendFormat:@", self.details=%@", self.details];

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


+ (instancetype)valueWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime userTimezone:(NSTimeZone *)userTimezone eventTime:(NSDate *)eventTime duration:(NSTimeInterval)duration intensity:(Intensity)intensity details:(NSString *)details timestamp:(long long)timestamp {
    return [[self alloc] initWithInternalTime:internalTime userTime:userTime userTimezone:userTimezone eventTime:eventTime duration:duration intensity:intensity details:details timestamp:timestamp];
}


@end