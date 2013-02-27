#import "Karrabing.h"

Karrabing *_sharedKarrabingInstance = nil;

@interface Karrabing ()

@property (strong, nonatomic) NSMutableArray *mutableStories;

@end


@implementation Karrabing

+ (Karrabing *)sharedInstance {
    if (_sharedKarrabingInstance == nil) {
        _sharedKarrabingInstance = [[Karrabing alloc] init];
    }
    return _sharedKarrabingInstance;
}

- (id)init {
    if (self = [super init]) {
        self.mutableStories = [NSMutableArray array];
    }
    return self;
}

- (NSArray *)stories {
    return [self mutableStories];
}

- (void)addStory:(Story *)story {
    [self.mutableStories addObject:story];
}

@end
