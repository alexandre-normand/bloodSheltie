#import <Foundation/Foundation.h>
#import "GenericRecord.h"


@interface GlucoseReadRecord : GenericRecord
@property(readonly) NSInteger glucoseValue;
@property(readonly) Byte trendArrowAndNoise;


- (instancetype)initWithRawInternalTimeInSeconds:(uint32_t)rawInternalTimeInSeconds rawDisplayTimeInSeconds:(uint32_t)rawDisplayTimeInSeconds glucoseValue:(NSInteger)glucoseValue trendArrowAndNoise:(Byte)trendArrowAndNoise recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber dexcomOffsetWithStandardInSeconds:(int32_t)dexcomOffsetInSeconds;

+ (instancetype)recordWithRawInternalTimeInSeconds:(uint32_t)internalSecondsSinceDexcomEpoch rawDisplayTimeInSeconds:(uint32_t)localSecondsSinceDexcomEpoch glucoseValue:(NSInteger)glucoseValue trendArrowAndNoise:(Byte)trendArrowAndNoise recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber dexcomOffsetWithStandardInSeconds:(int32_t)dexcomOffsetInSeconds;
@end