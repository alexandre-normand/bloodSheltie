#import <Foundation/Foundation.h>
#import "ReceiverRequest.h"


@interface GenericWriteRequest : ReceiverRequest
@property(readonly) Byte parameter;


- (instancetype)initWithCommand:(ReceiverCommand)command parameter:(Byte)parameter;

@end