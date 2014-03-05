#import "RecordSyncTag.h"
#import "SyncTag.h"


// Singleton Instance to Mark an Initial Sync
static RecordSyncTag *initialSyncTag = nil;

@implementation RecordSyncTag {
    BOOL isInitialSync;
}

+ (void)initialize {
    static BOOL initialized = NO;
    if(!initialized)
    {
        initialized = YES;
        initialSyncTag = [[RecordSyncTag alloc] initInitialSync];
    }
}

- (instancetype)initInitialSync {
    self = [super init];
    if (self) {
        isInitialSync = YES;
        _recordNumber = @0;
        _pageNumber = @0;
    }

    return self;
}

- (instancetype)initWithRecordNumber:(NSNumber *)recordNumber pageNumber:(NSNumber *)pageNumber {
    self = [super init];
    if (self) {
        isInitialSync = NO;
        _recordNumber = recordNumber;
        _pageNumber=pageNumber;
    }

    return self;
}

- (BOOL)isInitialSync {
    return isInitialSync;
}

+ (instancetype)tagWithRecordNumber:(NSNumber *)recordNumber pageNumber:(NSNumber *)pageNumber {
    return [[self alloc] initWithRecordNumber:recordNumber pageNumber:pageNumber];
}

+ (instancetype)initialSyncTag {
    return initialSyncTag;
}


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
            @"recordNumber": @"recordNumber",
            @"pageNumber": @"pageNumber"
    };
}

@end