#import <Foundation/Foundation.h>
#import "ORSSerialPort.h"
#import "SessionObserver.h"

@protocol DeviceObserver;
@class SessionData;


@interface FreshDataFetcher : NSObject<ORSSerialPortDelegate>
@property(readonly) NSDate *since;
@property(readonly) NSMutableArray *observers;
@property(readonly) NSString *serialPortPath;
@property(readonly) SessionData *sessionData;

- (instancetype)initWithSerialPortPath:(NSString *)serialPortPath since:(NSDate *)since;

+ (instancetype)fetcherWithSerialPortPath:(NSString *)serialPortPath since:(NSDate *)since;

-(void) registerObserver:(id<SessionObserver>) observer;

-(void) unregisterObserver:(id<SessionObserver>) observer;

-(void) run;

@end