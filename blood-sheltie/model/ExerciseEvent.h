#import <Foundation/Foundation.h>
#import "TimestampedEvent.h"

typedef enum Intensity : Byte Intensity;
enum Intensity : Byte {
    Light = 0,
    Medium = 1,
    Heavy = 2
};

@interface ExerciseEvent : TimestampedEvent
@property(readonly) NSTimeInterval duration;
@property(readonly) Intensity intensity;
@property(readonly) NSString *details;

- (instancetype)initWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime userTimezone:(NSTimeZone *)userTimezone eventTime:(NSDate *)eventTime duration:(NSTimeInterval)duration intensity:(Intensity)intensity details:(NSString *)details;

+ (instancetype)valueWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime userTimezone:(NSTimeZone *)userTimezone eventTime:(NSDate *)eventTime duration:(NSTimeInterval)duration intensity:(Intensity)intensity details:(NSString *)details;

- (NSString *)description;
@end