#import "SyncManager.h"
#import "SyncTag.h"
#import "LoggingObserver.h"

int main( int argc, const char *argv[] ) {
    SyncManager *syncManager = [[SyncManager alloc] init];

    // Register an observer to get notified of device events, including
    // the sync start/sync complete. The sync completion event includes
    // the InternalSyncData as well as the SyncTag that can be provided on
    // initialization to get only new data.
    [syncManager registerEventListener:[[LoggingObserver alloc] init]];
    [syncManager start:[SyncTag initialSyncTag]];

    CFRunLoopRun();
    SyncTag *syncTag = [syncManager stop];
    NSLog(@"Sync tag state is [%@]", syncTag);
    return 0;
}

