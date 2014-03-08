#import <Foundation/Foundation.h>


@interface SyncProgressEvent : SyncEvent
@property(readonly) NSUInteger totalPagesToFetch;
@property(readonly) NSUInteger fetchedSoFar;

- (instancetype)initWithPort:(ORSSerialPort *)port sessionData:(SyncData *)syncData totalToFetch:(NSUInteger)totalToFetch fetchedSoFar:(NSUInteger)fetchedSoFar;

- (NSString *)description;

+ (instancetype)eventWithPort:(ORSSerialPort *)port syncData:(SyncData *)syncData totalToFetch:(NSUInteger)totalToFetch fetchedSoFar:(NSUInteger)fetchedSoFar;

@end