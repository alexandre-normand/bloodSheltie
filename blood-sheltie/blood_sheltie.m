//The MIT License (MIT)
//
//Copyright (c) 2013 Alexandre Normand
//
//Permission is hereby granted, free of charge, to any person obtaining a copy of
//this software and associated documentation files (the "Software"), to deal in
//the Software without restriction, including without limitation the rights to
//use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//the Software, and to permit persons to whom the Software is furnished to do so,
//subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//  Created by Alexandre Normand on 10/29/2013.

#import "blood_sheltie.h"

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

-(void) deviceDetected: (io_iterator_t) iterator
{
    kern_return_t		kr;
    io_service_t		device;
//    IOCFPlugInInterface	**plugInInterface = NULL;
//    SInt32				score;
//    HRESULT 			res;
    bool                deviceFound = false;
    
    while ((device = IOIteratorNext(iterator)) && !deviceFound) {
        io_name_t		deviceName;
        CFStringRef		deviceNameAsCFString;
        CFStringRef		productNameAsCFString;
        CFTypeRef       bsdPathAsCFString;
        //        UInt32			locationID;
        io_registry_entry_t child;
        uint64_t deviceId;
        
        
        printf("Device added.\n");
        // Get the USB device's name.
        kr = IORegistryEntryGetName(device, deviceName);
        if (KERN_SUCCESS != kr) {
            deviceName[0] = '\0';
        }        
       
        deviceNameAsCFString = CFStringCreateWithCString(kCFAllocatorDefault, deviceName,
                                                         kCFStringEncodingASCII);
        // Dump our data to stderr just to see what it looks like.
        fprintf(stderr, "deviceName: ");
        CFShow(deviceNameAsCFString);
        
        kr = IORegistryEntryGetRegistryEntryID(device, &deviceId);
        if (KERN_SUCCESS == kr) {
            fprintf(stderr, "deviceId: %llu\n", deviceId);
        }

        productNameAsCFString = IORegistryEntryCreateCFProperty(device,
                                                                CFSTR("Product Name"),
                                                                kCFAllocatorDefault,
                                                                0);
        if (productNameAsCFString) {
            char productName[256];
            CFStringGetCString(productNameAsCFString, productName, sizeof(productName), kCFStringEncodingUTF8);
            
            fprintf(stdout, "Product found: %s\n", productName);
            CFRelease(productNameAsCFString);
            
            if (strncmp(productName, DEXCOM_PRODUCT_NAME, strlen(DEXCOM_PRODUCT_NAME)) == 0) {
                fprintf(stderr, "Found a match for dexcom\n");
                kr = IORegistryEntryGetChildEntry(device, kIOServicePlane, &child);
                if (KERN_SUCCESS != kr) {
                    fprintf(stderr, "GetParentEntry returned 0x%08x.\n", kr);
                    continue;
                } else {
                    bsdPathAsCFString = IORegistryEntryCreateCFProperty(child,
                                                                        CFSTR(kIOCalloutDeviceKey),
                                                                        kCFAllocatorDefault,
                                                                        0);
                    char bsdPath[256];
                    if (bsdPathAsCFString) {
                        Boolean result = true;
                        
                        // Convert the path from a CFString to a C (NUL-terminated) string for use
                        // with the POSIX open() call.
                        
                        result = CFStringGetCString(bsdPathAsCFString,
                                                    bsdPath,
                                                    sizeof(bsdPath),
                                                    kCFStringEncodingUTF8);
                        CFRelease(bsdPathAsCFString);
                        
                        if (result) {
                            printf("Modem found with BSD path: %s\n", bsdPath);
                            deviceFound = true;
                            ReceiverEvent *event = [[ReceiverEvent alloc] init];
                            NSString *pathAsNsString =
                                    [NSString stringWithCString:bsdPath encoding:NSASCIIStringEncoding];

                            [event setDevicePath: pathAsNsString];

                            for (id observer in observers) {                                
                                [observer receiverPlugged: event];
                            }
                            
                            // Now, get the locationID of this device. In order to do this, we need to create an IOUSBDeviceInterface
                            // for our device. This will create the necessary connections between our userland application and the
                            // kernel object for the USB Device.
//                            kr = IOCreatePlugInInterfaceForService(device, kIOUSBDeviceUserClientTypeID, kIOCFPlugInInterfaceID,
//                                                                   &plugInInterface, &score);
//                            
//                            if ((kIOReturnSuccess != kr) || !plugInInterface) {
//                                fprintf(stderr, "IOCreatePlugInInterfaceForService returned 0x%08x.\n", kr);
//                                continue;
//                            }
//                            
//                            // Use the plugin interface to retrieve the device interface.
//                            res = (*plugInInterface)->QueryInterface(plugInInterface, CFUUIDGetUUIDBytes(kIOUSBDeviceInterfaceID),
//                                                                     (LPVOID*) &privateDataRef->deviceInterface);
//                            
//                            // Now done with the plugin interface.
//                            (*plugInInterface)->Release(plugInInterface);
//                            
//                            if (res || privateDataRef->deviceInterface == NULL) {
//                                fprintf(stderr, "QueryInterface returned %d.\n", (int) res);
//                                continue;
//                            }
//                            
//                            // Now that we have the IOUSBDeviceInterface, we can call the routines in IOUSBLib.h.
//                            // In this case, fetch the locationID. The locationID uniquely identifies the device
//                            // and will remain the same, even across reboots, so long as the bus topology doesn't change.
//                            
//                            kr = (*privateDataRef->deviceInterface)->GetLocationID(privateDataRef->deviceInterface, &locationID);
//                            if (KERN_SUCCESS != kr) {
//                                fprintf(stderr, "GetLocationID returned 0x%08x.\n", kr);
//                                continue;
//                            }
//                            else {
//                                fprintf(stderr, "Location ID: 0x%x\n\n", (unsigned int)locationID);
//                            }
//                            
//                            privateDataRef->locationID = locationID;
                            
                            // Register for an interest notification of this device being removed. Use a reference to our
                            // private data as the refCon which will be passed to the notification callback.
                            //        kr = IOServiceAddInterestNotification(notificationPort,  				// notifyPort
                            //											  usbDevice,						// service
                            //											  kIOGeneralInterest,				// interestType
                            //											  DeviceNotification,				// callback
                            //											  privateDataRef,					// refCon
                            //											  &(privateDataRef->notification)	// notification
                            //											  );
                            //
                            //        if (KERN_SUCCESS != kr) {
                            //            printf("IOServiceAddInterestNotification returned 0x%08x.\n", kr);
                            //        }
                        }
                    }
                }
            }
            
            // Done with this USB device; release the reference added by IOIteratorNext
            kr = IOObjectRelease(device);
        }
    }
}

void receiverUnplugged(void *			refcon, io_service_t		service, uint32_t		messageType, void *			messageArgument ) {
    printf("Receiver unplugged");
}

- (CFMutableDictionaryRef)buildDictionaryForDeviceIdAndVendor:(long *)usbVendor_p usbProduct_p:(long *)usbProduct_p {
    /* set up a matching dictionary for the class */
    //    CFNumberRef numberRef;
    CFMutableDictionaryRef deviceMatchDictionary;
    deviceMatchDictionary = IOServiceMatching("IOModemSerialStreamSync");
    if (deviceMatchDictionary == NULL)
    {
        return nil; // fail
    }
    
    // Create a CFNumber for the idVendor and set the value in the dictionary
    //    numberRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &(*usbVendor_p));
    CFDictionarySetValue(deviceMatchDictionary,
                         CFSTR("Product Name"),
                         CFSTR(DEXCOM_PRODUCT_NAME));
    //CFRelease(numberRef);
    
    // Create a CFNumber for the idProduct and set the value in the dictionary
    //    numberRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &(*usbProduct_p));
    //    CFDictionarySetValue(deviceMatchDictionary,
    //                         CFSTR(kUSBProductID),
    //                         numberRef);
    //    CFRelease(numberRef);
    //    numberRef = NULL;
    return deviceMatchDictionary;
}

-(void) listen {
    CFMutableDictionaryRef deviceMatchDictionary;
    io_iterator_t deviceIterator;
    kern_return_t kernelReturn;
    long usbVendor = kMyVendorID;
    long usbProduct = kMyProductID;
    CFRunLoopSourceRef		runLoopSource;
    
    deviceMatchDictionary = [self buildDictionaryForDeviceIdAndVendor:&usbVendor usbProduct_p:&usbProduct];
    
    
    // Create a notification port and add its run loop event source to our run loop
    // This is how async notifications get set up.
    
    notificationPort = IONotificationPortCreate(kIOMasterPortDefault);
    runLoopSource = IONotificationPortGetRunLoopSource(notificationPort);
    
    // Add run-loop source to run-loop
    CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, kCFRunLoopDefaultMode);
    
    // Now set up a notification to be called when a device is first matched by I/O Kit.
    kernelReturn = IOServiceAddMatchingNotification(notificationPort,					// notifyPort
                                                    kIOFirstMatchNotification,	// notificationType
                                                    deviceMatchDictionary,					// matching
                                                    devicePlugged,					// callback
                                                    (__bridge void *) self,			// refCon
                                                    &deviceIterator					// notification
                                                    );
    if (KERN_SUCCESS != kernelReturn) {
        fprintf(stderr, "Error setting up notification for device.\n");
        exit(1);
    }
    
    // Iterate once to get already-present devices and arm the notification
    [self deviceDetected: deviceIterator];
    
    // Start the run loop. Now we'll receive notifications.
    fprintf(stderr, "Starting run loop.\n\n");
    CFRunLoopRun();
    
    
    return ;
}

-(void) registerEventListener:(id<ReceiverObserver>) observer {
    [observers addObject: observer];
}

void devicePlugged(void *refCon, io_iterator_t iterator) {
    BloodSheltie *mySelf = (__bridge BloodSheltie *) refCon;
    
    return [mySelf deviceDetected:iterator];
}

@end
