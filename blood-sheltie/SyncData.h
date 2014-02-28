#import <Foundation/Foundation.h>
#import "ManufacturingParameters.h"
#import "Types.h"

@interface SyncData : NSObject
@property GlucoseUnit glucoseUnit;
@property(readonly) NSMutableArray *glucoseReads;
@property(readonly) NSMutableArray *calibrationReads;
@property(readonly) NSMutableArray *userEvents;
@property(readwrite) ManufacturingParameters *manufacturingParameters;

- (id)init;

- (instancetype)initWithGlucoseUnit:(GlucoseUnit)glucoseUnit glucoseReads:(NSMutableArray *)glucoseReads calibrationReads:(NSMutableArray *)calibrationReads userEvents:(NSMutableArray *)userEvents manufacturingParameters:(ManufacturingParameters *)manufacturingParameters;

+ (instancetype)dataWithGlucoseUnit:(GlucoseUnit)glucoseUnit glucoseReads:(NSMutableArray *)glucoseReads calibrationReads:(NSMutableArray *)calibrationReads userEvents:(NSMutableArray *)userEvents manufacturingParameters:(ManufacturingParameters *)manufacturingParameters;

@end