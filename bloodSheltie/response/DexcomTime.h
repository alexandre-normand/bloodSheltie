#import <Foundation/Foundation.h>
#import "ResponsePayload.h"


@interface DexcomTime : ResponsePayload

@property(readonly) uint32_t timeInSeconds;

- (instancetype)initWithTimeInSeconds:(uint32_t)timeInSeconds;

+ (instancetype)withTimeInSeconds:(uint32_t)timeInSeconds;

- (NSString *)description;

@end