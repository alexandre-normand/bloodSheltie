#import "ManufacturingParameters.h"


@implementation ManufacturingParameters {

}
- (instancetype)initWithSerialNumber:(NSString *)serialNumber hardwarePartNumber:(NSString *)hardwarePartNumber hardwareRevision:(NSString *)hardwareRevision dateTimeCreated:(NSString *)dateTimeCreated hardwareId:(NSString *)hardwareId {
    self = [super init];
    if (self) {
        _serialNumber = serialNumber;
        _hardwarePartNumber=hardwarePartNumber;
        _hardwareRevision=hardwareRevision;
        _dateTimeCreated=dateTimeCreated;
        _hardwareId=hardwareId;
    }

    return self;
}

+ (instancetype)dataWithSerialNumber:(NSString *)serialNumber hardwarePartNumber:(NSString *)hardwarePartNumber hardwareRevision:(NSString *)hardwareRevision dateTimeCreated:(NSString *)dateTimeCreated hardwareId:(NSString *)hardwareId {
    return [[self alloc] initWithSerialNumber:serialNumber hardwarePartNumber:hardwarePartNumber hardwareRevision:hardwareRevision dateTimeCreated:dateTimeCreated hardwareId:hardwareId];
}

- (NSString *)description {
    return [NSString stringWithFormat: @"[ManufacturingParameters] serialNumber=[%s] hardwarePartNumber=[%s] hardwareRevision=[%s] dateTimeCreated=[%s] hardwareId=[%s]",
                    [_serialNumber UTF8String], [_hardwarePartNumber UTF8String], [_hardwareRevision UTF8String], [_dateTimeCreated UTF8String], [_hardwareId UTF8String]];
}
@end