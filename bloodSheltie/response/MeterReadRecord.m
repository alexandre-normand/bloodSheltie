#import "MeterReadRecord.h"
#import "Types.h"


@implementation MeterReadRecord {

}
- (instancetype)initWithMeterRead:(uint16_t)meterRead rawInternalTimeInSeconds:(uint32_t)internalSecondsSinceDexcomEpoch rawDisplayTimeInSeconds:(uint32_t)rawDisplayTimeInSeconds rawMeterTimeInSeconds:(uint32_t)rawMeterTimeInSeconds recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber dexcomOffsetWithStandardInSeconds:(int32_t)dexcomOffsetWithStandardInSeconds timezone:(NSTimeZone *)userTimezone {
    self = [super initWithRawInternalTimeInSeconds:internalSecondsSinceDexcomEpoch rawDisplayTimeInSeconds:rawDisplayTimeInSeconds recordNumber:recordNumber pageNumber:pageNumber dexcomOffsetWithStandardInSeconds:dexcomOffsetWithStandardInSeconds timezone:userTimezone];
    if (self) {
        _meterRead = meterRead;
        _rawMeterTimeInSeconds = rawMeterTimeInSeconds;
        _meterTimeInSecondsSinceStandardEpoch = rawMeterTimeInSeconds - dexcomOffsetWithStandardInSeconds;
        uint32_t realEventTimeInSeconds = [Types getTimeInSecondsFromInternalTimeSinceStandardEpoch:[super internalSecondsSinceStandardEpoch] displayTimeSinceStandardEpoch:[super displayTimeSinceStandardEpoch] eventTimeSinceStandardEpoch:_meterTimeInSecondsSinceStandardEpoch];
        _meterTime = [NSDate dateWithTimeIntervalSince1970:realEventTimeInSeconds];
    }

    return self;
}

+ (instancetype)recordWithMeterRead:(uint16_t)meterRead rawInternalTimeInSeconds:(uint32_t)rawInternalTimeInSeconds rawDisplayTimeInSeconds:(uint32_t)rawDisplayTimeInSeconds rawMeterTimeInSeconds:(uint32_t)rawMeterTimeInSeconds recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber dexcomOffsetWithStandardInSeconds:(int32_t)dexcomOffsetWithStandardInSeconds timezone:(NSTimeZone *)userTimezone {
    return [[self alloc] initWithMeterRead:meterRead rawInternalTimeInSeconds:rawInternalTimeInSeconds rawDisplayTimeInSeconds:rawDisplayTimeInSeconds rawMeterTimeInSeconds:rawMeterTimeInSeconds recordNumber:recordNumber pageNumber:pageNumber dexcomOffsetWithStandardInSeconds:dexcomOffsetWithStandardInSeconds timezone:userTimezone];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%s meterRead=[%d] rawMeterTimeInSeconds=[%u] meterTimeInSecondsSinceEpoch=[%u] meterTime=[%@]",
                                      [[super description] UTF8String], _meterRead, _rawMeterTimeInSeconds, _meterTimeInSecondsSinceStandardEpoch, _meterTime];
}


@end