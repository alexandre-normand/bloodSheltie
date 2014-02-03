#import <XCTest/XCTest.h>
#import "DataPaginator.h"
#import "PageRange.h"
#import "ReadDatabasePagesRequest.h"

@interface DataPaginatorTests : XCTestCase

@end

@implementation DataPaginatorTests

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

- (void)testRangeOfOnlyOnePage
{
    PageRange *range = [[PageRange alloc] initWithFirstPage:147 lastPage:147 ofRecordType:NULL ];

    NSArray *pagesRequests = [DataPaginator getDatabasePagesRequestsForRecordType:EGVData andPageRange:range];

    ReadDatabasePagesRequest *expectedRequest =
            [[ReadDatabasePagesRequest alloc] initWithRecordType:EGVData pageNumber:147 numberOfPages:1];
    XCTAssertNotNil(pagesRequests);
    XCTAssertEqual([pagesRequests count], 1ul);
    XCTAssertEqualObjects([pagesRequests firstObject], expectedRequest);
}

- (void)testFirstAndLastPageConsecutiveShouldReturn1RequestOfTwoPages
{
    PageRange *range = [[PageRange alloc] initWithFirstPage:147 lastPage:148 ofRecordType:NULL ];

    NSArray *pagesRequests = [DataPaginator getDatabasePagesRequestsForRecordType:EGVData andPageRange:range];

    ReadDatabasePagesRequest *expectedRequest =
            [[ReadDatabasePagesRequest alloc] initWithRecordType:EGVData pageNumber:147 numberOfPages:2];
    XCTAssertNotNil(pagesRequests);
    XCTAssertEqual([pagesRequests count], 1ul);
    XCTAssertEqualObjects([pagesRequests firstObject], expectedRequest);
}

- (void)testTwoElementsWithFirstOneOfFourPages
{
    PageRange *range = [[PageRange alloc] initWithFirstPage:140 lastPage:144 ofRecordType:NULL ];

    NSArray *pagesRequests = [DataPaginator getDatabasePagesRequestsForRecordType:EGVData andPageRange:range];

    XCTAssertNotNil(pagesRequests);
    XCTAssertEqual([pagesRequests count], 2ul);

    ReadDatabasePagesRequest *firstExpectedRequest =
            [[ReadDatabasePagesRequest alloc] initWithRecordType:EGVData pageNumber:140 numberOfPages:4];
    XCTAssertEqualObjects([pagesRequests firstObject], firstExpectedRequest);

    ReadDatabasePagesRequest *secondExpectedRequest =
            [[ReadDatabasePagesRequest alloc] initWithRecordType:EGVData pageNumber:144 numberOfPages:1];
    XCTAssertEqualObjects([pagesRequests lastObject], secondExpectedRequest);
}


@end
