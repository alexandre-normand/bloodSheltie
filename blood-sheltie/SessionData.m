#import "SessionData.h"


@implementation SessionData {


}

- (id)init {
    self = [super init];
    if (self) {
        _glucoseReads = [[NSMutableArray alloc] init];
        _userEvents = [[NSMutableArray alloc] init];
        _calibrationReads = [[NSMutableArray alloc] init];
    }

    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[SessionData] glucoseReads=%@ userEvents=%@ calibrationReads=%@", _glucoseReads,
                                      _userEvents, _calibrationReads];
}

@end