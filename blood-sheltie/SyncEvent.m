#import "SyncEvent.h"
#import "SyncData.h"
#import "ORSSerialPort.h"


@implementation SyncEvent {

}
- (instancetype)initWithDevicePath:(NSString *)devicePath sessionData:(SyncData *)sessionData {
    self = [super init];
    if (self) {
        _port = devicePath;
        _sessionData=sessionData;
    }

    return self;
}

+ (instancetype)eventWithPort:(ORSSerialPort *)port sessionData:(SyncData *)sessionData {
    return [[self alloc] initWithDevicePath:port sessionData:sessionData];
}

@end