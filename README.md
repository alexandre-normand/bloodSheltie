blood-sheltie
=============

This is a remake of [blood-shepherd](https://github.com/alexandre-normand/blood-shepher), a sync api and rough client to extract data from the [Dexcom Platinum G4](http://dexcom.com/dexcom-g4-platinum) receiver.

This is a Objective-C library meant to support applications that would want to consume Dexcom data and do something useful in some way. 

As of February 25th, 2014, I consider this functionally usable. It could use some bootstrapping/packaging/documentation but I might get to it when someone expresses an interest. Open issues or get in touch with me on twitter at @alex_normand.

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

TODO
----
 * Add support for `mmol/dL`.
 * Parse numeric user event values appropriately. Specifically, insulin values should be parsed as decimals.
 
License
-------
This projected is licensed under the terms of the [MIT license](LICENSE.md). 
