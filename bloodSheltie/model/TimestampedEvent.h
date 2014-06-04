#import <Foundation/Foundation.h>
#import "TimestampedValue.h"


@interface TimestampedEvent : TimestampedValue
@property(readonly) NSDate *eventTime;

- (instancetype)initWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime userTimezone:(NSTimeZone *)userTimezone eventTime:(NSDate *)eventTime timestamp:(long long int)timestamp;

- (NSString *)description;

+ (instancetype)valueWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime userTimezone:(NSTimeZone *)userTimezone eventTime:(NSDate *)eventTime timestamp:(long long int)timestamp;

@end