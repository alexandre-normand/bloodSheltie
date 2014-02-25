#import "SyncManager.h"

int main( int argc, const char *argv[] ) {
    SyncManager *controller = [[SyncManager alloc] init];

    [controller start];
    CFRunLoopRun();
    SyncTag *syncTag = [controller stop];
    NSLog(@"Sync tag state is [%@]", syncTag);
    return 0;
}

