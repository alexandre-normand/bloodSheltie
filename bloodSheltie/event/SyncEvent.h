#import <Foundation/Foundation.h>
#import <ORSSerialPort/ORSSerialPort.h>
#import "SyncData.h"

@interface SyncEvent : NSObject
@property(readonly) ORSSerialPort *port;
@property(readonly) SyncData *syncData;

- (instancetype)initWithPort:(ORSSerialPort *)port syncData:(SyncData *)syncData;

+ (instancetype)eventWithPort:(ORSSerialPort *)port syncData:(SyncData *)sessionData;

@end