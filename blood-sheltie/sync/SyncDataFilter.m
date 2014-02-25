#import "SyncDataFilter.h"
#import "MeterReadRecord.h"
#import "Types.h"
#import "SyncTag.h"


@implementation SyncDataFilter {

}
+ (SyncData *)filterData:(SyncData *)data withSyncTag:(SyncTag *)syncTag since:(NSDate *)since {
    if (since == nil) {
        since = [Types dexcomEpoch];
    }

    SyncData *filteredData = [[SyncData alloc] init];

    for (id record in data.calibrationReads) {
        if ([self filterRecord:record since:since recordSyncTag:syncTag.lastCalibrationRead]) {
            [filteredData.calibrationReads addObject:record];
        }
    }

    for (id record in data.userEvents) {
        if ([self filterRecord:record since:since recordSyncTag:syncTag.lastUserEvent]) {
            [filteredData.userEvents addObject:record];
        }
    }

    for (id record in data.glucoseReads) {
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