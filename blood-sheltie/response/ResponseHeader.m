#import "ResponseHeader.h"


@implementation ResponseHeader {

}
- (instancetype)initWithCommand:(ReceiverCommand)command packetSize:(uint16_t)packetSize {
    self = [super init];
    if (self) {
        _command = command;
        _packetSize=packetSize;
    }

    return self;
}

+ (instancetype)headerWithCommand:(ReceiverCommand)command packetSize:(uint16_t)packetSize {
    return [[self alloc] initWithCommand:command packetSize:packetSize];
}

- (NSString *)description {
    return [NSString stringWithFormat: @"command=%s size=%d", [[Types receiverCommandIdentifier:_command] UTF8String],
                    _packetSize];
}
@end