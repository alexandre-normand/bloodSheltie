#import "MeterReadRecord.h"
#import "Types.h"


@implementation MeterReadRecord {

}
- (instancetype)initWithMeterRead:(uint16_t)meterRead rawInternalTimeInSeconds:(uint32_t)internalSecondsSinceDexcomEpoch rawDisplayTimeInSeconds:(uint32_t)rawDisplayTimeInSeconds rawMeterTimeInSeconds:(uint32_t)rawMeterTimeInSeconds recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber dexcomOffsetWithStandardInSeconds:(uint32_t)dexcomOffsetWithStandardInSeconds {
    self = [super initWithRawInternalTimeInSeconds:internalSecondsSinceDexcomEpoch rawDisplayTimeInSeconds:rawDisplayTimeInSeconds recordNumber:recordNumber pageNumber:pageNumber dexcomOffsetWithStandardInSeconds:0];
    if (self) {
        _meterRead = meterRead;
        _rawMeterTimeInSeconds = rawMeterTimeInSeconds;
        _meterTimeInSecondsSinceStandardEpoch = rawMeterTimeInSeconds - dexcomOffsetWithStandardInSeconds;
        _meterTime = [NSDate dateWithTimeIntervalSince1970:_meterTimeInSecondsSinceStandardEpoch];
    }

    return self;
}

+ (instancetype)recordWithMeterRead:(uint16_t)meterRead rawInternalTimeInSeconds:(uint32_t)rawInternalTimeInSeconds rawDisplayTimeInSeconds:(uint32_t)rawDisplayTimeInSeconds rawMeterTimeInSeconds:(uint32_t)rawMeterTimeInSeconds recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber dexcomOffsetWithStandardInSeconds:(int)dexcomOffsetWithStandardInSeconds {
    return [[self alloc] initWithMeterRead:meterRead rawInternalTimeInSeconds:rawInternalTimeInSeconds rawDisplayTimeInSeconds:rawDisplayTimeInSeconds rawMeterTimeInSeconds:rawMeterTimeInSeconds recordNumber:recordNumber pageNumber:pageNumber dexcomOffsetWithStandardInSeconds:dexcomOffsetWithStandardInSeconds];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%s meterRead=[%d] meterTimeInSecondsSinceEpoch=[%u]",
                                      [[super description] UTF8String], _meterRead, _rawMeterTimeInSeconds];
}


@end