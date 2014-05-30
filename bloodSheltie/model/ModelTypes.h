#import <Foundation/Foundation.h>


typedef enum GlucoseMeasurementUnit : Byte GlucoseMeasurementUnit;
enum GlucoseMeasurementUnit : Byte {
    UNKNOWN_MEASUREMENT_UNIT = 0,
    MMOL_PER_L = 1,
    MG_PER_DL = 2
};
