#import "MyStoriesViewController.h"

@interface MyStoriesViewController ()

@end

@implementation MyStoriesViewController

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.title = @"My Stories";
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

@end
