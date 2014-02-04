#import <Foundation/Foundation.h>


@interface MeterReadRecord : NSObject
@property(readonly) uint32_t internalSecondsSinceDexcomEpoch;
@property(readonly) uint32_t localSecondsSinceDexcomEpoch;
@property(readonly) uint16_t meterRead;
@property(readonly) uint32_t meterTimeInSecondsSinceDexcomEpoch;

- (instancetype)initWithMeterRead:(uint16_t)meterRead internalSecondsSinceDexcomEpoch:(uint32_t)internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:(uint32_t)localSecondsSinceDexcomEpoch meterTimeInSecondsSinceDexcomEpoch:(uint32_t)meterTimeInSecondsSinceDexcomEpoch;

+ (instancetype)recordWithMeterRead:(uint16_t)meterRead internalSecondsSinceDexcomEpoch:(uint32_t)internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:(uint32_t)localSecondsSinceDexcomEpoch meterTimeInSecondsSinceDexcomEpoch:(uint32_t)meterTimeInSecondsSinceDexcomEpoch;


@end