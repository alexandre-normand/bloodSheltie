//The MIT License (MIT)
//
//Copyright (c) 2013 Alexandre Normand
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
//
//  Created by Alexandre Normand on 10/31/2013.

#import <stdio.h>
#import "blood_sheltie.h"
#import "EventLogger.h"
#import "SessionController.h"
#import "DefaultEncoder.h"
#import "ReadDatabasePageRangeRequest.h"
#import "EncodingUtils.h"

int main( int argc, const char *argv[] ) {
    // create a new instance
    SessionController *delegate = [[SessionController alloc] init];
    BloodSheltie *blood_sheltie = [[BloodSheltie alloc] init];
    
    EventLogger *eventLogger = [[EventLogger alloc] initWithSessionController:delegate];
    [blood_sheltie registerEventListener:eventLogger];
    
    // set the values
    [blood_sheltie listen];
    
    return 0;
}

