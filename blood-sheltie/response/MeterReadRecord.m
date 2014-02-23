#import "MeterReadRecord.h"
#import "Types.h"


@implementation MeterReadRecord {

}
- (instancetype)initWithMeterRead:(uint16_t)meterRead internalSecondsSinceDexcomEpoch:(uint32_t)internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:(uint32_t)localSecondsSinceDexcomEpoch meterTimeInSecondsSinceDexcomEpoch:(uint32_t)meterTimeInSecondsSinceDexcomEpoch recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber {
    self = [super initWithInternalSecondsSinceDexcomEpoch:internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:localSecondsSinceDexcomEpoch recordNumber:recordNumber pageNumber:pageNumber];
    if (self) {
        _meterRead = meterRead;
        _meterTimeInSecondsSinceDexcomEpoch = meterTimeInSecondsSinceDexcomEpoch;
        _meterTime = [Types dateTimeFromSecondsSinceDexcomEpoch:_meterTimeInSecondsSinceDexcomEpoch];
    }

    return self;
}

+ (instancetype)recordWithMeterRead:(uint16_t)meterRead internalSecondsSinceDexcomEpoch:(uint32_t)internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:(uint32_t)localSecondsSinceDexcomEpoch meterTimeInSecondsSinceDexcomEpoch:(uint32_t)meterTimeInSecondsSinceDexcomEpoch recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber {
    return [[self alloc] initWithMeterRead:meterRead internalSecondsSinceDexcomEpoch:internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:localSecondsSinceDexcomEpoch meterTimeInSecondsSinceDexcomEpoch:meterTimeInSecondsSinceDexcomEpoch recordNumber:recordNumber pageNumber:pageNumber];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%s meterRead=[%d] meterTime=[%@]",
                                      [[super description] UTF8String], _meterRead, _meterTime];
}


@end