#import <Foundation/Foundation.h>
#import "ManufacturingParameters.h"

@interface SyncData : NSObject
@property(readonly) NSMutableArray *glucoseReads;
@property(readonly) NSMutableArray *calibrationReads;
@property(readonly) NSMutableArray *userEvents;
@property(readwrite) ManufacturingParameters *manufacturingParameters;
@end