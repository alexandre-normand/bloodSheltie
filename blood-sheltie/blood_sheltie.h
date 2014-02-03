#import <Foundation/Foundation.h>
#import "DeviceObserver.h"

@interface BloodSheltie : NSObject {
@protected
    NSMutableArray *observers;
}

-(void) listen;
-(void) registerEventListener:(id<DeviceObserver>) observer;
@end
