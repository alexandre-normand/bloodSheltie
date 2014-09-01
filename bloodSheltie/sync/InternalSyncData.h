#import <Foundation/Foundation.h>
#import "ManufacturingParameters.h"
#import "Types.h"

@class TimeOffset;

@interface InternalSyncData : NSObject {

}
@property GlucoseUnit glucoseUnit;
@property(readonly) NSMutableArray *glucoseReads;
@property(readonly) NSMutableArray *calibrationReads;
@property(readonly) NSMutableArray *userEvents;
@property(readwrite) ManufacturingParameters *manufacturingParameters;
@property(readwrite) int32_t dexcomOffsetFromStandardEpoch;

- (id)init;

- (instancetype)initWithGlucoseUnit:(GlucoseUnit)glucoseUnit glucoseReads:(NSMutableArray *)glucoseReads calibrationReads:(NSMutableArray *)calibrationReads userEvents:(NSMutableArray *)userEvents manufacturingParameters:(ManufacturingParameters *)manufacturingParameters dexcomOffsetFromStandardEpoch:(int32_t)dexcomOffsetFromStandardEpoch;

+ (instancetype)dataWithGlucoseUnit:(GlucoseUnit)glucoseUnit glucoseReads:(NSMutableArray *)glucoseReads calibrationReads:(NSMutableArray *)calibrationReads userEvents:(NSMutableArray *)userEvents manufacturingParameters:(ManufacturingParameters *)manufacturingParameters dexcomOffsetFromStandardEpoch:(int32_t)dexcomOffsetFromStandardEpoch;

@end