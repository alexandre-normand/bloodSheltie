#import <Foundation/Foundation.h>
#import "ManufacturingParameters.h"

@interface SyncData : NSObject
@property(readonly) NSMutableArray *glucoseReads;
@property(readonly) NSMutableArray *calibrationReads;
@property(readonly) NSMutableArray *userEvents;
@property(readwrite) ManufacturingParameters *manufacturingParameters;

- (id)init;

- (instancetype)initWithGlucoseReads:(NSMutableArray *)glucoseReads calibrationReads:(NSMutableArray *)calibrationReads userEvents:(NSMutableArray *)userEvents manufacturingParameters:(ManufacturingParameters *)manufacturingParameters;

+ (instancetype)dataWithGlucoseReads:(NSMutableArray *)glucoseReads calibrationReads:(NSMutableArray *)calibrationReads userEvents:(NSMutableArray *)userEvents manufacturingParameters:(ManufacturingParameters *)manufacturingParameters;

@end