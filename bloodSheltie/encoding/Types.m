#import "Types.h"

static const int TIMEZONE_GRANULARITY_IN_SECONDS = 15 * 60;

static NSDate *DEXCOM_EPOCH = nil;

@implementation Types {

}

+ (NSString *)receiverCommandIdentifier:(ReceiverCommand)command {
    switch (command) {
        case Ack:
            return @"ACK";
        case EnterFirmwareUpgradeMode:
            return @"EnterFirmwareUpgradeMode";
        case EnterSambaAccessMode:
            return @"EnterSambaAccessMode";
        case EraseDatabase:
            return @"EraseDatabase";
        case IncompletePacketReceived:
            return @"IncompletePacketReceived";
        case InvalidCommand:
            return @"InvalidCommand";
        case InvalidMode:
            return @"InvalidMode";
        case InvalidParam:
            return @"InvalidParam";
        case MaxCommand:
            return @"MaxCommand";
        case MaxPossibleCommand:
            return @"MaxPossibleCommand";
        case Nak:
            return @"Nak";
        case Null:
            return @"Null";
        case Ping:
            return @"Ping";
        case ReadBatteryLevel:
            return @"ReadBatteryLevel";
        case ReadBatteryState:
            return @"ReadBatteryState";
        case ReadBlindedMode:
            return @"ReadBlindedMode";
        case ReadClockMode:
            return @"ReadClockMode";
        case ReadDatabasePageHeader:
            return @"ReadDatabasePageHeader";
        case ReadDatabasePageRange:
            return @"ReadDatabasePageRange";
        case ReadDatabasePages:
            return @"ReadDatabasePages";
        case ReadDatabasePartitionInfo:
            return @"ReadDatabasePartitionInfo";
        case ReadDeviceMode:
            return @"ReadDeviceMode";
        case ReadDisplayTimeOffset:
            return @"ReadDisplayTimeOffset";
        case ReadEnableSetUpWizardFlag:
            return @"ReadEnableSetUpWizardFlag";
        case ReadFirmwareHeader:
            return @"ReadFirmwareHeader";
        case ReadFirmwareSettings:
            return @"ReadFirmwareSettings";
        case ReadFlashPage:
            return @"ReadFlashPage";
        case ReadGlucoseUnit:
            return @"ReadGlucoseUnit";
        case ReadHardwareBoardId:
            return @"ReadHardwareBoardId";
        case ReadLanguage:
            return @"ReadLanguage";
        case ReadRTC:
            return @"ReadRTC";
        case ReadSetUpWizardState:
            return @"ReadSetUpWizardState";
        case ReadSystemTime:
            return @"ReadSystemTime";
        case ReadSystemTimeOffset:
            return @"ReadSystemTimeOffset";
        case ReadTransmitterID:
            return @"ReadTransmitterID";
        case ReceiverError:
            return @"ReceiverError";
        case ResetReceiver:
            return @"ResetReceiver";
        case ShutdownReceiver:
            return @"ShutdownReceiver";
        case WriteBlindedMode:
            return @"WriteBlindedMode";
        case WriteClockMode:
            return @"WriteClockMode";
        case WriteDisplayTimeOffset:
            return @"WriteDisplayTimeOffset";
        case WriteEnableSetUpWizardFlag:
            return @"WriteEnableSetUpWizardFlag";
        case WriteFlashPage:
            return @"WriteFlashPage";
        case WriteGlucoseUnit:
            return @"WriteGlucoseUnit";
        case WriteLanguage:
            return @"WriteLanguage";
        case WritePCParameters:
            return @"WritePCParameters";
        case WriteSetUpWizardState:
            return @"WriteSetUpWizardState";
        case WriteSystemTime:
            return @"WriteSystemTime";
        case WriteTransmitterID:
            return @"WriteTransmitterID";
    }
    return UNKNOWN;
}

+ (NSString *)recordTypeIdentifier:(RecordType)recordType {
    switch (recordType) {
        case Aberration:
            return @"Aberration";
        case CalSet:
            return @"CalSet";
        case EGVData:
            return @"EGVData";
        case FirmwareParameterData:
            return @"FirmwareParameterData";
        case InsertionTime:
            return @"InsertionTime";
        case ManufacturingData:
            return @"ManufacturingData";
        case MaxValue:
            return @"MaxValue";
        case MeterData:
            return @"MeterData";
        case PCSoftwareParameter:
            return @"PCSoftwareParameter";
        case ReceiverErrorData:
            return @"ReceiverErrorData";
        case ReceiverLogData:
            return @"ReceiverLogData";
        case SensorData:
            return @"SensorData";
        case UserEventData:
            return @"UserEventData";
        case UserSettingData:
            return @"UserSettingData";
    }

    return UNKNOWN;
}

+ (NSString *)userEventTypeIdentifier:(UserEventType)userEventType {
    switch (userEventType) {
        case Carbs:
            return @"Carbs";
        case Exercise:
            return @"Exercise";
        case Health:
            return @"Health";
        case Insulin:
            return @"Insulin";
        case UEMaxValue:
            return @"MaxValue";
        case NullType:
            return @"Null";
        default:
            return UNKNOWN;
    }
}

+ (NSString *)exerciseEventSubTypeIdentifier:(ExerciseEventSubType)exerciseEventSubType {
    switch (exerciseEventSubType) {
        case Light:
            return @"Light";
        case Medium:
            return @"Medium";
        case Heavy:
            return @"Heavy";
        default:
            return UNKNOWN;
    }
}

+ (NSString *)healthEventSubTypeIdentifier:(HealthEventSubType)healthEventSubType {
    switch (healthEventSubType) {
        case Alcohol:
            return @"Alcohol";
        case Cycle:
            return @"Cycle";
        case HighSymptoms:
            return @"HighSymptoms";
        case Illness:
            return @"Illness";
        case LowSymptoms:
            return @"LowSymptoms";
        case Stress:
            return @"Stress";
        default:
            return UNKNOWN;
    }
}

+ (NSString *)subEventIdentifier:(UserEventType)userEventType subEventType:(Byte)subEventType {
    switch (userEventType) {
        case Exercise:
            return [self exerciseEventSubTypeIdentifier:(ExerciseEventSubType) subEventType];
        case Health:
            return [self healthEventSubTypeIdentifier:(HealthEventSubType) subEventType];
        default:
            return UNKNOWN;
    }
}

+ (NSString *)glucoseUnitIdentifier:(GlucoseUnit)glucoseUnit {
    switch (glucoseUnit) {
        case mgPerDL:
            return @"mg/dL";
        case mmolPerL:
            return @"mmol/L";
        default:
            return UNKNOWN;
    }
}

+ (NSDate *)dateTimeFromSecondsSinceDexcomEpoch:(uint32_t)secondsSinceDexcomEpoch {
    return [[NSDate alloc] initWithTimeInterval:secondsSinceDexcomEpoch sinceDate:[Types dexcomEpoch]];
}

+ (NSTimeZone *)timezoneFromLocalTime:(NSDate *)localTime andInternalTime:(NSDate *)internalTime {
    NSTimeInterval offset = [localTime timeIntervalSinceDate:internalTime];
    NSUInteger offsetInSeconds = (NSUInteger) (round((offset / TIMEZONE_GRANULARITY_IN_SECONDS)) * TIMEZONE_GRANULARITY_IN_SECONDS);
    return [NSTimeZone timeZoneForSecondsFromGMT:offsetInSeconds];
}

+ (NSTimeZone *)timezoneFromOffsetInSeconds:(int32_t)offset {
    NSTimeInterval offsetInterval = (double) offset;
    NSUInteger offsetInSeconds = (NSUInteger) (round((offsetInterval / TIMEZONE_GRANULARITY_IN_SECONDS)) * TIMEZONE_GRANULARITY_IN_SECONDS);
    return [NSTimeZone timeZoneForSecondsFromGMT:offsetInSeconds];
}

+ (NSDate *)dexcomEpoch {
    if (DEXCOM_EPOCH == nil) {
        DEXCOM_EPOCH = [NSCalendarDate dateWithTimeIntervalSince1970:1230793200];
    }
    return DEXCOM_EPOCH;
}

+ (NSString *)dexcomUintToString:(uint32_t) value {
    if (value == NOT_AVAILABLE) {
        return @"Not available";
    } else {
        return [NSString stringWithFormat:@"%u", value];
    }
}

@end