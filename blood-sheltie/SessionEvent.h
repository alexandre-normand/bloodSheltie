#import <Foundation/Foundation.h>

@class SessionData;


@interface SessionEvent : NSObject
@property(readonly) NSString *devicePath;
@property(readonly) SessionData *sessionData;

- (instancetype)initWithDevicePath:(NSString *)devicePath sessionData:(SessionData *)sessionData;

+ (instancetype)eventWithDevicePath:(NSString *)devicePath sessionData:(SessionData *)sessionData;

@end