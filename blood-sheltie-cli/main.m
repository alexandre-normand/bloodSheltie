#import "SyncManager.h"

int main( int argc, const char *argv[] ) {
    SyncManager *controller = [[SyncManager alloc] init];

    [controller start];
    CFRunLoopRun();

    return 0;
}

