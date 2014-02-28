#import "LoggingObserver.h"
#import "SyncData.h"
#import "SyncCompletionEvent.h"


@implementation LoggingObserver {

}
- (void)syncStarted:(SyncEvent *)event {
    NSLog(@"Sync started on %@", event.port);
}

- (void)errorReadingReceiver:(SyncEvent *)event {
    NSLog(@"Error on %@", event.port);
}

- (void)syncProgress:(SyncEvent *)event {
    NSLog(@"Downloaded [%ld] calibrations, [%ld] glucoseReads, [%ld] userEvents",
            [event.sessionData.calibrationReads count],
            [event.sessionData.glucoseReads count],
            [event.sessionData.userEvents count]);
}

- (void)syncComplete:(SyncEvent *)event {
    SyncCompletionEvent *completionEvent = (SyncCompletionEvent *) event;
    NSLog(@"Finished sync. Got data [%ld] calibrations, [%ld] glucoseReads (unit = %s) and [%ld] userEvents. New sync tag is [%@]",
            [event.sessionData.calibrationReads count],
            [event.sessionData.glucoseReads count],
            [[Types glucoseUnitIdentifier:event.sessionData.glucoseUnit] UTF8String],
            [event.sessionData.userEvents count],
            [completionEvent syncTag]);
}

- (void)receiverPlugged:(ReceiverEvent *)event {
    NSLog(@"Received plugged in [%s]", [event.port.path UTF8String]);
}

- (void)receiverUnplugged:(ReceiverEvent *)event {
    NSLog(@"Received unplugged in [%s]", [event.port.path UTF8String]);
}

@end