#import <Foundation/Foundation.h>
#import "TimestampedEvent.h"

const float UNKNOWN = -1.f;

@interface FoodEvent : TimestampedEvent
@property(readonly) float carbohydrates;
@property(readonly) float proteins;
@property(readonly) float fat;

- (instancetype)initWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime userTimezone:(NSTimeZone *)userTimezone eventTime:(NSDate *)eventTime carbohydrates:(float)carbohydrates proteins:(float)proteins fat:(float)fat;

+ (instancetype)valueWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime userTimezone:(NSTimeZone *)userTimezone eventTime:(NSDate *)eventTime carbohydrates:(float)carbohydrates proteins:(float)proteins fat:(float)fat;

- (NSString *)description;
@end