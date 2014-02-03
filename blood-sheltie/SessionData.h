#import <Foundation/Foundation.h>


@interface SessionData : NSObject
@property(readonly) NSMutableArray *glucoseReads;
@property(readonly) NSMutableArray *calibrationReads;
@property(readonly) NSMutableArray *userEvents;
@end