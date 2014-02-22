#import <Foundation/Foundation.h>
#import "Types.h"


@interface UserEventRecord : NSObject
@property(readonly) uint32_t internalSecondsSinceDexcomEpoch;
@property(readonly) NSDate *internalTime;
@property(readonly) uint32_t localSecondsSinceDexcomEpoch;
@property(readonly) NSDate *localTime;
@property(readonly) UserEventType eventType;
@property(readonly) uint32_t eventSecondsSinceDexcomEpoch;
@property(readonly) NSDate *eventTime;
@property(readonly) uint32_t eventValue;

- (instancetype)initWithEventType:(UserEventType)eventType eventValue:(uint32_t)eventValue eventSecondsSinceDexcomEpoch:(uint32_t)eventSecondsSinceDexcomEpoch internalSecondsSinceDexcomEpoch:(uint32_t)internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:(uint32_t)localSecondsSinceDexcomEpoch;

+ (instancetype)recordWithEventType:(UserEventType)eventType eventValue:(uint32_t)eventValue eventSecondsSinceDexcomEpoch:(uint32_t)eventSecondsSinceDexcomEpoch internalSecondsSinceDexcomEpoch:(uint32_t)internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:(uint32_t)localSecondsSinceDexcomEpoch;


@end