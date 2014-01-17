//
// Created by Alexandre Normand on 1/16/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ORSSerialPort.h"
#import "ReceiverResponse.h"

@interface ResponseReader : NSObject

-(ReceiverResponse *) readResponse:(ORSSerialPort *) port;
@end