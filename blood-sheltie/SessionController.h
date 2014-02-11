#import <Foundation/Foundation.h>
#import "ORSSerialPort.h"
#import "DeviceObserver.h"

@interface SessionController : NSObject {
@protected
    NSMutableArray *observers;
}

- (void)start;
@end