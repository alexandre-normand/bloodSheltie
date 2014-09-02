#import <XCTest/XCTest.h>
#import "GlucoseReadRecord.h"
#import "SyncUtils.h"

@interface SyncUtilsTests : XCTestCase

@end

@implementation SyncUtilsTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testSort
{
    NSMutableArray *records = [NSMutableArray array];
    [records addObject:[GlucoseReadRecord recordWithRawInternalTimeInSeconds:1500 rawDisplayTimeInSeconds:100 glucoseValue:50 trendArrowAndNoise:0 recordNumber:3 pageNumber:1 dexcomOffsetWithStandardInSeconds:0 timezone:[NSTimeZone timeZoneWithName:@"America/Montreal"]]];
    [records addObject:[GlucoseReadRecord recordWithRawInternalTimeInSeconds:0 rawDisplayTimeInSeconds:100 glucoseValue:60 trendArrowAndNoise:0 recordNumber:1 pageNumber:1 dexcomOffsetWithStandardInSeconds:0 timezone:[NSTimeZone timeZoneWithName:@"America/Montreal"]]];
    [records addObject:[GlucoseReadRecord recordWithRawInternalTimeInSeconds:800 rawDisplayTimeInSeconds:100 glucoseValue:83 trendArrowAndNoise:0 recordNumber:2 pageNumber:1 dexcomOffsetWithStandardInSeconds:0 timezone:[NSTimeZone timeZoneWithName:@"America/Montreal"]]];

    NSArray *sorted = [SyncUtils sortRecords:records];
    
    GenericRecord *oldest = sorted[0];
    XCTAssertEqual(oldest.recordNumber, 1u);
    GenericRecord *second = sorted[1];
    XCTAssertEqual(second.recordNumber, 2u);
    GenericRecord *mostRecent = sorted[2];
    XCTAssertEqual(mostRecent.recordNumber, 3u);
}

- (void)testGenerateRecordSyncTag
{
    NSMutableArray *records = [NSMutableArray array];
    [records addObject:[GlucoseReadRecord recordWithRawInternalTimeInSeconds:1500 rawDisplayTimeInSeconds:100 glucoseValue:50 trendArrowAndNoise:0 recordNumber:3 pageNumber:4 dexcomOffsetWithStandardInSeconds:0 timezone:[NSTimeZone timeZoneWithName:@"America/Montreal"]]];
    [records addObject:[GlucoseReadRecord recordWithRawInternalTimeInSeconds:0 rawDisplayTimeInSeconds:100 glucoseValue:60 trendArrowAndNoise:0 recordNumber:1 pageNumber:2 dexcomOffsetWithStandardInSeconds:0 timezone:[NSTimeZone timeZoneWithName:@"America/Montreal"]]];
    [records addObject:[GlucoseReadRecord recordWithRawInternalTimeInSeconds:800 rawDisplayTimeInSeconds:100 glucoseValue:83 trendArrowAndNoise:0 recordNumber:2 pageNumber:3 dexcomOffsetWithStandardInSeconds:0 timezone:[NSTimeZone timeZoneWithName:@"America/Montreal"]]];
    
    RecordSyncTag *tag = [SyncUtils generateRecordSyncTag:records previousSyncTag:[RecordSyncTag initialSyncTag]];
    
    XCTAssertEqualObjects(tag.recordNumber, @3);
    XCTAssertEqualObjects(tag.pageNumber, @4);
}

- (void)testRecordSyncTagWhenNoNewRecords
{
    NSMutableArray *records = [NSMutableArray array];
    
    RecordSyncTag *tag = [SyncUtils generateRecordSyncTag:records previousSyncTag:[RecordSyncTag initialSyncTag]];
    
    XCTAssertEqualObjects(tag, [RecordSyncTag initialSyncTag]);
}

-(void)testInitialSyncTagIsNotNil
{
    XCTAssertNotNil([SyncTag initialSyncTag]);
    XCTAssertNotNil([RecordSyncTag initialSyncTag]);
}

-(void)testInitialSyncTagIsMarkedAsSuch
{
    SyncTag *initialSyncTag = [SyncTag initialSyncTag];
    XCTAssertTrue([initialSyncTag isInitialSync]);
    
    SyncTag *normalTag = [SyncTag tagWithSerialNumber:@"test" lastGlucoseRead:nil lastUserEvent:nil lastCalibrationRead:nil];
    XCTAssertFalse([normalTag isInitialSync]);
}

-(void)testInitialRecordSyncTagIsMarkedAsSuch
{
    RecordSyncTag *initialSyncTag = [RecordSyncTag initialSyncTag];
    XCTAssertTrue([initialSyncTag isInitialSync]);
    
    RecordSyncTag *normalTag = [RecordSyncTag tagWithRecordNumber:@0 pageNumber:@0];
    XCTAssertFalse([normalTag isInitialSync]);
}

@end
