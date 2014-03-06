#import "SyncEvent.h"
#import "ORSSerialPort.h"

@implementation SyncEvent {

}
- (instancetype)initWithPort:(ORSSerialPort *)port syncData:(SyncData *)syncData {
    self = [super init];
    if (self) {
        _port = port;
        _syncData = syncData;
    }

    return self;
}

+ (instancetype)eventWithPort:(ORSSerialPort *)port syncData:(SyncData *)sessionData {
    return [[self alloc] initWithPort:port syncData:sessionData];
}

@end