#import "DataPaginator.h"
#import "ReadDatabasePagesRequest.h"
#import "SyncTag.h"


Byte MAX_PAGES_PER_COMMAND = 4;

@implementation DataPaginator {

}
+ (NSArray *)getDatabasePagesRequestsForRecordType:(RecordType)recordType pageRange:(PageRange *)pageRange recordSyncTag:(RecordSyncTag *)recordSyncTag {
    NSLog(@"Building requests for record type [%s], page range [%@] and record sync tag [%@]", [[Types recordTypeIdentifier:recordType] UTF8String], pageRange, recordSyncTag);
    if (recordSyncTag != nil && ![recordSyncTag isInitialSync]) {
        pageRange = [PageRange rangeWithFirstPage:[recordSyncTag.pageNumber unsignedIntValue]
                                                lastPage:pageRange.lastPage
                                            ofRecordType:recordType];
    }

    return [self getDatabasePagesRequestsForRecordType:recordType pageRange:pageRange];
}

+ (NSArray *)getDatabasePagesRequestsForRecordType:(RecordType)recordType pageRange:(PageRange *)pageRange {
    NSMutableArray *requests = [[NSMutableArray alloc] init];

    if (pageRange.firstPage == NOT_AVAILABLE || pageRange.lastPage == NOT_AVAILABLE) {
        NSLog(@"Not generating any ReadDatabasePagesRequest for [%s] since page range [%@] has negative values, likely because no user events were recorded.",
                [[Types recordTypeIdentifier:recordType] UTF8String], pageRange);
    } else {
        for (int chunkStart = pageRange.firstPage; chunkStart <= pageRange.lastPage; chunkStart+= MAX_PAGES_PER_COMMAND) {
            Byte numberOfPagesForRequest = (Byte) MIN((pageRange.lastPage - chunkStart + 1), MAX_PAGES_PER_COMMAND);
            [requests addObject:[[ReadDatabasePagesRequest alloc] initWithRecordType:recordType pageNumber:chunkStart numberOfPages:numberOfPagesForRequest]];
        }
    }

    return requests;
}

@end