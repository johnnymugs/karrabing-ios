#import "MyStoriesViewController.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(MyStoriesViewControllerSpec)

describe(@"MyStoriesViewController", ^{
    __block MyStoriesViewController *controller;

    beforeEach(^{
        controller = [[MyStoriesViewController alloc] init];
    });

    context(@"when the view has been loaded", ^{
        beforeEach(^{
            controller.view should_not be_nil;
        });

        describe(@"cameraButton", ^{
            it(@"should exist", ^{
                controller.cameraButton should_not be_nil;
            });
        });

        describe(@"navigationItem", ^{
            it(@"should have the camera button as the right bar button item", ^{
                controller.navigationItem.rightBarButtonItem should be_same_instance_as(controller.cameraButton);
            });
        });

        describe(@"when the cameraButton is tapped", ^{
            beforeEach(^{
                [controller.cameraButton.target performSelector:controller.cameraButton.action withObject:controller.cameraButton];
            });

            it(@"should present a UIImagePickerController", ^{
                controller.presentedViewController should be_instance_of([UIImagePickerController class]);
            });
        });
    });

    it(@"title should be 'My Stories'", ^{
        controller.title should equal(@"My Stories");
    });
});

SPEC_END
