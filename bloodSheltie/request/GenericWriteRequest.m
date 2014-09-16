#import "GenericWriteRequest.h"


@implementation GenericWriteRequest {

}
- (instancetype)initWithCommand:(ReceiverCommand)command parameter:(Byte)parameter {
    self = [super initWithCommand:command];
    if (self) {
        _parameter=parameter;
        _commandSize = 7;
    }

    return self;
}
@end