#import <Foundation/Foundation.h>
#import <Mantle/MTLJSONAdapter.h>

@class RecordSyncTag;


@interface SyncTag : MTLModel <MTLJSONSerializing>
@property (nonatomic, copy, readonly) RecordSyncTag *lastCalibrationRead;
@property (nonatomic, copy, readonly) RecordSyncTag *lastUserEvent;
@property (nonatomic, copy, readonly) RecordSyncTag *lastGlucoseRead;

- (instancetype)initWithLastGlucoseRead:(RecordSyncTag *)lastGlucoseRead lastUserEvent:(RecordSyncTag *)lastUserEvent lastCalibrationRead:(RecordSyncTag *)lastCalibrationRead;

+ (instancetype)tagWithLastGlucoseRead:(RecordSyncTag *)lastGlucoseRead lastUserEvent:(RecordSyncTag *)lastUserEvent lastCalibrationRead:(RecordSyncTag *)lastCalibrationRead;

@end