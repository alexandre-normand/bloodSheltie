#import <Foundation/Foundation.h>
#import "SyncEvent.h"
#import "SyncTag.h"
#import "SyncData.h"

@interface SyncCompletionEvent : SyncEvent
@property(readonly) SyncTag *syncTag;

- (instancetype)initWithPort:(ORSSerialPort *)port sessionData:(SyncData *)syncData syncTag:(SyncTag *)syncTag;

+ (instancetype)eventWithPort:(ORSSerialPort *)port syncData:(SyncData *)syncData syncTag:(SyncTag *)syncTag;

@end