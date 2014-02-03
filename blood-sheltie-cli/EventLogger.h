#import <Foundation/Foundation.h>
#import "DeviceObserver.h"

@protocol ORSSerialPortDelegate;

@interface EventLogger : NSObject<DeviceObserver>
@property(readonly) NSObject<ORSSerialPortDelegate> *sessionController;

- (instancetype)initWithSessionController:(NSObject <ORSSerialPortDelegate> *)sessionController;

+ (instancetype)loggerWithDelegate:(NSObject <ORSSerialPortDelegate> *)delegate;

@end
