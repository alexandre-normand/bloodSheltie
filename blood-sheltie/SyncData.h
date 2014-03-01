#import <Foundation/Foundation.h>
#import "ManufacturingParameters.h"


@interface SyncData : NSObject
@property(readonly) NSArray *glucoseReads;
@property(readonly) NSArray *calibrationReads;
@property(readonly) NSArray *insulinInjections;
@property(readonly) NSArray *exerciseEvents;
@property(readonly) NSArray *healthEvents;
@property(readonly) NSArray *carbIntakes;
@property(readwrite) ManufacturingParameters *manufacturingParameters;

- (instancetype)initWithGlucoseReads:(NSArray *)glucoseReads calibrationReads:(NSArray *)calibrationReads insulinInjections:(NSArray *)insulinInjections exerciseEvents:(NSArray *)exerciseEvents healthEvents:(NSArray *)healthEvents carbIntakes:(NSArray *)carbIntakes manufacturingParameters:(ManufacturingParameters *)manufacturingParameters;

+ (instancetype)dataWithGlucoseReads:(NSArray *)glucoseReads calibrationReads:(NSArray *)calibrationReads insulinInjections:(NSArray *)insulinInjections exerciseEvents:(NSArray *)exerciseEvents healthEvents:(NSArray *)healthEvents foodEvents:(NSArray *)carbIntakes manufacturingParameters:(ManufacturingParameters *)manufacturingParameters;

- (NSString *)description;

@end