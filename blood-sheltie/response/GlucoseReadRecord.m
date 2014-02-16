#import "GlucoseReadRecord.h"
#import "Types.h"


@implementation GlucoseReadRecord {

}
- (instancetype)initWithInternalSecondsSinceDexcomEpoch:(uint32_t)internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:(uint32_t)localSecondsSinceDexcomEpoch glucoseValue:(uint16_t)glucoseValue trendArrowAndNoise:(Byte)trendArrowAndNoise recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber {
    self = [super init];
    if (self) {
        _internalSecondsSinceDexcomEpoch = internalSecondsSinceDexcomEpoch;
        _localSecondsSinceDexcomEpoch = localSecondsSinceDexcomEpoch;
        _internalTime = [Types dateTimeFromSecondsSinceDexcomEpoch:_internalSecondsSinceDexcomEpoch];
        _localTime = [Types dateTimeFromSecondsSinceDexcomEpoch:_localSecondsSinceDexcomEpoch];
        _glucoseValue = glucoseValue;
        _trendArrowAndNoise = trendArrowAndNoise;
        _recordNumber = recordNumber;
        _pageNumber = pageNumber;
    }

    return self;
}

+ (instancetype)recordWithInternalSecondsSinceDexcomEpoch:(uint32_t)internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:(uint32_t)localSecondsSinceDexcomEpoch glucoseValue:(uint16_t)glucoseValue trendArrowAndNoise:(Byte)trendArrowAndNoise recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber {
    return [[self alloc] initWithInternalSecondsSinceDexcomEpoch:internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:localSecondsSinceDexcomEpoch glucoseValue:glucoseValue trendArrowAndNoise:trendArrowAndNoise recordNumber:recordNumber pageNumber:pageNumber];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[GlucoseReadRecord] internalTime=[%@] displayTime=[%@] glucoseValue=[%d] trendArrowAndNoise=[%d] recordNumber=[%d] pageNumber=[%d]",
                                      _internalTime,
                                      _localTime,
                                      _glucoseValue,
                                      _trendArrowAndNoise,
                                      _recordNumber,
                                      _pageNumber];
}

@end