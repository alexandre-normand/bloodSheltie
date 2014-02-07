#import "blood_sheltie.h"
#import "ORSSerialPortManager.h"
#import "ORSSerialPort.h"

#import <IOKit/IOKitLib.h>
#import <IOKit/usb/IOUSBLib.h>
#import <IOKit/serial/IOSerialKeys.h>
#import <IOKit/serial/ioss.h>
#import <IOKit/IOCFPlugIn.h>
#import <IOKit/IOKitKeys.h>

#define kMyVendorID			0x22a3
#define kMyProductID		0x47
#define DEXCOM_PRODUCT_NAME "DexCom Gen4 USB Serial"

@implementation BloodSheltie
IONotificationPortRef	notificationPort;


-(BloodSheltie*) init {
    self = [super init];
    
    if (self) {
        observers = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) listen {

    ORSSerialPortManager *portManager = [ORSSerialPortManager sharedSerialPortManager];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(serialPortsWereConnected:) name:ORSSerialPortsWereConnectedNotification object:nil];
    [nc addObserver:self selector:@selector(serialPortsWereDisconnected:) name:ORSSerialPortsWereDisconnectedNotification object:nil];

    NSArray *connectedPorts = [portManager availablePorts];
    ORSSerialPort *port = [self findReceiver:connectedPorts];
    [self notifyObserversIfReceiverConnected:connectedPorts];

    // Start the run loop. Now we'll receive notifications.
    fprintf(stderr, "Starting run loop.\n\n");
    CFRunLoopRun();
    
    return ;
}

#pragma mark - Notifications

- (void)serialPortsWereConnected:(NSNotification *)notification
{
    NSArray *connectedPorts = [[notification userInfo] objectForKey:ORSConnectedSerialPortsKey];
    NSLog(@"Ports were connected: %@", connectedPorts);

    [self notifyObserversIfReceiverConnected:connectedPorts];
}

- (void)notifyObserversIfReceiverConnected:(NSArray *)connectedPorts {
    ORSSerialPort *port = [self findReceiver:connectedPorts];
    if (port != nil) {
        ReceiverEvent *event = [[ReceiverEvent alloc] init];
        [event setDevicePath: port.path];

        for (id observer in observers) {
            [observer receiverPlugged: event];
        }
    }
}

- (ORSSerialPort *)findReceiver:(NSArray *)connectedPorts {
    for (ORSSerialPort *port in connectedPorts) {
        if ([[port path] rangeOfString:@"modem"].location == NSNotFound) {
            NSLog(@"Skipping non-matching device [%s]", [[port path] UTF8String]);
        } else {
            NSLog(@"Matching device found: [%s]", [[port path] UTF8String]);
            return port;
        }        
    }

    return nil;
}

- (void)serialPortsWereDisconnected:(NSNotification *)notification
{
    NSArray *disconnectedPorts = [[notification userInfo] objectForKey:ORSDisconnectedSerialPortsKey];
    NSLog(@"Ports were disconnected: %@", disconnectedPorts);

}

-(void) registerEventListener:(id<DeviceObserver>) observer {
    [observers addObject: observer];
}


@end
