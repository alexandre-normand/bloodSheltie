#import <Foundation/Foundation.h>


@interface GenericRecord : NSObject
@property(readonly) uint32_t rawInternalTimeInSeconds;
@property(readonly) uint32_t internalSecondsSinceStandardEpoch;
@property(readonly) NSDate *internalTime;
@property(readonly) uint32_t rawDisplayTimeInSeconds;
@property(readonly) uint32_t displayTimeSinceStandardEpoch;
@property(readonly) NSDate *displayTime;
@property(readonly) uint32_t recordNumber;
@property(readonly) uint32_t pageNumber;
@property(readonly) NSTimeZone *timezone;

- (instancetype)initWithRawInternalTimeInSeconds:(uint32_t)rawInternalTimeInSeconds rawDisplayTimeInSeconds:(uint32_t)rawDiplayTimeInSeconds recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber dexcomOffsetWithStandardInSeconds:(int32_t)dexcomOffsetInSeconds;


+ (instancetype)recordWithRawInternalTimeInSeconds:(uint32_t)rawInternalTimeInSeconds rawDisplayTimeInSeconds:(uint32_t)rawDiplayTimeInSeconds recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber dexcomOffsetWithStandardInSeconds:(int32_t)dexcomOffsetInSeconds;
@end