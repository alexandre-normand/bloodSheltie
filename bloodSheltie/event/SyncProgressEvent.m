#import "SyncEvent.h"
#import "SyncProgressEvent.h"


@implementation SyncProgressEvent {


}

- (instancetype)initWithPort:(ORSSerialPort *)port sessionData:(SyncData *)syncData totalToFetch:(NSUInteger)totalToFetch fetchedSoFar:(NSUInteger)fetchedSoFar {
    self = [super initWithPort:port syncData:syncData];
    if (self) {
        _totalPagesToFetch=totalToFetch;
        _fetchedSoFar=fetchedSoFar;
    }

    return self;
}

+ (instancetype)eventWithPort:(ORSSerialPort *)port syncData:(SyncData *)syncData totalToFetch:(NSUInteger)totalToFetch fetchedSoFar:(NSUInteger)fetchedSoFar {
    return [[self alloc] initWithPort:port sessionData:syncData totalToFetch:totalToFetch fetchedSoFar:fetchedSoFar];
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.totalPagesToFetch=%lu", self.totalPagesToFetch];
    [description appendFormat:@", self.fetchedSoFar=%lu", self.fetchedSoFar];
    [description appendString:@">"];
    return description;
}

@end