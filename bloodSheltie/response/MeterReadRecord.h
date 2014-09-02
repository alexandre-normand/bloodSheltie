#import <Foundation/Foundation.h>
#import "GenericRecord.h"


@interface MeterReadRecord : GenericRecord
@property(readonly) uint16_t meterRead;
@property(readonly) uint32_t rawMeterTimeInSeconds;
@property(readonly) uint32_t meterTimeInSecondsSinceStandardEpoch;
@property(readonly) NSDate *meterTime;

- (instancetype)initWithMeterRead:(uint16_t)meterRead rawInternalTimeInSeconds:(uint32_t)internalSecondsSinceDexcomEpoch rawDisplayTimeInSeconds:(uint32_t)rawDisplayTimeInSeconds rawMeterTimeInSeconds:(uint32_t)rawMeterTimeInSeconds recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber dexcomOffsetWithStandardInSeconds:(int32_t)dexcomOffsetWithStandardInSeconds timezone:(NSTimeZone *)userTimezone;

+ (instancetype)recordWithMeterRead:(uint16_t)meterRead rawInternalTimeInSeconds:(uint32_t)rawInternalTimeInSeconds rawDisplayTimeInSeconds:(uint32_t)rawDisplayTimeInSeconds rawMeterTimeInSeconds:(uint32_t)rawMeterTimeInSeconds recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber dexcomOffsetWithStandardInSeconds:(int32_t)dexcomOffsetWithStandardInSeconds timezone:(NSTimeZone *)userTimezone;


@end