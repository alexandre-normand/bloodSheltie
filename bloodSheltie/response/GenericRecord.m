#import "GenericRecord.h"
#import "Types.h"


@implementation GenericRecord {

}
- (instancetype)initWithInternalSecondsSinceDexcomEpoch:(uint32_t)internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:(uint32_t)localSecondsSinceDexcomEpoch recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber {
    self = [super init];
    if (self) {
        _internalSecondsSinceDexcomEpoch = internalSecondsSinceDexcomEpoch;
        _localSecondsSinceDexcomEpoch=localSecondsSinceDexcomEpoch;
        _recordNumber=recordNumber;
        _pageNumber=pageNumber;
        _internalTime = [Types dateTimeFromSecondsSinceDexcomEpoch:_internalSecondsSinceDexcomEpoch];
        _localTime = [Types dateTimeFromSecondsSinceDexcomEpoch:_localSecondsSinceDexcomEpoch];
        _timezone = [Types timezoneFromLocalTime:_localTime andInternalTime:_internalTime];
    }

    return self;
}

+ (instancetype)recordWithInternalSecondsSinceDexcomEpoch:(uint32_t)internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:(uint32_t)localSecondsSinceDexcomEpoch recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber {
    return [[self alloc] initWithInternalSecondsSinceDexcomEpoch:internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:localSecondsSinceDexcomEpoch recordNumber:recordNumber pageNumber:pageNumber];
}

- (NSString *)description {
    return [NSString stringWithFormat: @"[%@] internalTime=[%@] internalSecondsSinceDexcomEpoch=[%u] displayTime=[%@] displaySecondsSinceDexcomEpoch=[%u] timezone=[%@] recordNumber=[%d] pageNumber=[%d]",
                    [self class],
                    _internalTime,
                    _internalSecondsSinceDexcomEpoch,
                    _localTime,
                    _localSecondsSinceDexcomEpoch,
                    _timezone,
                    _recordNumber,
                    _pageNumber];
}
@end