#import "TimeOffset.h"


@implementation TimeOffset {

}
- (instancetype)initWithTimeoffsetInSeconds:(int32_t)timeoffsetInSeconds {
    self = [super init];
    if (self) {
        _timeoffsetInSeconds = timeoffsetInSeconds;
    }

    return self;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.timeoffsetInSeconds=%i", self.timeoffsetInSeconds];
    [description appendString:@">"];
    return description;
}


+ (instancetype)offsetWithTimeoffsetInSeconds:(int32_t)timeoffsetInSeconds {
    return [[self alloc] initWithTimeoffsetInSeconds:timeoffsetInSeconds];
}


@end