#import <Foundation/Foundation.h>
#import "ResponseHeader.h"
#import "ResponsePayload.h"

@interface ReceiverResponse : NSObject
@property(readonly) ResponseHeader *header;
@property(readonly) ResponsePayload *payload;

- (instancetype)initWithHeader:(ResponseHeader *)header andPayload:(ResponsePayload *)payload;

+ (instancetype)responseWithHeader:(ResponseHeader *)header andPayload:(ResponsePayload *)payload;

@end