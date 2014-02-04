#import "MeterReadRecord.h"
#import "Types.h"


@implementation MeterReadRecord {

}
- (instancetype)initWithMeterRead:(uint16_t)meterRead internalSecondsSinceDexcomEpoch:(uint32_t)internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:(uint32_t)localSecondsSinceDexcomEpoch meterTimeInSecondsSinceDexcomEpoch:(uint32_t)meterTimeInSecondsSinceDexcomEpoch {
    self = [super init];
    if (self) {
        _meterRead = meterRead;
        _internalSecondsSinceDexcomEpoch = internalSecondsSinceDexcomEpoch;
        _localSecondsSinceDexcomEpoch = localSecondsSinceDexcomEpoch;
        _meterTimeInSecondsSinceDexcomEpoch = meterTimeInSecondsSinceDexcomEpoch;
    }

    return self;
}

+ (instancetype)recordWithMeterRead:(uint16_t)meterRead internalSecondsSinceDexcomEpoch:(uint32_t)internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:(uint32_t)localSecondsSinceDexcomEpoch meterTimeInSecondsSinceDexcomEpoch:(uint32_t)meterTimeInSecondsSinceDexcomEpoch {
    return [[self alloc] initWithMeterRead:meterRead internalSecondsSinceDexcomEpoch:internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:localSecondsSinceDexcomEpoch meterTimeInSecondsSinceDexcomEpoch:meterTimeInSecondsSinceDexcomEpoch];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[MeterReadRecord] internalTime=[%@] displayTime=[%@] meterRead=[%d] meterTime=[%@]",
                                      [Types dateTimeFromSecondsSinceDexcomEpoch:_internalSecondsSinceDexcomEpoch],
                                      [Types dateTimeFromSecondsSinceDexcomEpoch:_localSecondsSinceDexcomEpoch],
                                      _meterRead,
                                      [Types dateTimeFromSecondsSinceDexcomEpoch:_meterTimeInSecondsSinceDexcomEpoch]];

}


@end