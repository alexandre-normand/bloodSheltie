//The MIT License (MIT)
//
//Copyright (c) 2014 Alexandre Normand
//
//Permission is hereby granted, free of charge, to any person obtaining a copy of
//this software and associated documentation files (the "Software"), to deal in
//the Software without restriction, including without limitation the rights to
//use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//the Software, and to permit persons to whom the Software is furnished to do so,
//subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "ManufacturingParameters.h"


@implementation ManufacturingParameters {

}
- (instancetype)initWithSerialNumber:(NSString *)serialNumber hardwarePartNumber:(NSString *)hardwarePartNumber hardwareRevision:(NSString *)hardwareRevision dateTimeCreated:(NSString *)dateTimeCreated hardwareId:(NSString *)hardwareId {
    self = [super init];
    if (self) {
        _serialNumber = serialNumber;
        _hardwarePartNumber=hardwarePartNumber;
        _hardwareRevision=hardwareRevision;
        _dateTimeCreated=dateTimeCreated;
        _hardwareId=hardwareId;
    }

    return self;
}

+ (instancetype)dataWithSerialNumber:(NSString *)serialNumber hardwarePartNumber:(NSString *)hardwarePartNumber hardwareRevision:(NSString *)hardwareRevision dateTimeCreated:(NSString *)dateTimeCreated hardwareId:(NSString *)hardwareId {
    return [[self alloc] initWithSerialNumber:serialNumber hardwarePartNumber:hardwarePartNumber hardwareRevision:hardwareRevision dateTimeCreated:dateTimeCreated hardwareId:hardwareId];
}

- (NSString *)description {
    return [NSString stringWithFormat: @"[ManufacturingParameters] serialNumber=[%s] hardwarePartNumber=[%s] hardwareRevision=[%s] dateTimeCreated=[%s] hardwareId=[%s]",
                    [_serialNumber UTF8String], [_hardwarePartNumber UTF8String], [_hardwareRevision UTF8String], [_dateTimeCreated UTF8String], [_hardwareId UTF8String]];
}
@end