#import <Foundation/Foundation.h>
#import "Types.h"

@interface ReceiverRequest : NSObject {
@protected
    uint16_t _commandSize;
}
@property(readonly) Byte sizeOfField;
@property(readonly) ReceiverCommand command;

- (id)initWithCommand:(ReceiverCommand) command;
- (uint16_t) getCommandSize;
@end