#import <Foundation/Foundation.h>
#import "ReceiverResponse.h"
#import "ReceiverRequest.h"


@interface DefaultDecoder : NSObject

+ (ReceiverResponse *)decodeResponse:(NSData *)responseData toRequest:(ReceiverRequest *)request dexcomOffsetWithStandardEpoch:(int32_t)dexcomOffsetWithStandardEpoch timezone:(NSTimeZone *)userTimezone;

+ (ResponseHeader *)decodeHeader:(NSData *)header;
@end