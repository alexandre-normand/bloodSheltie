#import "TimestampedValue.h"


@implementation TimestampedValue {

}
- (instancetype)initWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime timezone:(NSTimeZone *)timezone {
    self = [super init];
    if (self) {
        _internalTime = internalTime;
        _userTime=userTime;
        _timezone=timezone;
    }

    return self;
}

+ (instancetype)valueWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime timezone:(NSTimeZone *)timezone {
    return [[self alloc] initWithInternalTime:internalTime userTime:userTime timezone:timezone];
}

@end