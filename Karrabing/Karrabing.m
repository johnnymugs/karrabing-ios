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
        if ([[NSFileManager defaultManager] fileExistsAtPath:Karrabing.storiesPath]) {
            self.mutableStories = [NSKeyedUnarchiver unarchiveObjectWithFile:Karrabing.storiesPath];
        } else {
            self.mutableStories = [NSMutableArray array];
        }
    }
    return self;
}

- (NSArray *)stories {
    return [self mutableStories];
}

- (void)addStory:(Story *)story {
    [self.mutableStories addObject:story];
    [NSKeyedArchiver archiveRootObject:self.mutableStories toFile:Karrabing.storiesPath];
}

#pragma mark - private
+ (NSString *)storiesPath {
    NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [documentsDir stringByAppendingPathComponent:@"stories"];
}

@end
