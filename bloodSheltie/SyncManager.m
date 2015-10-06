#import "SyncManager.h"
#import "FreshDataFetcher.h"
#import <ORSSerialPort/ORSSerialPortManager.h>

static const NSString *DEXCOM_PRODUCT_NAME = @"DexCom Gen4 USB Serial";

@implementation SyncManager {
    FreshDataFetcher *fetcher;
    NSMutableDictionary *productNameCache;
    SyncTag *currentSyncTag;
}
- (id)init {
    self = [super init];
    if (self) {
        productNameCache = [[NSMutableDictionary alloc] init];
        observers = [[NSMutableArray alloc] init];
        since = [Types dexcomEpoch];
    }

    return self;
}

- (void)start:(SyncTag *)syncTag {
    currentSyncTag = syncTag;

    ORSSerialPortManager *portManager = [ORSSerialPortManager sharedSerialPortManager];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(serialPortsWereConnected:) name:ORSSerialPortsWereConnectedNotification object:nil];
    [nc addObserver:self selector:@selector(serialPortsWereDisconnected:) name:ORSSerialPortsWereDisconnectedNotification object:nil];

    NSArray *connectedPorts = [portManager availablePorts];
    ORSSerialPort *port = [self findReceiver:connectedPorts];
    [self handleDeviceFound:port];
}

- (void)handleDeviceFound:(ORSSerialPort *)port {
    if (port != nil) {
        [self notifyObserversReceiverConnected:port];
        [self runSync:port];
    }
}

- (SyncTag *)stop {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSArray *ports = [[ORSSerialPortManager sharedSerialPortManager] availablePorts];
    for (ORSSerialPort *port in ports) {
        [port close];
    }

    return [fetcher getSyncTag];
}

#pragma mark - Notifications

- (void)serialPortsWereConnected:(NSNotification *)notification {
    NSArray *connectedPorts = [[notification userInfo] objectForKey:ORSConnectedSerialPortsKey];
    NSLog(@"Ports were connected: %@", connectedPorts);

    // Wait 1 second for the usb device to fully connect in order for it to register correctly
    // and allow it to be detected
    // TODO find a better way to wait for the parent's device to be connected than sleep
    [NSThread sleepForTimeInterval:1];

    ORSSerialPort *port = [self findReceiver:connectedPorts];
    [self handleDeviceFound:port];
}

- (void)serialPortsWereDisconnected:(NSNotification *)notification {
    NSArray *disconnectedPorts = [[notification userInfo] objectForKey:ORSDisconnectedSerialPortsKey];
    NSLog(@"Ports were disconnected: %@", disconnectedPorts);
    ORSSerialPort *port = [self findReceiver:disconnectedPorts];

    if (port != nil) {
        [self notifyObserversReceiverDisconnected:port];
    }
}

- (void)notifyObserversReceiverConnected:(ORSSerialPort *)port {
    ReceiverEvent *event = [[ReceiverEvent alloc] initWithPort:port];

    for (id observer in observers) {
        [observer receiverPlugged:event];
    }
}

- (void)notifyObserversReceiverDisconnected:(ORSSerialPort *)port {
    ReceiverEvent *event = [[ReceiverEvent alloc] initWithPort:port];

    for (id observer in observers) {
        [observer receiverUnplugged:event];
    }
}

- (void)runSync:(ORSSerialPort *)port {
    NSLog(@"Receiver plugged %s", [port.path UTF8String]);
    // Make sure we keep going on were we were if we had a previous sync done in the lifetime of this process
    if (fetcher != nil) {
        currentSyncTag = [fetcher getSyncTag];
    }

    fetcher = [[FreshDataFetcher alloc] initWithSerialPortPath:port.path syncTag:currentSyncTag since:since];
    // Register observers transitively
    for (id observer in observers) {
        [fetcher registerObserver:observer];
    }
    [fetcher run];
}

- (ORSSerialPort *)findReceiver:(NSArray *)connectedPorts {
    for (ORSSerialPort *port in connectedPorts) {
        NSString *productName = [self getProductName:port];

        if (![DEXCOM_PRODUCT_NAME isEqual:productName]) {
            NSLog(@"Skipping non-matching device [%s]", [[port path] UTF8String]);
            return nil;
        } else {
            NSLog(@"Matching device found: [%s]", [[port path] UTF8String]);
            return port;
        }
    }

    return nil;
}

- (NSString *)getProductName:(ORSSerialPort *)port {
    NSString *productName = [productNameCache objectForKey:[port path]];
    if (productName == nil) {
        io_registry_entry_t parent;
        io_object_t device = [port IOKitDevice];
        kern_return_t kr = IORegistryEntryGetParentEntry(device, kIOServicePlane, &parent);

        if (kr == KERN_SUCCESS) {
            CFStringRef productNameAsCFString = IORegistryEntryCreateCFProperty(parent,
                    CFSTR("Product Name"),
                    kCFAllocatorDefault,
                    0);
            kr = IOObjectRelease(parent);
            NSLog(@"Released parent with result [%d]", kr);

            if (productNameAsCFString) {
                productName = (__bridge NSString *) productNameAsCFString;
                NSLog(@"Caching product name [%s] for [%s]", [productName UTF8String], [[port path] UTF8String]);
                if (productName != nil) {
                    [productNameCache setObject:productName forKey:[port path]];
                }

                CFRelease(productNameAsCFString);
            }

            return productName;
        } else {
            NSLog(@"Failed to get parent's device [0x%08x] to find its product name: [%s]", kr,
                    [[port path] UTF8String]);
        }

    }

    return productName;
}

- (void)registerEventListener:(id <SyncEventObserver>)observer {
    [observers addObject:observer];
    if (fetcher != nil) {
        [fetcher registerObserver:observer];
    }
}

- (void)unregisterEventListener:(id <SyncEventObserver>)observer {
    [observers removeObject:observer];
    if (fetcher != nil) {
        [fetcher unregisterObserver:observer];
    }
}


@end