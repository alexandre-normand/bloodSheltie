#import <Foundation/Foundation.h>
#import "ReceiverResponse.h"
#import "ReceiverRequest.h"


@interface DefaultDecoder : NSObject

+ (ReceiverResponse *)decodeResponse:(NSData *)responseData toRequest:(ReceiverRequest *)request;

+ (ResponseHeader *)decodeHeader:(NSData *)header;
@end