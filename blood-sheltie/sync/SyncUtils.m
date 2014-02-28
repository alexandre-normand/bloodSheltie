#import "SyncUtils.h"
#import "GenericRecord.h"


@implementation SyncUtils {

}

+ (RecordSyncTag *)generateRecordSyncTag:(NSArray *)records previousSyncTag:(RecordSyncTag *)previousSyncTag {
    // Make sure the records are sorted
    NSArray *sortedRecords = [self sortRecords:records];
    GenericRecord *mostRecentRecord = [sortedRecords lastObject];

    // If we have no content, we just keep the last sync tag
    // This can happen is the last connect/disconnect is very recent and we don't have new data.
    if (mostRecentRecord != nil) {
        return [RecordSyncTag tagWithRecordNumber:[NSNumber numberWithUnsignedInt:mostRecentRecord.recordNumber]
                                       pageNumber:[NSNumber numberWithUnsignedInt:mostRecentRecord.pageNumber]];
    } else {
        return previousSyncTag;
    }
}

+ (NSArray *)sortRecords:(NSArray *)records {
    NSSortDescriptor *sortAscendingByInternalTime;
    sortAscendingByInternalTime = [[NSSortDescriptor alloc] initWithKey:@"internalTime"
                                                              ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortAscendingByInternalTime];
    return [records sortedArrayUsingDescriptors:sortDescriptors];
}

+ (SyncTag *)generateNewSyncTag:(InternalSyncData *)data previousSyncTag:(SyncTag *)previousSyncTag {
    return [SyncTag tagWithSerialNumber:data.manufacturingParameters.serialNumber
                        lastGlucoseRead:[SyncUtils generateRecordSyncTag:data.glucoseReads previousSyncTag:previousSyncTag.lastGlucoseRead]
                          lastUserEvent:[SyncUtils generateRecordSyncTag:data.userEvents previousSyncTag:previousSyncTag.lastUserEvent]
                    lastCalibrationRead:[SyncUtils generateRecordSyncTag:data.calibrationReads previousSyncTag:previousSyncTag.lastCalibrationRead]];
}
@end