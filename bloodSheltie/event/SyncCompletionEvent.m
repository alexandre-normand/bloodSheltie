#import <Mantle/MTLModel+NSCoding.h>
#import "SyncCompletionEvent.h"

@implementation SyncCompletionEvent {

}

- (instancetype)initWithPort:(ORSSerialPort *)port sessionData:(SyncData *)syncData syncTag:(SyncTag *)syncTag {
    self = [super initWithPort:port syncData:syncData];
    if (self) {
        _syncTag=syncTag;
    }

    return self;
}

+ (instancetype)eventWithPort:(ORSSerialPort *)port syncData:(SyncData *)syncData syncTag:(SyncTag *)syncTag {
    return [[self alloc] initWithPort:port sessionData:syncData syncTag:syncTag];
}
@end