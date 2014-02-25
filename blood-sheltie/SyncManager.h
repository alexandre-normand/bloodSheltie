#import <Foundation/Foundation.h>
#import "ORSSerialPort.h"
#import "DeviceEventObserver.h"

@class SyncTag;

@interface SyncManager : NSObject {

@protected
    NSMutableArray *observers;
    NSDate *since;
}

+ (SyncManager *)instance;

- (void)start;

- (SyncTag *)stop;
@end