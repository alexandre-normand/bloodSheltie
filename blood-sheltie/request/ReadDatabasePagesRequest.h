#import <Foundation/Foundation.h>
#import "ReceiverRequest.h"


@interface ReadDatabasePagesRequest : ReceiverRequest
@property(readonly) RecordType recordType;
@property(readonly) uint pageNumber;
@property(readonly) Byte numberOfPages;

- (instancetype)initWithRecordType:(RecordType)recordType pageNumber:(uint)pageNumber numberOfPages:(Byte)numberOfPages;

+ (instancetype)requestWithRecordType:(RecordType)recordType pageNumber:(uint)pageNumber numberOfPages:(Byte)numberOfPages;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToRequest:(ReadDatabasePagesRequest *)request;

- (NSUInteger)hash;
@end