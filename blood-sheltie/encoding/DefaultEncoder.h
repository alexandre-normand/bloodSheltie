#import <Foundation/Foundation.h>

@class ReceiverRequest;


@interface DefaultEncoder : NSObject
- (const void *)encodeRequest:(ReceiverRequest *)request;
@end