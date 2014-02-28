#import "GenericPayload.h"


@implementation GenericPayload {

}
- (instancetype)initWithPayloadContent:(Byte)content {
    self = [super init];
    if (self) {
        _content = content;
    }

    return self;
}

+ (instancetype)payloadWithContent:(Byte)content {
    return [[self alloc] initWithPayloadContent:content];
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.payload=%c", self.content];
    [description appendString:@">"];
    return description;
}

@end