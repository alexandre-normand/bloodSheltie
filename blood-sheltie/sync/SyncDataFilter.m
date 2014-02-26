#import "SyncDataFilter.h"
#import "MeterReadRecord.h"
#import "Types.h"
#import "SyncTag.h"
#import "SyncUtils.h"


@implementation SyncDataFilter {

}
+ (SyncData *)sortAndFilterData:(SyncData *)data withSyncTag:(SyncTag *)syncTag since:(NSDate *)since {
    if (since == nil) {
        since = [Types dexcomEpoch];
    }

    SyncData *filteredData = [[SyncData alloc] init];
    NSMutableArray *calibrationReads = [NSMutableArray arrayWithArray:[SyncUtils sortRecords:data.calibrationReads]];
    NSMutableArray *glucoseReads = [NSMutableArray arrayWithArray:[SyncUtils sortRecords:data.glucoseReads]];
    NSMutableArray *userEvents = [NSMutableArray arrayWithArray:[SyncUtils sortRecords:data.userEvents]];

    for (id record in calibrationReads) {
        if ([self filterRecord:record since:since recordSyncTag:syncTag.lastCalibrationRead]) {
            [filteredData.calibrationReads addObject:record];
        }
    }

    for (id record in userEvents) {
        if ([self filterRecord:record since:since recordSyncTag:syncTag.lastUserEvent]) {
            [filteredData.userEvents addObject:record];
        }
    }

    for (id record in glucoseReads) {
        if ([self filterRecord:record since:since recordSyncTag:syncTag.lastGlucoseRead]) {
            [filteredData.glucoseReads addObject:record];
        }
    }

    return filteredData;
}

+ (BOOL)filterRecord:(GenericRecord *)record since:(NSDate *)since recordSyncTag:(RecordSyncTag *)recordSyncTag {
    if ([[record internalTime] compare:since] != NSOrderedDescending) {
        return false;
    } else if (![recordSyncTag isInitialSync] && [record recordNumber] <= [recordSyncTag.recordNumber unsignedIntValue]) {
        return false;
    }
    return true;
}

@end