#import <Foundation/Foundation.h>
#import "Types.h"
#import "GenericRecord.h"


@interface UserEventRecord : GenericRecord
@property(readonly) UserEventType eventType;
@property(readonly) NSString *subEventIdentifier;
@property(readonly) uint32_t eventSecondsSinceDexcomEpoch;
@property(readonly) NSDate *eventTime;
@property(readonly) uint32_t eventValue;
@property(readonly) Byte subType;

- (instancetype)initWithEventType:(UserEventType)eventType subType:(Byte)subType eventValue:(uint32_t)eventValue eventSecondsSinceDexcomEpoch:(uint32_t)eventSecondsSinceDexcomEpoch internalSecondsSinceDexcomEpoch:(uint32_t)internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:(uint32_t)localSecondsSinceDexcomEpoch recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber;

+ (instancetype)recordWithEventType:(UserEventType)eventType subType:(Byte)subType eventValue:(uint32_t)eventValue eventSecondsSinceDexcomEpoch:(uint32_t)eventSecondsSinceDexcomEpoch internalSecondsSinceDexcomEpoch:(uint32_t)internalSecondsSinceDexcomEpoch localSecondsSinceDexcomEpoch:(uint32_t)localSecondsSinceDexcomEpoch recordNumber:(uint32_t)recordNumber pageNumber:(uint32_t)pageNumber;

@end