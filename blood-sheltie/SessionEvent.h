//
// Created by Alexandre Normand on 1/24/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SessionData;


@interface SessionEvent : NSObject
@property(readonly) NSString *devicePath;
@property(readonly) SessionData *sessionData;
@end