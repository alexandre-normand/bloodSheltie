#import "DataPaginator.h"
#import "ReadDatabasePagesRequest.h"
#import "SyncTag.h"
#import "RecordSyncTag.h"


Byte MAX_PAGES_PER_COMMAND = 4;

@implementation DataPaginator {

}
+ (NSArray *)getDatabasePagesRequestsForRecordType:(RecordType)recordType pageRange:(PageRange *)pageRange recordSyncTag:(RecordSyncTag *)recordSyncTag {
    if (![recordSyncTag isInitialSync]) {
        pageRange = [PageRange rangeWithFirstPage:[recordSyncTag.pageNumber unsignedIntValue]
                                                lastPage:pageRange.lastPage
                                            ofRecordType:recordType];
    }

    return [self getDatabasePagesRequestsForRecordType:recordType pageRange:pageRange];
}

+ (NSArray *)getDatabasePagesRequestsForRecordType:(RecordType)recordType pageRange:(PageRange *)pageRange {
    NSMutableArray *requests = [[NSMutableArray alloc] init];

    for (int chunkStart = pageRange.firstPage; chunkStart <= pageRange.lastPage; chunkStart+= MAX_PAGES_PER_COMMAND) {
        Byte numberOfPagesForRequest = (Byte) MIN((pageRange.lastPage - chunkStart + 1), MAX_PAGES_PER_COMMAND);
        [requests addObject:[[ReadDatabasePagesRequest alloc] initWithRecordType:recordType pageNumber:chunkStart numberOfPages:numberOfPagesForRequest]];
    }

    return requests;
}

@end