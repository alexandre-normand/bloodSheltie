#import <Foundation/Foundation.h>
#import <Mantle/MTLModel.h>
#import <Mantle/MTLJSONAdapter.h>


@interface RecordSyncTag : MTLModel <MTLJSONSerializing>
@property (nonatomic, copy, readonly) NSNumber *recordNumber;
@property (nonatomic, copy, readonly) NSNumber *pageNumber;

- (instancetype)initWithRecordNumber:(NSNumber *)recordNumber pageNumber:(NSNumber *)pageNumber;

+ (instancetype)tagWithRecordNumber:(NSNumber *)recordNumber pageNumber:(NSNumber *)pageNumber;


@end