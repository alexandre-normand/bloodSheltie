#import <Foundation/Foundation.h>
#import "ReceiverEvent.h"

@protocol DeviceObserver <NSObject>
-(void) receiverPlugged: (ReceiverEvent *) event;
-(void) receiverUnplugged: (ReceiverEvent *) event;
@end
