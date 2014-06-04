#import <Foundation/Foundation.h>
#import "TimestampedEvent.h"

typedef enum Intensity : Byte Intensity;
enum Intensity : Byte {
    UnknownExerciseIntensity = -1,
    LightExercise = 0,
    MediumExercise = 1,
    HeavyExercise = 2
};

@interface ExerciseEvent : TimestampedEvent
@property(readonly) NSTimeInterval duration;
@property(readonly) Intensity intensity;
@property(readonly) NSString *details;

- (instancetype)initWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime userTimezone:(NSTimeZone *)userTimezone eventTime:(NSDate *)eventTime duration:(NSTimeInterval)duration intensity:(Intensity)intensity details:(NSString *)details timestamp:(long long)timestamp;

+ (instancetype)valueWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime userTimezone:(NSTimeZone *)userTimezone eventTime:(NSDate *)eventTime duration:(NSTimeInterval)duration intensity:(Intensity)intensity details:(NSString *)details timestamp:(long long)timestamp;

- (NSString *)description;
@end