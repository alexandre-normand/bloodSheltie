#import <Foundation/Foundation.h>
#import "SyncEvent.h"
#import "ReceiverEvent.h"

@protocol SyncEventObserver <NSObject>
-(void) syncStarted: (SyncEvent *) event;
-(void) errorReadingReceiver: (SyncEvent *) event;
-(void) syncProgress: (SyncEvent * ) event;
-(void) syncComplete: (SyncEvent * ) event;
-(void) receiverPlugged: (ReceiverEvent *) event;
-(void) receiverUnplugged: (ReceiverEvent *) event;
@end