#import <Foundation/Foundation.h>
#import "Types.h"
#import "GenericRecord.h"


@interface UserEventRecord : GenericRecord
@property(readonly) UserEventType eventType;
@property(readonly) NSString *subEventIdentifier;
@property(readonly) uint32_t rawEventTimeInSeconds;
@property(readonly) uint32_t eventTimeInSecondsSinceStandardEpoch;
@property(readonly) NSDate *eventTime;
@property(readonly) uint32_t eventValue;
@property(readonly) Byte subType;

- (instancetype)initWithEventType:(UserEventType)eventType subType:(Byte)subType eventValue:(uint32_t)eventValue rawEventTimeInSeconds:(uint32_t)rawEventTimeInSeconds rawInternalTimeInSeconds:(uint32_t)rawInternalTimeInSeconds rawDisplayTimeInSeconds:(uint32_t)rawDisplayTimeInSeconds recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber dexcomOffsetWithStandardInSeconds:(int32_t)dexcomOffsetInSeconds timezone:(NSTimeZone *)userTimezone;

+ (instancetype)recordWithEventType:(UserEventType)eventType subType:(Byte)subType eventValue:(uint32_t)eventValue rawEventTimeInSeconds:(uint32_t)rawEventTimeInSeconds rawInternalTimeInSeconds:(uint32_t)rawInternalTimeInSeconds rawDisplayTimeInSeconds:(uint32_t)rawDisplayTimeInSeconds recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber dexcomOffsetWithStandardInSeconds:(int)dexcomOffsetInSeconds timezone:(NSTimeZone *)userTimeZone;

@end