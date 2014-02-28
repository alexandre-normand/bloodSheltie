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

@end