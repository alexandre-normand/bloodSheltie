#import <Foundation/Foundation.h>
#import "TimestampedValue.h"


@interface MeterRead : TimestampedValue
@property(readonly) NSDate *meterTime;
@property(readonly) float meterRead;

- (instancetype)initWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime timezone:(NSTimeZone *)userTimezone meterTime:(NSDate *)meterTime meterRead:(float)meterRead;

- (NSString *)description;

+ (instancetype)valueWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime timezone:(NSTimeZone *)userTimezone meterTime:(NSDate *)meterTime meterRead:(float)meterRead;

@end