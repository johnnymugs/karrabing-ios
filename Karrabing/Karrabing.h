#import <Foundation/Foundation.h>

@class Story;

@interface Karrabing : NSObject

@property (strong, nonatomic, readonly) NSArray *stories;

+ (Karrabing *)sharedInstance;
- (void)addStory:(Story *)story;

@end
