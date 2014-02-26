#import "LoggingObserver.h"
#import "SyncData.h"


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
    NSLog(@"Finished sync. Got data [%@]", event.sessionData);
}

- (void)receiverPlugged:(ReceiverEvent *)event {
    NSLog(@"Received plugged in [%s]", [event.port.path UTF8String]);
}

- (void)receiverUnplugged:(ReceiverEvent *)event {
    NSLog(@"Received unplugged in [%s]", [event.port.path UTF8String]);
}

@end