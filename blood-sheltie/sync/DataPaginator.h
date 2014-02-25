#import <Foundation/Foundation.h>
#import "Types.h"
#import "PageRange.h"

@class RecordSyncTag;

@interface DataPaginator : NSObject
+ (NSArray *)getDatabasePagesRequestsForRecordType:(RecordType)recordType pageRange:(PageRange *)pageRange recordSyncTag:(RecordSyncTag *)recordSyncTag;
+ (NSArray *)getDatabasePagesRequestsForRecordType:(RecordType)recordType pageRange:(PageRange *)pageRange;

@end