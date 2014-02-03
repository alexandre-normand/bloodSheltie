#import "GlucoseReadRecord.h"
#import "Types.h"


@implementation GlucoseReadRecord {

}
- (instancetype)initWithInternalSecondsSinceDexcomEpoch:(uint32_t)internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:(uint32_t)localSecondsSinceDexcomEpoch glucoseValueWithFlags:(uint16_t)glucoseValueWithFlags trendArrowAndNoise:(Byte)trendArrowAndNoise recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber {
    self = [super init];
    if (self) {
        _internalSecondsSinceDexcomEpoch = internalSecondsSinceDexcomEpoch;
        _localSecondsSinceDexcomEpoch=localSecondsSinceDexcomEpoch;
        _glucoseValueWithFlags=glucoseValueWithFlags;
        _trendArrowAndNoise=trendArrowAndNoise;
        _recordNumber=recordNumber;
        _pageNumber=pageNumber;
    }

    return self;
}

+ (instancetype)recordWithInternalSecondsSinceDexcomEpoch:(uint32_t)internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:(uint32_t)localSecondsSinceDexcomEpoch glucoseValueWithFlags:(uint16_t)glucoseValueWithFlags trendArrowAndNoise:(Byte)trendArrowAndNoise recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber {
    return [[self alloc] initWithInternalSecondsSinceDexcomEpoch:internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:localSecondsSinceDexcomEpoch glucoseValueWithFlags:glucoseValueWithFlags trendArrowAndNoise:trendArrowAndNoise recordNumber:recordNumber pageNumber:pageNumber];
}

- (NSString *)description {
    return [NSString stringWithFormat: @"[GlucoseReadRecord] internalTime=[%@] displayTime=[%@] glucoseValueWithFlags=[%d] trendArrowAndNoise=[%d] recordNumber=[%d] pageNumber=[%d]",
                    [Types dateTimeFromSecondsSinceDexcomEpoch: _internalSecondsSinceDexcomEpoch],
                    [Types dateTimeFromSecondsSinceDexcomEpoch: _localSecondsSinceDexcomEpoch],
                    _glucoseValueWithFlags,
                    _trendArrowAndNoise,
                    _recordNumber,
                    _pageNumber];
}

@end