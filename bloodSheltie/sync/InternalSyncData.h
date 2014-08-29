#import <Foundation/Foundation.h>
#import "ManufacturingParameters.h"
#import "Types.h"

@class TimeOffset;

@interface InternalSyncData : NSObject
@property GlucoseUnit glucoseUnit;
@property int32_t timeOffsetInSeconds;
@property(readonly) NSMutableArray *glucoseReads;
@property(readonly) NSMutableArray *calibrationReads;
@property(readonly) NSMutableArray *userEvents;
@property(readwrite) ManufacturingParameters *manufacturingParameters;

- (id)init;

- (instancetype)initWithGlucoseUnit:(GlucoseUnit)glucoseUnit timeOffsetInSeconds:(int32_t)timeOffsetInSeconds glucoseReads:(NSMutableArray *)glucoseReads calibrationReads:(NSMutableArray *)calibrationReads userEvents:(NSMutableArray *)userEvents manufacturingParameters:(ManufacturingParameters *)manufacturingParameters;

+ (instancetype)dataWithGlucoseUnit:(GlucoseUnit)glucoseUnit timeOffsetInSeconds:(int32_t)timeOffsetInSeconds glucoseReads:(NSMutableArray *)glucoseReads calibrationReads:(NSMutableArray *)calibrationReads userEvents:(NSMutableArray *)userEvents manufacturingParameters:(ManufacturingParameters *)manufacturingParameters;

@end