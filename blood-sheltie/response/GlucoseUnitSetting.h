#import <Foundation/Foundation.h>
#import "GenericPayload.h"
#import "Types.h"


@interface GlucoseUnitSetting : GenericPayload

- (instancetype)initWithGlucoseUnit:(GlucoseUnit)glucoseUnit;

+ (instancetype)settingWithGlucoseUnit:(GlucoseUnit)glucoseUnit;

- (GlucoseUnit)glucoseUnit;

- (NSString *)description;


@end