bloodSheltie
============

This is a remake of [blood-shepherd](https://github.com/alexandre-normand/blood-shepher), a sync api to read data from the [Dexcom Platinum G4](http://dexcom.com/dexcom-g4-platinum) receiver.

This is a Objective-C library meant to support applications that would want to consume Dexcom data and do something useful in some way. Make it count. 

While no applications (besides the rough `bloodSheltie-cli` that just logs the data) have been written using it, it's new and I'm actually building the first user-facing application using `bloodSheltie`. Therefore, I consider it functionally usable at this time and I'll be filling the blanks if any as I build `Glukloader` on top of it. 

You are welcome to open issues or get in touch with me on twitter at [@alex_normand](https://twitter.com/alex_normand).

Supported data
--------------
* Glucose readings.
* Calibration values.
* User events: insulin, carbs, exercise, health.
* Manufacturing parameters (including serial number).

Usage 
-----
```
// Get the SyncManager
SyncManager *syncManager = [SyncManager instance];

// Register an observer to get notified of device events, including
// the sync start/sync complete. The sync completion event includes
// the SyncData as well as the SyncTag that can be provided on
// initialization to get only new data.
[syncManager registerEventListener:[[LoggingObserver alloc] init]];
[syncManager start:[SyncTag initialSyncTag]];
```

Your observer should be ready to handle the most important event that is `syncComplete`. The `SyncCompletionEvent` has 3 very important fields:
```
ORSSerialPort *port;
SyncTag *syncTag;
SyncData *syncData;
```
The `SyncData` holds all supported data fetched during the sync. It's best to look at [SyncData](bloodSheltie/SyncData.h) and the [models](bloodSheltie/model) for more details.

The `SyncTag` should be saved for future initialization of your application to resume fetching of new data at the last high watermark. `SyncTag` implements `NSCoding` but, if you want to do `json`, you can do something like 

Serialize to `JSON`:
```
RecordSyncTag *tag = [RecordSyncTag tagWithRecordNumber:@10 pageNumber:@12];
NSDictionary *JSONDictionary = [MTLJSONAdapter JSONDictionaryFromModel:tag];

NSError *error;
NSString *serializedTag = [EncodingUtils dictionaryToJSON:JSONDictionary error:&error];
``` 

Deserialize to `JSON`:
```
NSDictionary *deserializedDictionary = [EncodingUtils stringToJsonDictionary:serializedTag error:&error];
RecordSyncTag *deserializedTag = [MTLJSONAdapter modelOfClass:RecordSyncTag.class fromJSONDictionary:deserializedDictionary error:&error];
XCTAssertEqualObjects(deserializedTag, tag);
```
System Requirements
-------------------
bloodSheltie has been tested on Mac OS X 10.9 (Mavericks) but it might also run on prior versions of OS X. 

Getting started
---------------
To add bloodSheltie to your application:

1. Add the `bloodSheltie` repository as a submodule of your application's repository.
1. Run `script/bootstrap` from within the `bloodSheltie` folder.
1. Drag and drop `bloodSheltie.xcodeproj` into your application's Xcode project or workspace.
1. On the "Build Phases" tab of your application target, add `bloodSheltie` to the "Link Binary With Libraries" phase.
    * `bloodSheltie` must also be added to any "Copy Frameworks" build phase. If you don't already have one, simply add a "Copy Files" build phase and target the "Frameworks" destination.
1. Add `"$(BUILD_ROOT)/../IntermediateBuildFilesPath/UninstalledProducts/include" $(inherited)` to the "Header Search Paths" build setting (this is only necessary for archive builds, but it has no negative effect otherwise).
1. If you added `bloodSheltie` to a project (not a workspace), you will also need to add the appropriate `bloodSheltie` target to the "Target Dependencies" of your application.

TODO
----
* More tests.
* Support for more settings.
* Support for more data. 

License
-------
This projected is licensed under the terms of the [MIT license](LICENSE.md). 
