#import "GenericRecord.h"
#import "Types.h"


@implementation GenericRecord {

}
- (instancetype)initWithRawInternalTimeInSeconds:(uint32_t)rawInternalTimeInSeconds rawDisplayTimeInSeconds:(uint32_t)rawDiplayTimeInSeconds recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber dexcomOffsetWithStandardInSeconds:(int32_t)dexcomOffsetInSeconds {
    self = [super init];
    if (self) {
        _rawInternalTimeInSeconds = rawInternalTimeInSeconds;
        _internalSecondsSinceStandardEpoch = _rawInternalTimeInSeconds - dexcomOffsetInSeconds;
        _internalTime = [NSDate dateWithTimeIntervalSince1970:_internalSecondsSinceStandardEpoch];
        _rawDisplayTimeInSeconds = rawDiplayTimeInSeconds;
        _displayTimeSinceStandardEpoch = rawDiplayTimeInSeconds - dexcomOffsetInSeconds;
        _displayTime = [NSDate dateWithTimeIntervalSince1970:_displayTimeSinceStandardEpoch];
        _recordNumber=recordNumber;
        _pageNumber=pageNumber;
        _timezone = [Types timezoneFromLocalTime:_displayTime andInternalTime:_internalTime];
    }

    return self;
}

+ (instancetype)recordWithRawInternalTimeInSeconds:(uint32_t)rawInternalTimeInSeconds rawDisplayTimeInSeconds:(uint32_t)rawDiplayTimeInSeconds recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber dexcomOffsetWithStandardInSeconds:(int32_t)dexcomOffsetInSeconds {
    return [[self alloc] initWithRawInternalTimeInSeconds:rawInternalTimeInSeconds rawDisplayTimeInSeconds:rawDiplayTimeInSeconds recordNumber:recordNumber pageNumber:pageNumber dexcomOffsetWithStandardInSeconds:dexcomOffsetInSeconds];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[%@] rawInternalTimeInSeconds=[%u] internalTimeInSecondsSinceStandardEpoch=[%u] internalTime=[%@] rawDisplayTimeInSeconds=[%u] displayTimeInSecondsSinceStandardEpoch=[%u] displayTime=[%@] timezone=[%@] recordNumber=[%d] pageNumber=[%d]",
                                      [self class],
                                      _rawInternalTimeInSeconds,
                                      _internalSecondsSinceStandardEpoch,
                                      _internalTime,
                                      _rawDisplayTimeInSeconds,
                                      _displayTimeSinceStandardEpoch,
                                      _displayTime,
                                      _timezone,
                                      _recordNumber,
                                      _pageNumber];
}
@end