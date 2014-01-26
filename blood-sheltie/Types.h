//
// Created by Alexandre Normand on 1/8/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import <Foundation/Foundation.h>


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

@interface Types : NSObject
+(NSString *) receiverCommandIdentifier:(ReceiverCommand) command;
+(NSString *) recordTypeIdentifier:(RecordType) recordType;

@end