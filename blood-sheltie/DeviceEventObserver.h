#import <Foundation/Foundation.h>
#import "ReceiverEvent.h"

@protocol DeviceEventObserver <NSObject>
-(void) receiverPlugged: (ReceiverEvent *) event;
-(void) receiverUnplugged: (ReceiverEvent *) event;
@end
