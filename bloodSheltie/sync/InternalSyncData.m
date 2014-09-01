#import "InternalSyncData.h"
#import "TimeOffset.h"


@implementation InternalSyncData {


}

- (id)init {
    return [self initWithGlucoseUnit:(NoUnit) glucoseReads:[[NSMutableArray alloc] init] calibrationReads:[[NSMutableArray alloc] init] userEvents:[[NSMutableArray alloc] init] manufacturingParameters:nil dexcomOffsetFromStandardEpoch:0];
}

- (instancetype)initWithGlucoseUnit:(GlucoseUnit)glucoseUnit glucoseReads:(NSMutableArray *)glucoseReads calibrationReads:(NSMutableArray *)calibrationReads userEvents:(NSMutableArray *)userEvents manufacturingParameters:(ManufacturingParameters *)manufacturingParameters dexcomOffsetFromStandardEpoch:(int32_t)dexcomOffsetFromStandardEpoch {
    self = [super init];
    if (self) {
        _glucoseReads = glucoseReads;
        _calibrationReads = calibrationReads;
        _userEvents = userEvents;
        self.manufacturingParameters = manufacturingParameters;
        _glucoseUnit=glucoseUnit;
        _dexcomOffsetFromStandardEpoch = dexcomOffsetFromStandardEpoch;
    }

    return self;
}

+ (instancetype)dataWithGlucoseUnit:(GlucoseUnit)glucoseUnit glucoseReads:(NSMutableArray *)glucoseReads calibrationReads:(NSMutableArray *)calibrationReads userEvents:(NSMutableArray *)userEvents manufacturingParameters:(ManufacturingParameters *)manufacturingParameters dexcomOffsetFromStandardEpoch:(int32_t)dexcomOffsetFromStandardEpoch {
    return [[self alloc] initWithGlucoseUnit:glucoseUnit glucoseReads:glucoseReads calibrationReads:calibrationReads userEvents:userEvents manufacturingParameters:manufacturingParameters dexcomOffsetFromStandardEpoch:dexcomOffsetFromStandardEpoch];
}


- (NSString *)description {
    return [NSString stringWithFormat:@"[InternalSyncData] glucoseReads=%@ userEvents=%@ calibrationReads=%@ dexcomOffsetFromStandardEpoch=%d", _glucoseReads,
                                      _userEvents, _calibrationReads, _dexcomOffsetFromStandardEpoch];
}

@end