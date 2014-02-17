#import <Foundation/Foundation.h>


@interface MeterReadRecord : NSObject
@property(readonly) uint32_t internalSecondsSinceDexcomEpoch;
@property(readonly) NSDate *internalTime;
@property(readonly) uint32_t localSecondsSinceDexcomEpoch;
@property(readonly) NSDate *localTime;
@property(readonly) uint16_t meterRead;
@property(readonly) uint32_t meterTimeInSecondsSinceDexcomEpoch;
@property(readonly) NSDate *meterTime;
@property(readonly) NSTimeZone *timezone;

- (instancetype)initWithMeterRead:(uint16_t)meterRead internalSecondsSinceDexcomEpoch:(uint32_t)internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:(uint32_t)localSecondsSinceDexcomEpoch meterTimeInSecondsSinceDexcomEpoch:(uint32_t)meterTimeInSecondsSinceDexcomEpoch;

+ (instancetype)recordWithMeterRead:(uint16_t)meterRead internalSecondsSinceDexcomEpoch:(uint32_t)internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:(uint32_t)localSecondsSinceDexcomEpoch meterTimeInSecondsSinceDexcomEpoch:(uint32_t)meterTimeInSecondsSinceDexcomEpoch;


@end