#import "MyStoriesViewController.h"
#import "StoryViewController+Spec.h"
#import "Story.h"
#import "Karrabing.h"
#import "UIImage+Spec.h"

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

    describe(@"viewWillAppear:", ^{
        beforeEach(^{
            spy_on(controller.tableView);
            [controller viewWillAppear:NO];
        });

        it(@"should reload the table view", ^{
            controller.tableView should have_received("reloadData");
        });
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

    describe(@"UITableViewDataSource protocol", ^{
        describe(@"-numberOfSectionsInTableView:", ^{
            it(@"should always be 1", ^{
                [controller numberOfSectionsInTableView:controller.tableView] should equal(1);
            });
        });

        describe(@"-tableView:numberOfRowsInSection:", ^{
            context(@"when there are no stories", ^{
                beforeEach(^{
                    Karrabing.sharedInstance.stories should be_empty;
                });

                it(@"should be 0", ^{
                    [controller tableView:controller.tableView numberOfRowsInSection:0] should equal(0);
                });
            });

            context(@"when there are some stories", ^{
                beforeEach(^{
                    [Karrabing.sharedInstance addStory:[[Story alloc] init]];
                    [Karrabing.sharedInstance addStory:[[Story alloc] init]];
                    [Karrabing.sharedInstance addStory:[[Story alloc] init]];

                    Karrabing.sharedInstance.stories should_not be_empty;
                });

                it(@"should return the number of stories", ^{
                    [controller tableView:controller.tableView numberOfRowsInSection:0] should equal(3);
                });
            });
        });

        describe(@"-tableView:cellForRowAtIndexPath:", ^{
            __block UITableViewCell *cell;
            __block Story *story;
            beforeEach(^{
                story = [[Story alloc] init];
                story.title = @"Reamde";
                story.imageJPEGData = UIImageJPEGRepresentation([UIImage imageNamed:@"Icon"], 0.3f);
                [Karrabing.sharedInstance addStory:story];

                cell = [controller tableView:controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

                [Karrabing.sharedInstance.stories count] should equal(1);
            });

            it(@"should return a cell", ^{
                cell should be_instance_of([UITableViewCell class]);
            });

            it(@"should set the text label's text of the cell to the story title", ^{
                cell.textLabel.text should equal(story.title);
            });

            it(@"should set the text label's image text of the cell to the story image", ^{
                [cell.imageView.image isEqualToByBytes:[UIImage imageWithData:story.imageJPEGData]] should be_truthy;
            });
        });
    });
});

SPEC_END
