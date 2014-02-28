#import "SyncDataAdapter.h"


@implementation SyncDataAdapter {

}
+ (SyncData *)convertSyncData:(InternalSyncData *)internalSyncData {
    NSArray *glucoseReads = [self convertGlucoseReads:[internalSyncData glucoseReads]];

    return [SyncData dataWithGlucoseReads:glucoseReads
                         calibrationReads:nil
                        insulinInjections:nil
                           exerciseEvents:nil
                             healthEvents:nil
                              carbIntakes:nil
                  manufacturingParameters:internalSyncData.manufacturingParameters];
}

+ (NSArray *)convertGlucoseReads:(NSArray *)internalReads {
    NSMutableArray *converted = [NSMutableArray arrayWithCapacity:[internalReads count]];
    for (id read in internalReads) {

    }
    return converted;
}

@end