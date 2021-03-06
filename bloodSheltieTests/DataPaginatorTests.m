#import <XCTest/XCTest.h>
#import "DataPaginator.h"
#import "ReadDatabasePagesRequest.h"
#import "RecordSyncTag.h"

@interface DataPaginatorTests : XCTestCase

@end

@implementation DataPaginatorTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testRangeOfOnlyOnePage
{
    PageRange *range = [[PageRange alloc] initWithFirstPage:147 lastPage:147 ofRecordType:EGVData ];
    
    NSArray *pagesRequests = [DataPaginator getDatabasePagesRequestsForRecordType:EGVData pageRange:range];
    
    ReadDatabasePagesRequest *expectedRequest =
    [[ReadDatabasePagesRequest alloc] initWithRecordType:EGVData pageNumber:147 numberOfPages:1];
    XCTAssertNotNil(pagesRequests);
    XCTAssertEqual([pagesRequests count], 1ul);
    XCTAssertEqualObjects([pagesRequests firstObject], expectedRequest);
}

/**
 * This happens when a user never recorded any events. We get firstPage=-1 and lastPage=-1
 */
- (void)testRangeWithNoContent
{
    PageRange *range = [[PageRange alloc] initWithFirstPage:-1 lastPage:-1 ofRecordType:EGVData ];

    NSArray *pagesRequests = [DataPaginator getDatabasePagesRequestsForRecordType:EGVData pageRange:range];

    XCTAssertNotNil(pagesRequests);
    XCTAssertEqual([pagesRequests count], 0ul);
}

- (void)testFirstAndLastPageConsecutiveShouldReturn1RequestOfTwoPages
{
    PageRange *range = [[PageRange alloc] initWithFirstPage:147 lastPage:148 ofRecordType:EGVData ];
    
    NSArray *pagesRequests = [DataPaginator getDatabasePagesRequestsForRecordType:EGVData pageRange:range];
    
    ReadDatabasePagesRequest *expectedRequest =
    [[ReadDatabasePagesRequest alloc] initWithRecordType:EGVData pageNumber:147 numberOfPages:2];
    XCTAssertNotNil(pagesRequests);
    XCTAssertEqual([pagesRequests count], 1ul);
    XCTAssertEqualObjects([pagesRequests firstObject], expectedRequest);
}

- (void)testTwoElementsWithFirstOneOfFourPages
{
    PageRange *range = [[PageRange alloc] initWithFirstPage:140 lastPage:144 ofRecordType:EGVData ];
    
    NSArray *pagesRequests = [DataPaginator getDatabasePagesRequestsForRecordType:EGVData pageRange:range];
    
    XCTAssertNotNil(pagesRequests);
    XCTAssertEqual([pagesRequests count], 2ul);
    
    ReadDatabasePagesRequest *firstExpectedRequest =
    [[ReadDatabasePagesRequest alloc] initWithRecordType:EGVData pageNumber:140 numberOfPages:4];
    XCTAssertEqualObjects([pagesRequests firstObject], firstExpectedRequest);
    
    ReadDatabasePagesRequest *secondExpectedRequest =
    [[ReadDatabasePagesRequest alloc] initWithRecordType:EGVData pageNumber:144 numberOfPages:1];
    XCTAssertEqualObjects([pagesRequests lastObject], secondExpectedRequest);
}

- (void)testWithInitialSyncTag
{
    PageRange *range = [[PageRange alloc] initWithFirstPage:140 lastPage:144 ofRecordType:EGVData ];
    
    NSArray *pagesRequests = [DataPaginator getDatabasePagesRequestsForRecordType:EGVData pageRange:range recordSyncTag:[RecordSyncTag initialSyncTag]];
    
    XCTAssertNotNil(pagesRequests);
    XCTAssertEqual([pagesRequests count], 2ul);
    
    ReadDatabasePagesRequest *firstExpectedRequest =
    [[ReadDatabasePagesRequest alloc] initWithRecordType:EGVData pageNumber:140 numberOfPages:4];
    XCTAssertEqualObjects([pagesRequests firstObject], firstExpectedRequest);
    
    ReadDatabasePagesRequest *secondExpectedRequest =
    [[ReadDatabasePagesRequest alloc] initWithRecordType:EGVData pageNumber:144 numberOfPages:1];
    XCTAssertEqualObjects([pagesRequests lastObject], secondExpectedRequest);
}

- (void)testWithIncrementalSyncTag
{
    PageRange *range = [[PageRange alloc] initWithFirstPage:140 lastPage:144 ofRecordType:EGVData ];
    
    RecordSyncTag *syncTag = [RecordSyncTag tagWithRecordNumber:@1222 pageNumber:@141];
    NSArray *pagesRequests = [DataPaginator getDatabasePagesRequestsForRecordType:EGVData pageRange:range recordSyncTag:syncTag];
    
    XCTAssertNotNil(pagesRequests);
    XCTAssertEqual([pagesRequests count], 1ul);
    
    ReadDatabasePagesRequest *firstExpectedRequest =
    [[ReadDatabasePagesRequest alloc] initWithRecordType:EGVData pageNumber:141 numberOfPages:4];
    XCTAssertEqualObjects([pagesRequests firstObject], firstExpectedRequest);
}

- (void)testWithOutOfDateSyncTag
{
    PageRange *range = [[PageRange alloc] initWithFirstPage:141 lastPage:144 ofRecordType:EGVData ];

    RecordSyncTag *syncTag = [RecordSyncTag tagWithRecordNumber:@1222 pageNumber:@54];
    NSArray *pagesRequests = [DataPaginator getDatabasePagesRequestsForRecordType:EGVData pageRange:range recordSyncTag:syncTag];

    XCTAssertNotNil(pagesRequests);
    XCTAssertEqual([pagesRequests count], 1ul);

    ReadDatabasePagesRequest *firstExpectedRequest =
            [[ReadDatabasePagesRequest alloc] initWithRecordType:EGVData pageNumber:141 numberOfPages:4];
    XCTAssertEqualObjects([pagesRequests firstObject], firstExpectedRequest);
}


@end
