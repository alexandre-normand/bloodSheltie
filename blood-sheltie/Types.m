//
// Created by Alexandre Normand on 1/8/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import "Types.h"


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
    return @"unknown";
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

    return @"unknown";
}


@end