#import <Foundation/Foundation.h>
#import "SessionEvent.h"
#import "ReceiverEvent.h"

@protocol EventObserver <NSObject>
-(void) syncStarted: (SessionEvent *) event;
-(void) errorReadingReceiver: (SessionEvent *) event;
-(void) syncProgress: (SessionEvent* ) event;
-(void) syncComplete: (SessionEvent* ) event;
-(void) receiverPlugged: (ReceiverEvent *) event;
-(void) receiverUnplugged: (ReceiverEvent *) event;
@end