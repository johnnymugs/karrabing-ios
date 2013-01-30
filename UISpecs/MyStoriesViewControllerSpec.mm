#import "MyStoriesViewController.h"
#import "StoryViewController+Spec.h"
#import "Story.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

UIImage *createBlankImage() {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100, 100), NO, 0.0);
    UIImage *blank = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return blank;
}

SPEC_BEGIN(MyStoriesViewControllerSpec)

describe(@"MyStoriesViewController", ^{
    __block MyStoriesViewController *controller;

    beforeEach(^{
        controller = [[[MyStoriesViewController alloc] init] autorelease];
        [[[UINavigationController alloc] initWithRootViewController:controller] autorelease];
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

#if TARGET_IPHONE_SIMULATOR //camera not supported in simulator
#elif TARGET_OS_IPHONE
            it(@"should present a UIImagePickerController", ^{
                controller.presentedViewController should be_instance_of([UIImagePickerController class]);
            });

            it(@"should have the UIImagePickerController delegate to the controller", ^{
                [((UIImagePickerController *)controller.presentedViewController) delegate] should be_same_instance_as(controller);
            });

            it(@"should set the source type of the UIImagePickerController to camera", ^{
                [(id)(controller.presentedViewController) sourceType] should equal(UIImagePickerControllerSourceTypeCamera);
            });
#endif
        });
    });

    it(@"title should be 'My Stories'", ^{
        controller.title should equal(@"My Stories");
    });

    describe(@"UIImagePickerControllerDelegate protocol", ^{
        describe(@"imagePickerController:didFinishPickingMediaWithInfo:", ^{
            __block UIImage *blankImage;

            beforeEach(^{
                blankImage = createBlankImage();
                [controller presentViewController:[[[UIViewController alloc] init] autorelease]
                                         animated:NO
                                       completion:nil];
                [controller imagePickerController:nil didFinishPickingMediaWithInfo:@{
                    UIImagePickerControllerOriginalImage: blankImage
                 }];
            });

            it(@"should push a StoryViewController onto the navigation stack", ^{
                controller.navigationController.topViewController should be_instance_of([StoryViewController class]);
            });

            it(@"should pass a new story", ^{
                ((StoryViewController *)controller.navigationController.topViewController).story should_not be_nil;
            });

            it(@"should set the JPEG representation of the captured image on the story", ^{
                ((StoryViewController *)controller.navigationController.topViewController).story.imageJPEGData should equal(UIImageJPEGRepresentation(blankImage, 0.8f));
            });

            it(@"should dismiss presented view controller", ^{
                controller.presentedViewController should be_nil;
            });
        });
    });
});

SPEC_END
