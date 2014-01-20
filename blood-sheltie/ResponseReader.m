//
// Created by Alexandre Normand on 1/16/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import "ResponseReader.h"
#import "ORSSerialPort.h"
#import "DefaultDecoder.h"
#import "ReceiverResponse.h"


@implementation ResponseReader {

}
- (ReceiverResponse *)readResponse:(ORSSerialPort *)port {
    // Assumes the port is open and setup
    NSAssert(port != nil, @"Port can't be null");
    NSAssert(port.isOpen, @"Port should be open");
    //port.sessionController =
//    Byte *headerBytes = NULL;
    return NULL;
}

@end