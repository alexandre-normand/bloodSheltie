#import "DexcomTime.h"


@implementation DexcomTime {

}

- (instancetype)initWithTimeInSeconds:(uint32_t)timeInSeconds {
    self = [super init];
    if (self) {
        _timeInSeconds = timeInSeconds;
    }

    return self;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.timeInSeconds=%u", self.timeInSeconds];
    [description appendString:@">"];
    return description;
}


+ (instancetype)withTimeInSeconds:(uint32_t)timeInSeconds {
    return [[self alloc] initWithTimeInSeconds:timeInSeconds];
}

@end