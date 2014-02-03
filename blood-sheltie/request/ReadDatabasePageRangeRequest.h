#import <Foundation/Foundation.h>
#import "ReceiverRequest.h"


@interface ReadDatabasePageRangeRequest : ReceiverRequest
@property(readonly) RecordType recordType;

- (instancetype)initWithRecordType:(RecordType)recordType;

+ (instancetype)requestWithRecordType:(RecordType)recordType;


@end