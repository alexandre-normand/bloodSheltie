#import <Foundation/Foundation.h>

typedef uint16_t CRC;

typedef enum RecordType : Byte RecordType;
enum RecordType : Byte {
    Aberration = 0x06,
    CalSet = 0x05,
    EGVData = 0x04,
    FirmwareParameterData = 0x01,
    InsertionTime = 0x07,
    ManufacturingData = 0x00,
    MaxValue = 0x0D,
    MeterData = 0x0A,
    PCSoftwareParameter = 0x02,
    ReceiverErrorData = 0x09,
    ReceiverLogData = 0x08,
    SensorData = 0x03,
    UserEventData = 0x0B,
    UserSettingData = 0x0C
};

typedef enum ReceiverCommand : Byte ReceiverCommand;
enum ReceiverCommand : Byte {
    Ack = 0x01,
    EnterFirmwareUpgradeMode = 0x32,
    EnterSambaAccessMode = 0x35,
    EraseDatabase = 0x2d,
    IncompletePacketReceived = 0x05,
    InvalidCommand = 0x03,
    InvalidMode = 0x07,
    InvalidParam = 0x04,
    MaxCommand = 0x3b,
    MaxPossibleCommand = 0xff,
    Nak = 0x02,
    Null = 0x00,
    Ping = 0x0A,
    ReadBatteryLevel = 0x21,
    ReadBatteryState = 0x30,
    ReadBlindedMode = 0x27,
    ReadClockMode = 0x29,
    ReadDatabasePageHeader = 0x12,
    ReadDatabasePageRange = 0x10,
    ReadDatabasePages = 0x11,
    ReadDatabasePartitionInfo = 0x0F,
    ReadDeviceMode = 0x2b,
    ReadDisplayTimeOffset = 0x1d,
    ReadEnableSetUpWizardFlag = 0x37,
    ReadFirmwareHeader = 0x0B,
    ReadFirmwareSettings = 0x36,
    ReadFlashPage = 0x33,
    ReadGlucoseUnit = 0x25,
    ReadHardwareBoardId = 0x31,
    ReadLanguage = 0x1b,
    ReadRTC = 0x1f,
    ReadSetUpWizardState = 0x39,
    ReadSystemTime = 0x22,
    ReadSystemTimeOffset = 0x23,
    ReadTransmitterID = 0x19,
    ReceiverError = 0x06,
    ResetReceiver = 0x20,
    ShutdownReceiver = 0x2e,
    WriteBlindedMode = 0x28,
    WriteClockMode = 0x2a,
    WriteDisplayTimeOffset = 0x1E,
    WriteEnableSetUpWizardFlag = 0x38,
    WriteFlashPage = 0x34,
    WriteGlucoseUnit = 0x26,
    WriteLanguage = 0x1c,
    WritePCParameters = 0x2f,
    WriteSetUpWizardState = 0x3a,
    WriteSystemTime = 0x24,
    WriteTransmitterID = 0x1a
};

typedef enum UserEventType : Byte UserEventType;
enum UserEventType : Byte {
    Carbs = 1,
    Exercise = 4,
    Health = 3,
    Insulin = 2,
    UEMaxValue = 5,
    NullType = 0
};

typedef enum HealthEventSubType : Byte HealthEventSubType;
enum HealthEventSubType : Byte {
    Alcohol = 6,
    Cycle = 5,
    HighSymptoms = 3,
    Illness = 1,
    LowSymptoms = 4,
    NullHealthEventSubType = 0,
    Stress = 2
};

typedef enum ExerciseEventSubType : Byte ExerciseEventSubType;
enum ExerciseEventSubType : Byte {
    Heavy = 3,
    Light = 1,
    MaxExerciseEventSubType = 4,
    Medium = 2,
    NullExerciseEventSubType = 0
};

typedef enum GlucoseUnit : Byte GlucoseUnit;
enum GlucoseUnit : Byte {
    mgPerDL = 1,
    mmolPerL = 2,
    NoUnit = 0
};

static NSString *const UNKNOWN = @"Unknown";

static uint32_t NOT_AVAILABLE = UINT32_MAX;

@interface Types : NSObject
+ (NSString *)receiverCommandIdentifier:(ReceiverCommand)command;

+ (NSString *)recordTypeIdentifier:(RecordType)recordType;

+ (NSString *)userEventTypeIdentifier:(UserEventType)userEventType;

+ (NSString *)exerciseEventSubTypeIdentifier:(ExerciseEventSubType)exerciseEventSubType;

+ (NSString *)healthEventSubTypeIdentifier:(HealthEventSubType)healthEventSubType;

+ (NSString *)subEventIdentifier:(UserEventType)userEventType subEventType:(Byte)subEventType;

+ (NSString *) glucoseUnitIdentifier:(GlucoseUnit)glucoseUnit;

//+ (NSDate *)dateTimeFromSecondsSinceDexcomEpoch:(uint32_t)secondsSinceDexcomEpoch;

+ (NSTimeZone *)timezoneFromLocalTime:(NSDate *)localTime andInternalTime:(NSDate *)internalTime;

+ (NSTimeZone *)timezoneFromOffsetInSeconds:(int32_t)offset;

+ (NSDate *)dexcomEpoch;

+ (NSString *)dexcomUintToString:(uint32_t)value;
@end