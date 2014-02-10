#import "SessionController.h"

int main( int argc, const char *argv[] ) {
    SessionController *controller = [[SessionController alloc] init];

    [controller start];
    CFRunLoopRun();

    return 0;
}

