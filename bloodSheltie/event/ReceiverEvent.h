#import <Foundation/Foundation.h>
#import <ORSSerialPort/ORSSerialPort.h>

@interface ReceiverEvent : NSObject
@property ORSSerialPort *port;

- (instancetype)initWithPort:(ORSSerialPort *)port;

+ (instancetype)eventWithPort:(ORSSerialPort *)port;


@end
