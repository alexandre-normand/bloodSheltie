#import "SyncEvent.h"
#import "SyncData.h"
#import "ORSSerialPort.h"


@implementation SyncEvent {

}
- (instancetype)initWithPort:(ORSSerialPort *)port sessionData:(SyncData *)sessionData {
    self = [super init];
    if (self) {
        _port = port;
        _sessionData=sessionData;
    }

    return self;
}

+ (instancetype)eventWithPort:(ORSSerialPort *)port sessionData:(SyncData *)sessionData {
    return [[self alloc] initWithPort:port sessionData:sessionData];
}

@end