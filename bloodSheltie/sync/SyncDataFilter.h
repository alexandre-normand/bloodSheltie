#import <Foundation/Foundation.h>
#import "InternalSyncData.h"

@class SyncTag;

@interface SyncDataFilter : NSObject
+ (InternalSyncData *)sortAndFilterData:(InternalSyncData *)data withSyncTag:(SyncTag *)syncTag since:(NSDate *)since;
@end