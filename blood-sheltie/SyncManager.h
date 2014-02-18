#import <Foundation/Foundation.h>
#import "ORSSerialPort.h"
#import "DeviceEventObserver.h"

@interface SyncManager : NSObject {
@protected
    NSMutableArray *observers;
}
+ (SyncManager *)instance;


- (void)start;
@end