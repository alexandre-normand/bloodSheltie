#import <Foundation/Foundation.h>
#import "ORSSerialPort.h"
#import "SyncEventObserver.h"
#import "SyncTag.h"

@interface SyncManager : NSObject {

@protected
    NSMutableArray *observers;
    NSDate *since;
}

- (void)start:(SyncTag *)syncTag;

- (SyncTag *)stop;

- (void)registerEventListener:(id <SyncEventObserver>)observer;
- (void)unregisterEventListener:(id <SyncEventObserver>)observer;
@end