#import <Foundation/Foundation.h>
#import "ORSSerialPort.h"
#import "DeviceObserver.h"

@interface SessionController : NSObject <DeviceObserver> {
@protected
    NSMutableArray *observers;
}

- (void)start;
@end