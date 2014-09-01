#import "UserEventRecord.h"

@implementation UserEventRecord {

}
- (instancetype)initWithEventType:(UserEventType)eventType subType:(Byte)subType eventValue:(uint32_t)eventValue rawEventTimeInSeconds:(uint32_t)rawEventTimeInSeconds rawInternalTimeInSeconds:(uint32_t)rawInternalTimeInSeconds rawDisplayTimeInSeconds:(uint32_t)rawDisplayTimeInSeconds recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber dexcomOffsetWithStandardInSeconds:(uint32_t)dexcomOffsetInSeconds {
    self = [super initWithRawInternalTimeInSeconds:rawInternalTimeInSeconds rawDisplayTimeInSeconds:rawDisplayTimeInSeconds recordNumber:recordNumber pageNumber:pageNumber dexcomOffsetWithStandardInSeconds:0];
    if (self) {
        _eventType = eventType;
        _eventValue = eventValue;
        _rawEventTimeInSeconds = rawEventTimeInSeconds;
        _eventTimeInSecondsSinceStandardEpoch = _rawEventTimeInSeconds - dexcomOffsetInSeconds;
        _eventTime = [NSDate dateWithTimeIntervalSince1970:_eventTimeInSecondsSinceStandardEpoch];
        _subType = subType;
        _subEventIdentifier = [Types subEventIdentifier:_eventType subEventType:subType];
    }

    return self;
}

+ (instancetype)recordWithEventType:(UserEventType)eventType subType:(Byte)subType eventValue:(uint32_t)eventValue rawEventTimeInSeconds:(uint32_t)rawEventTimeInSeconds rawInternalTimeInSeconds:(uint32_t)rawInternalTimeInSeconds rawDisplayTimeInSeconds:(uint32_t)rawDisplayTimeInSeconds recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber dexcomOffsetWithStandardInSeconds:(int)dexcomOffsetInSeconds {
    return [[self alloc] initWithEventType:eventType subType:subType eventValue:eventValue rawEventTimeInSeconds:rawEventTimeInSeconds rawInternalTimeInSeconds:rawInternalTimeInSeconds rawDisplayTimeInSeconds:rawDisplayTimeInSeconds recordNumber:recordNumber pageNumber:pageNumber dexcomOffsetWithStandardInSeconds:dexcomOffsetInSeconds];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%s userEventType=[%s] subType=[%s] eventValue=[%d] rawEventTimeInSeconds=[%u] eventTimeInSecondsSinceStandardEpoch=[%u] eventTime=[%@]",
                                      [[super description] UTF8String],
                                      [[Types userEventTypeIdentifier:_eventType] UTF8String],
                                      [_subEventIdentifier UTF8String],
                                      _eventValue,
                                      _rawEventTimeInSeconds,
                                      _eventTimeInSecondsSinceStandardEpoch,
                                      _eventTime];
}

@end