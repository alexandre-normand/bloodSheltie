#import <Foundation/Foundation.h>
#import "SyncEvent.h"


@interface SyncCompletionEvent : SyncEvent
@property(readonly) SyncData *sessionData;
@end