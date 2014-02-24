#import <Foundation/Foundation.h>
#import "RecordSyncTag.h"
#import "SyncTag.h"
#import "SyncData.h"

@interface SyncUtils : NSObject
+ (RecordSyncTag *)generateRecordSyncTag:(NSArray *)records;
+ (NSArray *)sortRecords:(NSArray *)records;

+ (SyncTag *)generateNewSyncTag:(SyncData *)data;
@end