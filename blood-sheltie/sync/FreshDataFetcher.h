#import <Foundation/Foundation.h>
#import "ORSSerialPort.h"
#import "SyncEventObserver.h"
#import "SyncData.h"

@protocol DeviceEventObserver;


@interface FreshDataFetcher : NSObject<ORSSerialPortDelegate>
@property(readonly) NSDate *since;
@property(readonly) NSMutableArray *observers;
@property(readonly) NSString *serialPortPath;
@property(readonly) SyncData *sessionData;

- (instancetype)initWithSerialPortPath:(NSString *)serialPortPath since:(NSDate *)since;

+ (instancetype)fetcherWithSerialPortPath:(NSString *)serialPortPath since:(NSDate *)since;

-(void) registerObserver:(id<SyncEventObserver>) observer;

-(void) unregisterObserver:(id<SyncEventObserver>) observer;

-(void) run;

@end