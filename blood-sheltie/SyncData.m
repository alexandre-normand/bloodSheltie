#import "SyncData.h"


@implementation SyncData {


}

- (id)init {
    return [self initWithGlucoseReads:[[NSMutableArray alloc] init]
                     calibrationReads:[[NSMutableArray alloc] init]
                           userEvents:[[NSMutableArray alloc] init]
              manufacturingParameters:nil];
}

- (instancetype)initWithGlucoseReads:(NSMutableArray *)glucoseReads calibrationReads:(NSMutableArray *)calibrationReads userEvents:(NSMutableArray *)userEvents manufacturingParameters:(ManufacturingParameters *)manufacturingParameters {
    self = [super init];
    if (self) {
        _glucoseReads = glucoseReads;
        _calibrationReads = calibrationReads;
        _userEvents = userEvents;
        self.manufacturingParameters = manufacturingParameters;
    }

    return self;
}

+ (instancetype)dataWithGlucoseReads:(NSMutableArray *)glucoseReads calibrationReads:(NSMutableArray *)calibrationReads userEvents:(NSMutableArray *)userEvents manufacturingParameters:(ManufacturingParameters *)manufacturingParameters {
    return [[self alloc] initWithGlucoseReads:glucoseReads calibrationReads:calibrationReads userEvents:userEvents manufacturingParameters:manufacturingParameters];
}


- (NSString *)description {
    return [NSString stringWithFormat:@"[SyncData] glucoseReads=%@ userEvents=%@ calibrationReads=%@", _glucoseReads,
                                      _userEvents, _calibrationReads];
}

@end