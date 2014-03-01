#import "ExerciseEvent.h"


@implementation ExerciseEvent {

}
- (instancetype)initWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime userTimezone:(NSTimeZone *)userTimezone eventTime:(NSDate *)eventTime duration:(NSTimeInterval)duration intensity:(Intensity)intensity details:(NSString *)details {
    self = [super initWithInternalTime:internalTime userTime:userTime userTimezone:userTimezone eventTime:eventTime];
    if (self) {
        _intensity = intensity;
        _duration = duration;
        _details = details;
    }
    return self;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.duration=%f", self.duration];
    [description appendFormat:@", self.intensity=%d", self.intensity];
    [description appendFormat:@", self.details=%@", self.details];
    [description appendString:@">"];
    return description;
}


+ (instancetype)valueWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime userTimezone:(NSTimeZone *)userTimezone eventTime:(NSDate *)eventTime duration:(NSTimeInterval)duration intensity:(Intensity)intensity details:(NSString *)details {
    return [[self alloc] initWithInternalTime:internalTime userTime:userTime userTimezone:userTimezone eventTime:eventTime duration:duration intensity:intensity details:details];
}


@end