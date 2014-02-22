#import "SyncDataFilter.h"
#import "MeterReadRecord.h"
#import "Types.h"


@implementation SyncDataFilter {

}
+ (SyncData *)filterData:(SyncData *)data since:(NSDate *)since {
    if (since == nil) {
        since = [Types dexcomEpoch];
    }

    SyncData *filteredData = [[SyncData alloc] init];

    for (id record in data.calibrationReads) {
        if ([[record internalTime] compare:since] == NSOrderedDescending) {
            [filteredData.calibrationReads addObject:record];
        }
    }

    for (id record in data.userEvents) {
        if ([[record internalTime] compare:since] == NSOrderedDescending) {
            [filteredData.userEvents addObject:record];
        }
    }

    for (id record in data.glucoseReads) {
        if ([[record internalTime] compare:since] == NSOrderedDescending) {
            [filteredData.glucoseReads addObject:record];
        }
    }

    return filteredData;
}

@end