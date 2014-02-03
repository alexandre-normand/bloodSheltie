#import <Foundation/Foundation.h>
#import "SessionEvent.h"

@protocol SessionObserver <NSObject>
-(void) syncStarted: (SessionEvent *) event;
-(void) errorReadingReceiver: (SessionEvent *) event;
-(void) syncProgress: (SessionEvent* ) event;
-(void) syncComplete: (SessionEvent* ) event;
@end