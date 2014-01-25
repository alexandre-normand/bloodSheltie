//
// Created by Alexandre Normand on 1/24/2014.
// Copyright (c) 2014 glukit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SessionEvent.h"

@protocol SessionObserver <NSObject>
-(void) syncStarted: (SessionEvent *) event;
-(void) errorReadingReceiver: (SessionEvent *) event;
-(void) syncProgress: (SessionEvent* ) event;
-(void) syncComplete: (SessionEvent* ) event;
@end