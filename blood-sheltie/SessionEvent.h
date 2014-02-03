#import <Foundation/Foundation.h>

@class SessionData;


@interface SessionEvent : NSObject
@property(readonly) NSString *devicePath;
@property(readonly) SessionData *sessionData;
@end