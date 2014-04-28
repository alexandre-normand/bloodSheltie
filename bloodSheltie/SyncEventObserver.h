#import <Foundation/Foundation.h>
#import "SyncEvent.h"
#import "SyncCompletionEvent.h"
#import "SyncProgressEvent.h"
#import "ReceiverEvent.h"

@protocol SyncEventObserver <NSObject>
-(void) syncStarted: (SyncEvent *) event;
-(void) errorReadingReceiver: (SyncEvent *) event;
-(void) syncProgress: (SyncProgressEvent *) event;
-(void) syncComplete: (SyncCompletionEvent *) event;
-(void) receiverPlugged: (ReceiverEvent *) event;
-(void) receiverUnplugged: (ReceiverEvent *) event;
@end