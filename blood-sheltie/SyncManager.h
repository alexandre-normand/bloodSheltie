#import <Foundation/Foundation.h>
#import "ORSSerialPort.h"
#import "DeviceObserver.h"

@interface SyncManager : NSObject {
@protected
    NSMutableArray *observers;
}

- (void)start;
@end