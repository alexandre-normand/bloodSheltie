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
#import <IOKit/IOCFPlugIn.h>

#define kMyVendorID			0x22a3
#define kMyProductID		0x47

typedef struct MyPrivateData {
    io_object_t				notification;
    IOUSBDeviceInterface	**deviceInterface;
    CFStringRef				deviceName;
    UInt32					locationID;

} MyPrivateData;


@implementation BloodSheltie
IONotificationPortRef	notificationPort;

void deviceAdded(void *refCon, io_iterator_t iterator)
{
    kern_return_t		kr;
    io_service_t		usbDevice;
    IOCFPlugInInterface	**plugInInterface = NULL;
    SInt32				score;
    HRESULT 			res;
    
    while ((usbDevice = IOIteratorNext(iterator))) {
        io_name_t		deviceName;
        CFStringRef		deviceNameAsCFString;
        MyPrivateData	*privateDataRef = NULL;
        UInt32			locationID;
        
        printf("Device added.\n");
        
        // Add some app-specific information about this device.
        // Create a buffer to hold the data.
        privateDataRef = malloc(sizeof(MyPrivateData));
        bzero(privateDataRef, sizeof(MyPrivateData));
        
        // Get the USB device's name.
        kr = IORegistryEntryGetName(usbDevice, deviceName);
		if (KERN_SUCCESS != kr) {
            deviceName[0] = '\0';
        }
        
        deviceNameAsCFString = CFStringCreateWithCString(kCFAllocatorDefault, deviceName,
                                                         kCFStringEncodingASCII);
        
        // Dump our data to stderr just to see what it looks like.
        fprintf(stderr, "deviceName: ");
        CFShow(deviceNameAsCFString);
        
        // Save the device's name to our private data.
        privateDataRef->deviceName = deviceNameAsCFString;
        
        // Now, get the locationID of this device. In order to do this, we need to create an IOUSBDeviceInterface
        // for our device. This will create the necessary connections between our userland application and the
        // kernel object for the USB Device.
        kr = IOCreatePlugInInterfaceForService(usbDevice, kIOUSBDeviceUserClientTypeID, kIOCFPlugInInterfaceID,
                                               &plugInInterface, &score);
        
        if ((kIOReturnSuccess != kr) || !plugInInterface) {
            fprintf(stderr, "IOCreatePlugInInterfaceForService returned 0x%08x.\n", kr);
            continue;
        }
        
        // Use the plugin interface to retrieve the device interface.
        res = (*plugInInterface)->QueryInterface(plugInInterface, CFUUIDGetUUIDBytes(kIOUSBDeviceInterfaceID),
                                                 (LPVOID*) &privateDataRef->deviceInterface);
        
        // Now done with the plugin interface.
        (*plugInInterface)->Release(plugInInterface);
        
        if (res || privateDataRef->deviceInterface == NULL) {
            fprintf(stderr, "QueryInterface returned %d.\n", (int) res);
            continue;
        }
        
        // Now that we have the IOUSBDeviceInterface, we can call the routines in IOUSBLib.h.
        // In this case, fetch the locationID. The locationID uniquely identifies the device
        // and will remain the same, even across reboots, so long as the bus topology doesn't change.
        
        kr = (*privateDataRef->deviceInterface)->GetLocationID(privateDataRef->deviceInterface, &locationID);
        if (KERN_SUCCESS != kr) {
            fprintf(stderr, "GetLocationID returned 0x%08x.\n", kr);
            continue;
        }
        else {
            fprintf(stderr, "Location ID: 0x%x\n\n", (unsigned int)locationID);
        }
        
        privateDataRef->locationID = locationID;
        
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
        
        // Done with this USB device; release the reference added by IOIteratorNext
        kr = IOObjectRelease(usbDevice);
    }
}


- (CFMutableDictionaryRef)buildDictionaryForDeviceIdAndVendor:(long *)usbVendor_p usbProduct_p:(long *)usbProduct_p {
    /* set up a matching dictionary for the class */
    CFNumberRef numberRef;
    CFMutableDictionaryRef deviceMatchDictionary;
    deviceMatchDictionary = IOServiceMatching(kIOUSBDeviceClassName);
    if (deviceMatchDictionary == NULL)
    {
        return nil; // fail
    }
    
    // Create a CFNumber for the idVendor and set the value in the dictionary
    numberRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &(*usbVendor_p));
    CFDictionarySetValue(deviceMatchDictionary,
                         CFSTR(kUSBVendorID),
                         numberRef);
    CFRelease(numberRef);
    
    // Create a CFNumber for the idProduct and set the value in the dictionary
    numberRef = CFNumberCreate(kCFAllocatorDefault, kCFNumberSInt32Type, &(*usbProduct_p));
    CFDictionarySetValue(deviceMatchDictionary,
                         CFSTR(kUSBProductID),
                         numberRef);
    CFRelease(numberRef);
    numberRef = NULL;
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
                                          deviceAdded,					// callback
                                          NULL,							// refCon
                                          &deviceIterator					// notification
                                          );
    
    // Iterate once to get already-present devices and arm the notification
    deviceAdded(NULL, deviceIterator);

    // Start the run loop. Now we'll receive notifications.
    fprintf(stderr, "Starting run loop.\n\n");
    CFRunLoopRun();

    
    return ;
}
@end
