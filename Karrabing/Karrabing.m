#import "Karrabing.h"

Karrabing *_sharedKarrabingInstance = nil;

@implementation Karrabing

+ (Karrabing *)sharedInstance {
    if (_sharedKarrabingInstance == nil) {
        _sharedKarrabingInstance = [[Karrabing alloc] init];
    }
    return _sharedKarrabingInstance;
}

@end
