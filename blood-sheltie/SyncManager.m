#import "SyncManager.h"
#import "ReceiverRequest.h"
#import "FreshDataFetcher.h"
#import "ORSSerialPortManager.h"

static const NSString *DEXCOM_PRODUCT_NAME = @"DexCom Gen4 USB Serial";

@implementation SyncManager {
    FreshDataFetcher *fetcher;
}

- (void)start {
    ORSSerialPortManager *portManager = [ORSSerialPortManager sharedSerialPortManager];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(serialPortsWereConnected:) name:ORSSerialPortsWereConnectedNotification object:nil];
    [nc addObserver:self selector:@selector(serialPortsWereDisconnected:) name:ORSSerialPortsWereDisconnectedNotification object:nil];

    NSArray *connectedPorts = [portManager availablePorts];
    [self notifyObserversIfReceiverConnected:connectedPorts];
}

#pragma mark - Notifications

- (void)serialPortsWereConnected:(NSNotification *)notification
{
    NSArray *connectedPorts = [[notification userInfo] objectForKey:ORSConnectedSerialPortsKey];
    NSLog(@"Ports were connected: %@", connectedPorts);

    // Wait 1 second for the usb device to fully connect in order for it to register correctly
    // and allow it to be detected
    // TODO find a better way to wait than sleep
    [NSThread sleepForTimeInterval:1];

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

        [self runSync:event];
    }
}

- (void)runSync:(ReceiverEvent *)event {
    NSLog(@"Receiver plugged %s", [event.devicePath UTF8String]);
    fetcher = [[FreshDataFetcher alloc] initWithSerialPortPath:event.devicePath since:[NSDate dateWithTimeIntervalSince1970:0]];
    [fetcher run];
}

- (ORSSerialPort *)findReceiver:(NSArray *)connectedPorts {
    for (ORSSerialPort *port in connectedPorts) {
        io_registry_entry_t parent;
        io_object_t device = [port IOKitDevice];
        kern_return_t kr = IORegistryEntryGetParentEntry(device, kIOServicePlane, &parent);

        if (kr == KERN_SUCCESS) {
            CFStringRef	productNameAsCFString = IORegistryEntryCreateCFProperty(parent,
                    CFSTR("Product Name"),
                    kCFAllocatorDefault,
                    0);
            NSString *productName = (__bridge NSString *) productNameAsCFString;

            NSLog(@"Looking at product name: [%@]", productNameAsCFString);

            if (![DEXCOM_PRODUCT_NAME isEqual:productName]) {
                NSLog(@"Skipping non-matching device [%s]", [[port path] UTF8String]);
            } else {
                NSLog(@"Matching device found: [%s]", [[port path] UTF8String]);
                return port;
            }
        } else {
            NSLog(@"Skipping non-matching device [%s]", [[port path] UTF8String]);
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