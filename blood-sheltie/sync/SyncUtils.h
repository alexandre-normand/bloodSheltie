#import <Foundation/Foundation.h>
#import "RecordSyncTag.h"
#import "SyncTag.h"
#import "SyncData.h"

@interface SyncUtils : NSObject
+ (RecordSyncTag *)generateRecordSyncTag:(NSArray *)records previousSyncTag:(RecordSyncTag *)previousSyncTag;
+ (NSArray *)sortRecords:(NSArray *)records;

+ (SyncTag *)generateNewSyncTag:(SyncData *)data previousSyncTag:(SyncTag *)previousSyncTag;
@end