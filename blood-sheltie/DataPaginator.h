#import <Foundation/Foundation.h>
#import "Types.h"
#import "PageRange.h"

@interface DataPaginator : NSObject
+ (NSArray *)getDatabasePagesRequestsForRecordType:(RecordType)recordType andPageRange:(PageRange *)pageRange;
@end