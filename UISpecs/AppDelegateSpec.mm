#import "AppDelegate.h"
#import "MyStoriesViewController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(AppDelegateSpec)

describe(@"AppDelegate", ^{
    __block AppDelegate *delegate;

    beforeEach(^{
        delegate = [[AppDelegate alloc] init];
    });

    describe(@"application:didFinishLaunchingWithOptions:", ^{
        beforeEach(^{
            [delegate application:nil didFinishLaunchingWithOptions:nil];
        });

        it(@"should set a UINavigationController as the root view controller", ^{
            delegate.window.rootViewController should be_instance_of([UINavigationController class]);
        });

        it(@"should set a MyStoriesViewController as the top view controller of the navigation controller", ^{
            ((UINavigationController *)delegate.window.rootViewController).topViewController should be_instance_of([MyStoriesViewController class]);
        });
    });
});

SPEC_END
