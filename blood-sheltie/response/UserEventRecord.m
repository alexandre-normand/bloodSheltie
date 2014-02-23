#import "UserEventRecord.h"

@implementation UserEventRecord {

}
- (instancetype)initWithEventType:(UserEventType)eventType eventValue:(uint32_t)eventValue eventSecondsSinceDexcomEpoch:(uint32_t)eventSecondsSinceDexcomEpoch internalSecondsSinceDexcomEpoch:(uint32_t)internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:(uint32_t)localSecondsSinceDexcomEpoch recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber {
    self = [super initWithInternalSecondsSinceDexcomEpoch:internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:localSecondsSinceDexcomEpoch recordNumber:recordNumber pageNumber:pageNumber];
    if (self) {
        _eventType = eventType;
        _eventValue = eventValue;
        _eventSecondsSinceDexcomEpoch = eventSecondsSinceDexcomEpoch;
        _eventTime = [Types dateTimeFromSecondsSinceDexcomEpoch:_eventSecondsSinceDexcomEpoch];
    }

    return self;
}

+ (instancetype)recordWithEventType:(UserEventType)eventType eventValue:(uint32_t)eventValue eventSecondsSinceDexcomEpoch:(uint32_t)eventSecondsSinceDexcomEpoch internalSecondsSinceDexcomEpoch:(uint32_t)internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:(uint32_t)localSecondsSinceDexcomEpoch recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber {
    return [[self alloc] initWithEventType:eventType eventValue:eventValue eventSecondsSinceDexcomEpoch:eventSecondsSinceDexcomEpoch internalSecondsSinceDexcomEpoch:internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:localSecondsSinceDexcomEpoch recordNumber:recordNumber pageNumber:pageNumber];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%s userEventType=[%s] eventValue=[%d] eventTime=[%@]",
                                      [[super description] UTF8String], [[Types userEventTypeIdentifier:_eventType] UTF8String],
                                      _eventValue,
                                      _eventTime];
}

@end