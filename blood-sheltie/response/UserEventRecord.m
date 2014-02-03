#import "UserEventRecord.h"
#import "Types.h"

@implementation UserEventRecord {

}
- (instancetype)initWithEventType:(UserEventType)eventType eventValue:(uint32_t)eventValue eventSecondsSinceDexcomEpoch:(uint32_t)eventSecondsSinceDexcomEpoch internalSecondsSinceDexcomEpoch:(uint32_t)internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:(uint32_t)localSecondsSinceDexcomEpoch {
    self = [super init];
    if (self) {
        _eventType = eventType;
        _eventValue=eventValue;
        _eventSecondsSinceDexcomEpoch=eventSecondsSinceDexcomEpoch;
        _internalSecondsSinceDexcomEpoch=internalSecondsSinceDexcomEpoch;
        _localSecondsSinceDexcomEpoch=localSecondsSinceDexcomEpoch;
    }

    return self;
}

+ (instancetype)recordWithEventType:(UserEventType)eventType eventValue:(uint32_t)eventValue eventSecondsSinceDexcomEpoch:(uint32_t)eventSecondsSinceDexcomEpoch internalSecondsSinceDexcomEpoch:(uint32_t)internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:(uint32_t)localSecondsSinceDexcomEpoch {
    return [[self alloc] initWithEventType:eventType eventValue:eventValue eventSecondsSinceDexcomEpoch:eventSecondsSinceDexcomEpoch internalSecondsSinceDexcomEpoch:internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:localSecondsSinceDexcomEpoch];
}

- (NSString *)description {
    return [NSString stringWithFormat: @"[UserEventRecord] internalTime=[%@] displayTime=[%@] userEventType=[%s] eventValue=[%d] eventTime=[%@]",
                    [Types dateTimeFromSecondsSinceDexcomEpoch: _internalSecondsSinceDexcomEpoch],
                    [Types dateTimeFromSecondsSinceDexcomEpoch:_localSecondsSinceDexcomEpoch],
                    [[Types userEventTypeIdentifier:_eventType] UTF8String],
                    _eventValue,
                    [Types dateTimeFromSecondsSinceDexcomEpoch:_eventSecondsSinceDexcomEpoch]];
}


@end