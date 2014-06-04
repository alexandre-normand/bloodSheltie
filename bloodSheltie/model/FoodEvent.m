#import "FoodEvent.h"


@implementation FoodEvent {

}
- (instancetype)initWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime userTimezone:(NSTimeZone *)userTimezone eventTime:(NSDate *)eventTime carbohydrates:(float)carbohydrates proteins:(float)proteins fat:(float)fat timestamp:(long long)timestamp {
    self = [super initWithInternalTime:internalTime userTime:userTime userTimezone:userTimezone eventTime:eventTime timestamp:timestamp];
    if (self) {
        _carbohydrates = carbohydrates;
        _proteins = proteins;
        _fat = fat;
    }
    return self;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString string];
    [description appendFormat:@"self.carbohydrates=%f", self.carbohydrates];
    [description appendFormat:@", self.proteins=%f", self.proteins];
    [description appendFormat:@", self.fat=%f", self.fat];

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


+ (instancetype)valueWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime userTimezone:(NSTimeZone *)userTimezone eventTime:(NSDate *)eventTime carbohydrates:(float)carbohydrates proteins:(float)proteins fat:(float)fat timestamp:(long long)timestamp {
    return [[self alloc] initWithInternalTime:internalTime userTime:userTime userTimezone:userTimezone eventTime:eventTime carbohydrates:carbohydrates proteins:proteins fat:fat timestamp:timestamp];
}

@end