#import "SyncUtils.h"
#import "GenericRecord.h"


@implementation SyncUtils {

}

+ (RecordSyncTag *)generateRecordSyncTag:(NSArray *)records {
    // Make sure the records are sorted
    NSArray *sortedRecords = [self sortRecords:records];
    GenericRecord *mostRecentRecord = [sortedRecords lastObject];
    return [RecordSyncTag tagWithRecordNumber:[NSNumber numberWithUnsignedInt:mostRecentRecord.recordNumber]
                                   pageNumber:[NSNumber numberWithUnsignedInt:mostRecentRecord.pageNumber]];
}

+ (NSArray *)sortRecords:(NSArray *)records {
    NSSortDescriptor *sortAscendingByInternalTime;
    sortAscendingByInternalTime = [[NSSortDescriptor alloc] initWithKey:@"internalTime"
                                                              ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortAscendingByInternalTime];
    return [records sortedArrayUsingDescriptors:sortDescriptors];
}

+ (SyncTag *)generateNewSyncTag:(SyncData *)data {
    return [SyncTag tagWithSerialNumber:data.manufacturingParameters.serialNumber
                        lastGlucoseRead:[SyncUtils generateRecordSyncTag:data.glucoseReads]
                          lastUserEvent:[SyncUtils generateRecordSyncTag:data.userEvents]
                    lastCalibrationRead:[SyncUtils generateRecordSyncTag:data.calibrationReads]];
}
@end