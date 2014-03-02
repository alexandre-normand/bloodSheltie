#import "SyncData.h"
#import "ManufacturingParameters.h"


@implementation SyncData {

}
- (instancetype)initWithGlucoseReads:(NSArray *)glucoseReads calibrationReads:(NSArray *)calibrationReads insulinInjections:(NSArray *)insulinInjections exerciseEvents:(NSArray *)exerciseEvents healthEvents:(NSArray *)healthEvents carbIntakes:(NSArray *)carbIntakes manufacturingParameters:(ManufacturingParameters *)manufacturingParameters {
    self = [super init];
    if (self) {
        _glucoseReads = glucoseReads;
        _calibrationReads=calibrationReads;
        _insulinInjections=insulinInjections;
        _exerciseEvents=exerciseEvents;
        _healthEvents=healthEvents;
        _foodEvents =carbIntakes;
        self.manufacturingParameters=manufacturingParameters;
    }

    return self;
}

+ (instancetype)dataWithGlucoseReads:(NSArray *)glucoseReads calibrationReads:(NSArray *)calibrationReads insulinInjections:(NSArray *)insulinInjections exerciseEvents:(NSArray *)exerciseEvents healthEvents:(NSArray *)healthEvents foodEvents:(NSArray *)carbIntakes manufacturingParameters:(ManufacturingParameters *)manufacturingParameters {
    return [[self alloc] initWithGlucoseReads:glucoseReads calibrationReads:calibrationReads insulinInjections:insulinInjections exerciseEvents:exerciseEvents healthEvents:healthEvents carbIntakes:carbIntakes manufacturingParameters:manufacturingParameters];
}


- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.glucoseReads=%@", self.glucoseReads];
    [description appendFormat:@", self.calibrationReads=%@", self.calibrationReads];
    [description appendFormat:@", self.insulinInjections=%@", self.insulinInjections];
    [description appendFormat:@", self.exerciseEvents=%@", self.exerciseEvents];
    [description appendFormat:@", self.healthEvents=%@", self.healthEvents];
    [description appendFormat:@", self.foodEvents=%@", self.foodEvents];
    [description appendFormat:@", self.manufacturingParameters=%@", self.manufacturingParameters];
    [description appendString:@">"];
    return description;
}

@end