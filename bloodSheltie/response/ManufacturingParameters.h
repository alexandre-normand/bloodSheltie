#import <Foundation/Foundation.h>


@interface ManufacturingParameters : NSObject
@property(readonly) NSString *serialNumber;
@property(readonly) NSString *hardwarePartNumber;
@property(readonly) NSString *hardwareRevision;
@property(readonly) NSString *dateTimeCreated;
@property(readonly) NSString *hardwareId;

- (instancetype)initWithSerialNumber:(NSString *)serialNumber hardwarePartNumber:(NSString *)hardwarePartNumber hardwareRevision:(NSString *)hardwareRevision dateTimeCreated:(NSString *)dateTimeCreated hardwareId:(NSString *)hardwareId;

+ (instancetype)dataWithSerialNumber:(NSString *)serialNumber hardwarePartNumber:(NSString *)hardwarePartNumber hardwareRevision:(NSString *)hardwareRevision dateTimeCreated:(NSString *)dateTimeCreated hardwareId:(NSString *)hardwareId;

@end