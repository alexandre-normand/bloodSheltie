#import <Mantle/MTLModel+NSCoding.h>
#import <Mantle/NSValueTransformer+MTLPredefinedTransformerAdditions.h>
#import "SyncTag.h"
#import "RecordSyncTag.h"


@implementation SyncTag {

}
- (instancetype)initWithLastGlucoseRead:(RecordSyncTag *)lastGlucoseRead lastUserEvent:(RecordSyncTag *)lastUserEvent lastCalibrationRead:(RecordSyncTag *)lastCalibrationRead {
    self = [super init];
    if (self) {
        _lastGlucoseRead = lastGlucoseRead;
        _lastUserEvent=lastUserEvent;
        _lastCalibrationRead=lastCalibrationRead;
    }

    return self;
}

+ (instancetype)tagWithLastGlucoseRead:(RecordSyncTag *)lastGlucoseRead lastUserEvent:(RecordSyncTag *)lastUserEvent lastCalibrationRead:(RecordSyncTag *)lastCalibrationRead {
    return [[self alloc] initWithLastGlucoseRead:lastGlucoseRead lastUserEvent:lastUserEvent lastCalibrationRead:lastCalibrationRead];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
            @"lastGlucoseRead": @"lastGlucoseRead",
            @"lastUserEvent": @"lastUserEvent",
            @"lastCalibrationRead": @"lastCalibrationRead"
    };
}

+ (NSValueTransformer *)lastGlucoseReadJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:RecordSyncTag.class];
}

+ (NSValueTransformer *)lastUserEventJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:RecordSyncTag.class];
}

+ (NSValueTransformer *)lastCalibrationReadJSONTransformer {
    return [NSValueTransformer mtl_JSONDictionaryTransformerWithModelClass:RecordSyncTag.class];
}
@end