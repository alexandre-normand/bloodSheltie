#import <Foundation/Foundation.h>
#import "TimestampedEvent.h"

typedef enum InsulinType : Byte InsulinType;
enum RecordType : Byte {
    Unknown = 0,
    Bolus = 1,
    Basal = 2
};


@interface InsulinInjection : TimestampedEvent
@property(readonly) NSString *insulinName;
@property(readonly) InsulinType insulinType;
@property(readonly) float unitValue;

@end