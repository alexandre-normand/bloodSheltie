#import <Mantle/MTLModel+NSCoding.h>
#import "SyncCompletionEvent.h"
#import "SyncData.h"


@implementation SyncCompletionEvent {

}

- (instancetype)initWithPort:(ORSSerialPort *)port sessionData:(SyncData *)sessionData syncTag:(SyncTag *)syncTag {
    self = [super initWithPort:port sessionData:sessionData];
    if (self) {
        _syncTag=syncTag;
    }

    return self;
}

+ (instancetype)eventWithPort:(ORSSerialPort *)port sessionData:(SyncData *)sessionData syncTag:(SyncTag *)syncTag {
    return [[self alloc] initWithPort:port sessionData:sessionData syncTag:syncTag];
}
@end