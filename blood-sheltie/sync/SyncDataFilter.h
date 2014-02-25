#import <Foundation/Foundation.h>
#import "SyncData.h"

@class SyncTag;

@interface SyncDataFilter : NSObject
+ (SyncData *)filterData:(SyncData *)data withSyncTag:(SyncTag *)syncTag since:(NSDate *)since;
@end