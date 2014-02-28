#import <Foundation/Foundation.h>
#import "TimestampedValue.h"


@interface TimestampedEvent : TimestampedValue
@property(readonly) NSDate *eventTime;
@end