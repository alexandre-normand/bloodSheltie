#import <Mantle/MTLModel+NSCoding.h>
#import <Mantle/NSValueTransformer+MTLPredefinedTransformerAdditions.h>
#import "SyncTag.h"


// Singleton Instance to Mark an Initial Sync
static SyncTag *initialSyncTag = nil;

@implementation SyncTag {
    BOOL isInitialSync;
}

+ (void)initialize {
    static BOOL initialized = NO;
    if(!initialized)
    {
        initialized = YES;
        initialSyncTag = [[SyncTag alloc] initInitialSync];
    }
}

- (instancetype)initInitialSync {
    self = [super init];
    if (self) {
        isInitialSync = YES;
        _lastGlucoseRead = [RecordSyncTag initialSyncTag];
        _lastUserEvent = [RecordSyncTag initialSyncTag];
        _lastCalibrationRead = [RecordSyncTag initialSyncTag];
        _serialNumber = @"Not available";
    }

    return self;
}

- (instancetype)initWithSerialNumber:(NSString *)serialNumber lastGlucoseRead:(RecordSyncTag *)lastGlucoseRead lastUserEvent:(RecordSyncTag *)lastUserEvent lastCalibrationRead:(RecordSyncTag *)lastCalibrationRead {
    self = [super init];
    if (self) {
        isInitialSync = NO;
        _lastGlucoseRead = lastGlucoseRead;
        _lastUserEvent = lastUserEvent;
        _lastCalibrationRead = lastCalibrationRead;
        _serialNumber = serialNumber;
    }

    return self;
}

- (BOOL)isInitialSync {
    return isInitialSync;
}

+ (instancetype)tagWithSerialNumber:(NSString *)serialNumber lastGlucoseRead:(RecordSyncTag *)lastGlucoseRead lastUserEvent:(RecordSyncTag *)lastUserEvent lastCalibrationRead:(RecordSyncTag *)lastCalibrationRead {
    return [[self alloc] initWithSerialNumber:serialNumber lastGlucoseRead:lastGlucoseRead lastUserEvent:lastUserEvent lastCalibrationRead:lastCalibrationRead];
}

+ (instancetype)initialSyncTag {
    return initialSyncTag;
}


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
            @"lastGlucoseRead" : @"lastGlucoseRead",
            @"lastUserEvent" : @"lastUserEvent",
            @"lastCalibrationRead" : @"lastCalibrationRead"
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

- (NSString *)description {
    NSMutableString *description = [NSMutableString string];
    [description appendFormat:@"isInitialSync=%d", isInitialSync];
    [description appendFormat:@", self.serialNumber=%@", self.serialNumber];
    [description appendFormat:@", self.lastCalibrationRead=%@", self.lastCalibrationRead];
    [description appendFormat:@", self.lastUserEvent=%@", self.lastUserEvent];
    [description appendFormat:@", self.lastGlucoseRead=%@", self.lastGlucoseRead];

    NSMutableString *superDescription = [[super description] mutableCopy];
    NSUInteger length = [superDescription length];

    if (length > 0 && [superDescription characterAtIndex:length - 1] == '>') {
        [superDescription insertString:@", " atIndex:length - 1];
        [superDescription insertString:description atIndex:length + 1];
        return superDescription;
    }
    else {
        return [NSString stringWithFormat:@"<%@: %@>", NSStringFromClass([self class]), description];
    }
}

@end