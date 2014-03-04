#import "GlucoseUnitSetting.h"


@implementation GlucoseUnitSetting {

}
- (instancetype)initWithGlucoseUnit:(GlucoseUnit)glucoseUnit {
    self = [super initWithPayloadContent:glucoseUnit];

    return self;
}

+ (instancetype)settingWithGlucoseUnit:(GlucoseUnit)glucoseUnit {
    return [[self alloc] initWithGlucoseUnit:glucoseUnit];
}

- (GlucoseUnit)glucoseUnit {
    return (GlucoseUnit) [self content];
}

- (NSString *)description {
    return [super description];
}

@end