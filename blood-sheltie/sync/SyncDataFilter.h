#import <Foundation/Foundation.h>
#import "SyncData.h"

@interface SyncDataFilter : NSObject
+(SyncData *) filterData:(SyncData *)data since:(NSDate *)since;
@end