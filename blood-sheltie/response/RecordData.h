#import <Foundation/Foundation.h>
#import "ResponsePayload.h"
#import "Types.h"


@interface RecordData : ResponsePayload
@property(readonly) RecordType recordType;
@property(readonly) NSArray *records;

- (instancetype)initWithRecordType:(RecordType)recordType records:(NSArray *)records;

+ (instancetype)dataWithRecordType:(RecordType)recordType records:(NSArray *)records;

@end