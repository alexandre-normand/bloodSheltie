#import <CocoaLumberjack/CocoaLumberjack.h>
#import "LoggingObserver.h"
#import "SyncCompletionEvent.h"
#import "SyncProgressEvent.h"

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation LoggingObserver {
    
}
- (void)syncStarted:(SyncEvent *)event {
    DDLogDebug(@"Sync started on %@", event.port);
}

- (void)errorReadingReceiver:(SyncEvent *)event {
    DDLogDebug(@"Error on %@", event.port);
}

- (void)syncProgress:(SyncProgressEvent *)event {
    double percentageDone = event.totalPagesToFetch > 0 ? event.fetchedSoFar / (double) event.totalPagesToFetch * 100.f: 0;
    DDLogDebug(@"Downloaded %.2f%%: [%ld] calibrations, [%ld] glucoseReads, [%ld] injections, [%ld] carb intakes, [%ld] exercise events, [%ld] health events",
          percentageDone,
          [event.syncData.calibrationReads count],
          [event.syncData.glucoseReads count],
          [event.syncData.insulinInjections count],
          [event.syncData.foodEvents count],
          [event.syncData.exerciseEvents count],
          [event.syncData.healthEvents count]);
}

- (void)syncComplete:(SyncCompletionEvent *)event {
    DDLogDebug(@"Finished sync. Got data [%ld] calibrations, [%ld] glucoseReads, [%ld] injections, [%ld] carb intakes, [%ld] exercise events, [%ld] health events. New sync tag is [%@]",
          [event.syncData.calibrationReads count],
          [event.syncData.glucoseReads count],
          [event.syncData.insulinInjections count],
          [event.syncData.foodEvents count],
          [event.syncData.exerciseEvents count],
          [event.syncData.healthEvents count],
          [event syncTag]);
}

- (void)receiverPlugged:(ReceiverEvent *)event {
    DDLogDebug(@"Received plugged in [%s]", [event.port.path UTF8String]);
}

- (void)receiverUnplugged:(ReceiverEvent *)event {
    DDLogDebug(@"Received unplugged in [%s]", [event.port.path UTF8String]);
}

@end