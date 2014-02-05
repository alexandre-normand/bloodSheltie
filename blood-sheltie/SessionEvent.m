#import "SessionEvent.h"
#import "SessionData.h"


@implementation SessionEvent {

}
- (instancetype)initWithDevicePath:(NSString *)devicePath sessionData:(SessionData *)sessionData {
    self = [super init];
    if (self) {
        _devicePath = devicePath;
        _sessionData=sessionData;
    }

    return self;
}

+ (instancetype)eventWithDevicePath:(NSString *)devicePath sessionData:(SessionData *)sessionData {
    return [[self alloc] initWithDevicePath:devicePath sessionData:sessionData];
}

@end