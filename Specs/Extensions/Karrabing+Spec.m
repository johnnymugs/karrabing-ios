#import "Karrabing+Spec.h"

extern Karrabing *_sharedKarrabingInstance;


@interface Karrabing (SpecPrivate)
+ (NSString *)storiesPath;
@end


@implementation Karrabing (Spec)

+ (void)afterEach {
    [self reset];
    [[NSFileManager defaultManager] removeItemAtPath:self.storiesPath error:nil];
}

+ (void)reset {
    _sharedKarrabingInstance = nil;
}

@end
