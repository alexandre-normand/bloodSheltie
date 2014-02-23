//
//  SyncTagTests.m
//  blood-sheltie
//
//  Created by Alexandre Normand on 2/22/2014.
//  Copyright (c) 2014 glukit. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Mantle/MTLJSONAdapter.h>
#import "RecordSyncTag.h"
#import "SyncTag.h"
#import "EncodingUtils.h"

@interface SyncTagTests : XCTestCase

@end

@implementation SyncTagTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRecordSyncSerializationDeserializationShouldBeSymetric
{
    RecordSyncTag *tag = [RecordSyncTag tagWithRecordNumber:@10 pageNumber:@20];
    NSDictionary *jsonDictionary = [MTLJSONAdapter JSONDictionaryFromModel:tag];

    NSError *error = nil;
    RecordSyncTag *deserialized = [MTLJSONAdapter modelOfClass:RecordSyncTag.class fromJSONDictionary:jsonDictionary error:&error];

    XCTAssertEqualObjects(deserialized, tag);
}

- (void)testSyncTagSerializationDeserializationShouldBeSymetric
{
    RecordSyncTag *lastCalibration = [RecordSyncTag tagWithRecordNumber:@10 pageNumber:@20];
    RecordSyncTag *lastGlucoseRead = [RecordSyncTag tagWithRecordNumber:@30 pageNumber:@40];
    RecordSyncTag *lastUserEvent = [RecordSyncTag tagWithRecordNumber:@50 pageNumber:@60];
    SyncTag *tag = [SyncTag tagWithLastGlucoseRead:lastGlucoseRead lastUserEvent:lastUserEvent lastCalibrationRead:lastCalibration];
    NSDictionary *jsonDictionary = [MTLJSONAdapter JSONDictionaryFromModel:tag];

    NSError *error = nil;
    NSString *serializedTag = [EncodingUtils dictionaryToJSON:jsonDictionary error:&error];
    XCTAssertNil(error);

    NSLog(@"Serialized tag is [%@]", serializedTag);
    NSDictionary *jsonDeserializedDictionary = [EncodingUtils stringToJsonDictionary:serializedTag error:&error];
    SyncTag *deserialized = [MTLJSONAdapter modelOfClass:SyncTag.class fromJSONDictionary:jsonDeserializedDictionary error:&error];

    XCTAssertEqualObjects(deserialized, tag);
}

@end
