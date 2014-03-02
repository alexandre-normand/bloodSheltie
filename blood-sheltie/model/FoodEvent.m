#import "FoodEvent.h"


@implementation FoodEvent {

}
- (instancetype)initWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime userTimezone:(NSTimeZone *)userTimezone eventTime:(NSDate *)eventTime carbohydrates:(float)carbohydrates proteins:(float)proteins fat:(float)fat {
    self = [super initWithInternalTime:internalTime userTime:userTime userTimezone:userTimezone eventTime:eventTime];
    if (self) {
        _carbohydrates = carbohydrates;
        _proteins = proteins;
        _fat = fat;
    }
    return self;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.carbohydrates=%f", self.carbohydrates];
    [description appendFormat:@", self.proteins=%f", self.proteins];
    [description appendFormat:@", self.fat=%f", self.fat];
    [description appendString:@">"];
    return description;
}


+ (instancetype)valueWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime userTimezone:(NSTimeZone *)userTimezone eventTime:(NSDate *)eventTime carbohydrates:(float)carbohydrates proteins:(float)proteins fat:(float)fat {
    return [[self alloc] initWithInternalTime:internalTime userTime:userTime userTimezone:userTimezone eventTime:eventTime carbohydrates:carbohydrates proteins:proteins fat:fat];
}

@end