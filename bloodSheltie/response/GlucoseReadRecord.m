#import "GlucoseReadRecord.h"


@implementation GlucoseReadRecord {

}
- (instancetype)initWithRawInternalTimeInSeconds:(uint32_t)rawInternalTimeInSeconds rawDisplayTimeInSeconds:(uint32_t)rawDisplayTimeInSeconds glucoseValue:(NSInteger)glucoseValue trendArrowAndNoise:(Byte)trendArrowAndNoise recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber dexcomOffsetWithStandardInSeconds:(int32_t)dexcomOffsetInSeconds timezone:(NSTimeZone *)userTimezone {
    self = [super initWithRawInternalTimeInSeconds:rawInternalTimeInSeconds rawDisplayTimeInSeconds:rawDisplayTimeInSeconds recordNumber:recordNumber pageNumber:pageNumber dexcomOffsetWithStandardInSeconds:dexcomOffsetInSeconds timezone:userTimezone];
    if (self) {
        _glucoseValue = glucoseValue;
        _trendArrowAndNoise = trendArrowAndNoise;
    }

    return self;
}

+ (instancetype)recordWithRawInternalTimeInSeconds:(uint32_t)rawInternalTimeInSeconds rawDisplayTimeInSeconds:(uint32_t)rawDisplayTimeInSeconds glucoseValue:(NSInteger)glucoseValue trendArrowAndNoise:(Byte)trendArrowAndNoise recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber dexcomOffsetWithStandardInSeconds:(int32_t)dexcomOffsetInSeconds timezone:(NSTimeZone *)userTimezone {
    return [[self alloc] initWithRawInternalTimeInSeconds:rawInternalTimeInSeconds rawDisplayTimeInSeconds:rawDisplayTimeInSeconds glucoseValue:glucoseValue trendArrowAndNoise:trendArrowAndNoise recordNumber:recordNumber pageNumber:pageNumber dexcomOffsetWithStandardInSeconds:dexcomOffsetInSeconds timezone:userTimezone];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%s glucoseValue=[%li] trendArrowAndNoise=[%d]",
                    [[super description] UTF8String], _glucoseValue, _trendArrowAndNoise];
}

@end