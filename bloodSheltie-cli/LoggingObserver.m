#import "LoggingObserver.h"
#import "SyncCompletionEvent.h"
#import "SyncProgressEvent.h"


@implementation LoggingObserver {

}
- (void)syncStarted:(SyncEvent *)event {
    NSLog(@"Sync started on %@", event.port);
}

- (void)errorReadingReceiver:(SyncEvent *)event {
    NSLog(@"Error on %@", event.port);
}

- (void)syncProgress:(SyncEvent *)event {
    SyncProgressEvent *progressEvent = (SyncProgressEvent *) event;
    double percentageDone = progressEvent.totalPagesToFetch > 0 ? progressEvent.fetchedSoFar / (double) progressEvent.totalPagesToFetch * 100.f: 0;
    NSLog(@"Downloaded %.2f%%: [%ld] calibrations, [%ld] glucoseReads, [%ld] injections, [%ld] carb intakes, [%ld] exercise events, [%ld] health events",
            percentageDone,
            [event.syncData.calibrationReads count],
            [event.syncData.glucoseReads count],
            [event.syncData.insulinInjections count],
            [event.syncData.foodEvents count],
            [event.syncData.exerciseEvents count],
            [event.syncData.healthEvents count]);
}

- (void)syncComplete:(SyncEvent *)event {
    SyncCompletionEvent *completionEvent = (SyncCompletionEvent *) event;
    NSLog(@"Finished sync. Got data [%ld] calibrations, [%ld] glucoseReads, [%ld] injections, [%ld] carb intakes, [%ld] exercise events, [%ld] health events. New sync tag is [%@]",
            [event.syncData.calibrationReads count],
            [event.syncData.glucoseReads count],
            [event.syncData.insulinInjections count],
            [event.syncData.foodEvents count],
            [event.syncData.exerciseEvents count],
            [event.syncData.healthEvents count],
            [completionEvent syncTag]);
}

- (void)receiverPlugged:(ReceiverEvent *)event {
    NSLog(@"Received plugged in [%s]", [event.port.path UTF8String]);
}

- (void)receiverUnplugged:(ReceiverEvent *)event {
    NSLog(@"Received unplugged in [%s]", [event.port.path UTF8String]);
}

@end