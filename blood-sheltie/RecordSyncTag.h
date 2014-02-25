#import <Foundation/Foundation.h>
#import <Mantle/MTLModel.h>
#import <Mantle/MTLJSONAdapter.h>


@interface RecordSyncTag : MTLModel <MTLJSONSerializing>
// This is the most recent record number, this should be interpreted meaning that the user
// code already received that record and it wants anything that comes after
@property (nonatomic, copy, readonly) NSNumber *recordNumber;
@property (nonatomic, copy, readonly) NSNumber *pageNumber;

- (instancetype)initWithRecordNumber:(NSNumber *)recordNumber pageNumber:(NSNumber *)pageNumber;

- (BOOL)isInitialSync;

+ (instancetype)tagWithRecordNumber:(NSNumber *)recordNumber pageNumber:(NSNumber *)pageNumber;

+ (instancetype)initialSyncTag;
@end