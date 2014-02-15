#import "ReceiverEvent.h"

@implementation ReceiverEvent
- (instancetype)initWithPort:(ORSSerialPort *)port {
    self = [super init];
    if (self) {
        self.port = port;
    }

    return self;
}

+ (instancetype)eventWithPort:(ORSSerialPort *)port {
    return [[self alloc] initWithPort:port];
}


@end
