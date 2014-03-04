#import <Foundation/Foundation.h>
#import "RecordSyncTag.h"
#import "SyncTag.h"
#import "InternalSyncData.h"

@interface SyncUtils : NSObject
+ (RecordSyncTag *)generateRecordSyncTag:(NSArray *)records previousSyncTag:(RecordSyncTag *)previousSyncTag;
+ (NSArray *)sortRecords:(NSArray *)records;

+ (SyncTag *)generateNewSyncTag:(InternalSyncData *)data previousSyncTag:(SyncTag *)previousSyncTag;
@end