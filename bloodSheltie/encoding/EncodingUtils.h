#import <Foundation/Foundation.h>
#import "Types.h"

#define READ_UNSIGNEDINT(value, cursor, data) [data getBytes:&value range:NSMakeRange(cursor, sizeof(value))]; \
                                      value = CFSwapInt32LittleToHost(value); \
                                      cursor += sizeof(value)

#define READ_UNSIGNEDSHORT(value, cursor, data) [data getBytes:&value range:NSMakeRange(cursor, sizeof(value))]; \
                                        value = CFSwapInt16LittleToHost(value); \
                                        cursor += sizeof(value)

#define READ_BYTE(value, cursor, data) [data getBytes:&value range:NSMakeRange(cursor, sizeof(value))]; \
                                        cursor += sizeof(value)

@interface EncodingUtils : NSObject

+(CRC) crc16:(NSData *)packet withOffset:(uint16_t)offset andLength:(uint16_t)length;
+(NSData *) dataFromHexString: (NSString*)hexString;
+(CRC) getPacketCrc16:(NSData *)packet;
+(NSString *) bytesToString:(Byte *)bytes withSize:(size_t)size;

+ (bool)validateCrc:(NSData *)data;

+ (NSString *)dictionaryToJSON:(NSDictionary *)dictionary error:(NSError **)error;

+ (NSDictionary *)stringToJsonDictionary:(NSString *)jsonString error:(NSError **)error;
@end