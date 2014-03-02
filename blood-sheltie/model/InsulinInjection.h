#import <Foundation/Foundation.h>
#import "TimestampedEvent.h"

typedef enum InsulinType : Byte InsulinType;
enum InsulinType : Byte {
    UnknownInsulinType = 0,
    Bolus = 1,
    Basal = 2
};


@interface InsulinInjection : TimestampedEvent
@property(readonly) NSString *insulinName;
@property(readonly) InsulinType insulinType;
@property(readonly) float unitValue;

- (instancetype)initWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime userTimezone:(NSTimeZone *)userTimezone eventTime:(NSDate *)eventTime insulinType:(InsulinType)insulinType unitValue:(float)unitValue insulinName:(NSString *)insulinName;

- (NSString *)description;

+ (instancetype)valueWithInternalTime:(NSDate *)internalTime userTime:(NSDate *)userTime userTimezone:(NSTimeZone *)userTimezone eventTime:(NSDate *)eventTime insulinType:(InsulinType)insulinType unitValue:(float)unitValue insulinName:(NSString *)insulinName;

@end