#import <Foundation/Foundation.h>
#import "GenericPayload.h"


@interface TimeOffset : ResponsePayload

@property(readonly) int32_t timeoffsetInSeconds;

- (instancetype)initWithTimeoffsetInSeconds:(int32_t)timeoffsetInSeconds;

+ (instancetype)offsetWithTimeoffsetInSeconds:(int32_t)timeoffsetInSeconds;

- (NSString *)description;

@end