#import <Foundation/Foundation.h>
#import "ResponsePayload.h"


@interface GenericPayload : ResponsePayload
@property(readonly) Byte content;

- (instancetype)initWithPayloadContent:(Byte)content;

- (NSString *)description;

+ (instancetype)payloadWithContent:(Byte)content;

@end