#import "RecordSyncTag.h"


@implementation RecordSyncTag
- (instancetype)initWithRecordNumber:(NSNumber *)recordNumber pageNumber:(NSNumber *)pageNumber {
    self = [super init];
    if (self) {
        _recordNumber = recordNumber;
        _pageNumber=pageNumber;
    }

    return self;
}

+ (instancetype)tagWithRecordNumber:(NSNumber *)recordNumber pageNumber:(NSNumber *)pageNumber {
    return [[self alloc] initWithRecordNumber:recordNumber pageNumber:pageNumber];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
            @"recordNumber": @"recordNumber",
            @"pageNumber": @"pageNumber"
    };
}

@end