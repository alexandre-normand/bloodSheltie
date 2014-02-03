#import "blood_sheltie.h"
#import "SessionController.h"

int main( int argc, const char *argv[] ) {
    SessionController *controller = [[SessionController alloc] init];
    BloodSheltie *blood_sheltie = [[BloodSheltie alloc] init];

    [blood_sheltie registerEventListener:controller];
    
    // set the values
    [blood_sheltie listen];
    
    return 0;
}

