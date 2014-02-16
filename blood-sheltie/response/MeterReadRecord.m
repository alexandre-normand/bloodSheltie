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
        _meterTime = [Types dateTimeFromSecondsSinceDexcomEpoch:_meterTimeInSecondsSinceDexcomEpoch];
        _internalTime = [Types dateTimeFromSecondsSinceDexcomEpoch:_internalSecondsSinceDexcomEpoch];
        _localTime = [Types dateTimeFromSecondsSinceDexcomEpoch:_localSecondsSinceDexcomEpoch];
    }

    return self;
}

+ (instancetype)recordWithMeterRead:(uint16_t)meterRead internalSecondsSinceDexcomEpoch:(uint32_t)internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:(uint32_t)localSecondsSinceDexcomEpoch meterTimeInSecondsSinceDexcomEpoch:(uint32_t)meterTimeInSecondsSinceDexcomEpoch {
    return [[self alloc] initWithMeterRead:meterRead internalSecondsSinceDexcomEpoch:internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:localSecondsSinceDexcomEpoch meterTimeInSecondsSinceDexcomEpoch:meterTimeInSecondsSinceDexcomEpoch];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[MeterReadRecord] internalTime=[%@] displayTime=[%@] meterRead=[%d] meterTime=[%@]",
                                      _internalTime,
                                      _localTime,
                                      _meterRead,
                                      _meterTime];

}


@end