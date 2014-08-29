#import "InternalSyncData.h"
#import "TimeOffset.h"


@implementation InternalSyncData {


}

- (id)init {
    return [self initWithGlucoseUnit:(NoUnit) timeOffsetInSeconds:0 glucoseReads:[[NSMutableArray alloc] init] calibrationReads:[[NSMutableArray alloc] init] userEvents:[[NSMutableArray alloc] init] manufacturingParameters:nil];
}

- (instancetype)initWithGlucoseUnit:(GlucoseUnit)glucoseUnit timeOffsetInSeconds:(int32_t)timeOffsetInSeconds glucoseReads:(NSMutableArray *)glucoseReads calibrationReads:(NSMutableArray *)calibrationReads userEvents:(NSMutableArray *)userEvents manufacturingParameters:(ManufacturingParameters *)manufacturingParameters {
    self = [super init];
    if (self) {
        _glucoseReads = glucoseReads;
        _calibrationReads = calibrationReads;
        _userEvents = userEvents;
        self.manufacturingParameters = manufacturingParameters;
        _glucoseUnit=glucoseUnit;
        _timeOffsetInSeconds=timeOffsetInSeconds;
    }

    return self;
}

+ (instancetype)dataWithGlucoseUnit:(GlucoseUnit)glucoseUnit timeOffsetInSeconds:(int32_t)timeOffsetInSeconds glucoseReads:(NSMutableArray *)glucoseReads calibrationReads:(NSMutableArray *)calibrationReads userEvents:(NSMutableArray *)userEvents manufacturingParameters:(ManufacturingParameters *)manufacturingParameters {
    return [[self alloc] initWithGlucoseUnit:glucoseUnit timeOffsetInSeconds:timeOffsetInSeconds glucoseReads:glucoseReads calibrationReads:calibrationReads userEvents:userEvents manufacturingParameters:manufacturingParameters];
}


- (NSString *)description {
    return [NSString stringWithFormat:@"[InternalSyncData] glucoseReads=%@ userEvents=%@ calibrationReads=%@ timeOffsetInSeconds=%d", _glucoseReads,
                                      _userEvents, _calibrationReads, _timeOffsetInSeconds];
}

@end