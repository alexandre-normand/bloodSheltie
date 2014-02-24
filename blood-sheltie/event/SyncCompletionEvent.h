#import <Foundation/Foundation.h>
#import "SyncEvent.h"
#import "SyncTag.h"

@class SyncData;

@interface SyncCompletionEvent : SyncEvent
@property(readonly) SyncTag *syncTag;

- (instancetype)initWithPort:(ORSSerialPort *)port sessionData:(SyncData *)sessionData syncTag:(SyncTag *)syncTag;

+ (instancetype)eventWithPort:(ORSSerialPort *)port sessionData:(SyncData *)sessionData syncTag:(SyncTag *)syncTag;

@end