#import "RecordData.h"


@implementation RecordData {

}
- (instancetype)initWithRecordType:(RecordType)recordType records:(NSArray *)records {
    self = [super init];
    if (self) {
        _recordType = recordType;
        _records = records;
    }

    return self;
}

+ (instancetype)dataWithRecordType:(RecordType)recordType records:(NSArray *)records {
    return [[self alloc] initWithRecordType:recordType records:records];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"[RecordData]: recordType=%s records=%@",
                                      [[Types recordTypeIdentifier:_recordType] UTF8String],
                                      _records];
}

@end