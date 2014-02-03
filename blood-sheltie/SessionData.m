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

@end