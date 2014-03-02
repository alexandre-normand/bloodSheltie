#import "InternalSyncData.h"


@implementation InternalSyncData {


}

- (id)init {
    return [self initWithGlucoseUnit:(NoUnit) glucoseReads:[[NSMutableArray alloc] init] calibrationReads:[[NSMutableArray alloc] init] userEvents:[[NSMutableArray alloc] init] manufacturingParameters:nil ];
}

- (instancetype)initWithGlucoseUnit:(GlucoseUnit)glucoseUnit glucoseReads:(NSMutableArray *)glucoseReads calibrationReads:(NSMutableArray *)calibrationReads userEvents:(NSMutableArray *)userEvents manufacturingParameters:(ManufacturingParameters *)manufacturingParameters {
    self = [super init];
    if (self) {
        _glucoseReads = glucoseReads;
        _calibrationReads = calibrationReads;
        _userEvents = userEvents;
        self.manufacturingParameters = manufacturingParameters;
        _glucoseUnit=glucoseUnit;
    }

    return self;
}

+ (instancetype)dataWithGlucoseUnit:(GlucoseUnit)glucoseUnit glucoseReads:(NSMutableArray *)glucoseReads calibrationReads:(NSMutableArray *)calibrationReads userEvents:(NSMutableArray *)userEvents manufacturingParameters:(ManufacturingParameters *)manufacturingParameters {
    return [[self alloc] initWithGlucoseUnit:glucoseUnit glucoseReads:glucoseReads calibrationReads:calibrationReads userEvents:userEvents manufacturingParameters:manufacturingParameters];
}


- (NSString *)description {
    return [NSString stringWithFormat:@"[InternalSyncData] glucoseReads=%@ userEvents=%@ calibrationReads=%@", _glucoseReads,
                                      _userEvents, _calibrationReads];
}

@end