#import "GlucoseReadRecord.h"


@implementation GlucoseReadRecord {

}
- (instancetype)initWithInternalSecondsSinceDexcomEpoch:(uint32_t)internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:(uint32_t)localSecondsSinceDexcomEpoch glucoseValue:(uint16_t)glucoseValue trendArrowAndNoise:(Byte)trendArrowAndNoise recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber {
    self = [super initWithInternalSecondsSinceDexcomEpoch:internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:localSecondsSinceDexcomEpoch recordNumber:recordNumber pageNumber:pageNumber];
    if (self) {
        _glucoseValue = glucoseValue;
        _trendArrowAndNoise = trendArrowAndNoise;
    }

    return self;
}

+ (instancetype)recordWithInternalSecondsSinceDexcomEpoch:(uint32_t)internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:(uint32_t)localSecondsSinceDexcomEpoch glucoseValue:(uint16_t)glucoseValue trendArrowAndNoise:(Byte)trendArrowAndNoise recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber {
    return [[self alloc] initWithInternalSecondsSinceDexcomEpoch:internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:localSecondsSinceDexcomEpoch glucoseValue:glucoseValue trendArrowAndNoise:trendArrowAndNoise recordNumber:recordNumber pageNumber:pageNumber];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%s glucoseValue=[%d] trendArrowAndNoise=[%d]",
                    [[super description] UTF8String], _glucoseValue, _trendArrowAndNoise];
}

@end