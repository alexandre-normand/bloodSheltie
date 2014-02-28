#import <Foundation/Foundation.h>
#import "TimestampedEvent.h"

const float UNKNOWN = -1.f;

@interface FoodEvent : TimestampedEvent
@property(readonly) float carbohydrates;
@property(readonly) float proteins;
@property(readonly) float fat;
@end