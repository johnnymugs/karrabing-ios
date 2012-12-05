#import "MyStoriesViewController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(MyStoriesViewControllerSpec)

describe(@"MyStoriesViewController", ^{
    __block MyStoriesViewController *controller;

    beforeEach(^{
        controller = [[MyStoriesViewController alloc] init];
    });

    it(@"title should be 'My Stories'", ^{
        controller.title should equal(@"My Stories");
    });
});

SPEC_END
