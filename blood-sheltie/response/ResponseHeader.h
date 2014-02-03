#import <Foundation/Foundation.h>
#import "Types.h"


@interface ResponseHeader : NSObject
@property(readonly) ReceiverCommand command;
@property(readonly) uint16_t packetSize;

- (instancetype)initWithCommand:(ReceiverCommand)command packetSize:(uint16_t)packetSize;

+ (instancetype)headerWithCommand:(ReceiverCommand)command packetSize:(uint16_t)packetSize;

@end