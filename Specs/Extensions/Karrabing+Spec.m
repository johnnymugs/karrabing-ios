#import "Karrabing+Spec.h"

extern Karrabing *_sharedKarrabingInstance;

@implementation Karrabing (Spec)

+ (void)afterEach {
    _sharedKarrabingInstance = nil;
}

@end
