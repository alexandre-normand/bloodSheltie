#import <Foundation/Foundation.h>
#import "SyncData.h"
#import "InternalSyncData.h"

@interface SyncDataAdapter : NSObject
+(SyncData *) convertSyncData:(InternalSyncData *)syncData;
@end