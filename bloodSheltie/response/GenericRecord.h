#import <Foundation/Foundation.h>


@interface GenericRecord : NSObject
@property(readonly) uint32_t internalSecondsSinceDexcomEpoch;
@property(readonly) NSDate *internalTime;
@property(readonly) uint32_t localSecondsSinceDexcomEpoch;
@property(readonly) NSDate *localTime;
@property(readonly) uint32_t recordNumber;
@property(readonly) uint32_t pageNumber;

- (instancetype)initWithInternalSecondsSinceDexcomEpoch:(uint32_t)internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:(uint32_t)localSecondsSinceDexcomEpoch recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber;

+ (instancetype)recordWithInternalSecondsSinceDexcomEpoch:(uint32_t)internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:(uint32_t)localSecondsSinceDexcomEpoch recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber;

@end