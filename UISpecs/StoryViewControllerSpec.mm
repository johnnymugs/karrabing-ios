#import "StoryViewController.h"
#import "TextFieldCell.h"
#import "UIImage+Spec.h"
#import "TextViewCell.h"
#import "Karrabing.h"
#import "Story.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(StoryViewControllerSpec)

describe(@"StoryViewController", ^{
    __block StoryViewController *controller;
    __block Story *story;

    beforeEach(^{
        UIViewController *viewController = [[[UIViewController alloc] init] autorelease];
        UINavigationController *navController = [[[UINavigationController alloc] initWithRootViewController:viewController] autorelease];

        story = [[[Story alloc] init] autorelease];
        story.imageJPEGData = UIImageJPEGRepresentation([UIImage imageNamed:@"Icon"], 0.3f);

        controller = [[[StoryViewController alloc] initWithStory:story] autorelease];
        controller.view should_not be_nil;

        [navController pushViewController:controller animated:NO];
    });

    describe(@"saveButton", ^{
        it(@"should exist", ^{
            controller.saveButton should_not be_nil;
        });
    });

    describe(@"textFieldCell", ^{
        it(@"should exist", ^{
            controller.textFieldCell should_not be_nil;
        });

        it(@"should set the placeholder text on the TextFieldCell to 'Title'", ^{
            controller.textFieldCell.textField.placeholder should equal(@"Title");
        });
    });

    describe(@"textViewCell", ^{
        it(@"should exist", ^{
            controller.textViewCell should_not be_nil;
        });
    });

    describe(@"siteImageView", ^{
        it(@"should be a subview of the tableView's header view", ^{
            controller.tableView.tableHeaderView.subviews should contain(controller.siteImageView);
        });

        it(@"should use the image data from the story", ^{
            [controller.siteImageView.image isEqualToByBytes:[UIImage imageWithData:story.imageJPEGData]] should be_truthy;
        });
    });

    describe(@"navigationItem", ^{
        describe(@"rightBarButtonItem", ^{
            it(@"should be the save button", ^{
                controller.navigationItem.rightBarButtonItem should be_same_instance_as(controller.saveButton);
            });
        });
    });

    describe(@"on save button tap", ^{
        beforeEach(^{
            controller.textFieldCell.textField.text = @"A rainbow serpent nesting spot";
            controller.textViewCell.textView.text = @"Lorem ipsum like i give i crap";
            [controller.saveButton.target performSelector:controller.saveButton.action];
        });

        it(@"should set the title of the story to the text in the first cell", ^{
            story.title should equal(controller.textFieldCell.textField.text);
        });

        it(@"should set the story content to the text in the second cell", ^{
            story.content should equal(@"Lorem ipsum like i give i crap");
        });

        it(@"should add the story to the list of stories", ^{
            Karrabing.sharedInstance.stories should contain(story);
        });

        it(@"should pop the controller off the navigation stack", ^{
            controller.navigationController.topViewController should_not be_same_instance_as(controller);
        });
    });

    describe(@"UITableViewDataSource protocol", ^{
        describe(@"numberOfSectionsInTableView:", ^{
            it(@"should be 2", ^{
                [controller numberOfSectionsInTableView:controller.tableView] should equal(2);
            });
        });

        describe(@"tableView:numberOfRowsInSection:", ^{
            context(@"for the first section", ^{
                it(@"should be 1", ^{
                    [controller tableView:controller.tableView numberOfRowsInSection:0] should equal(1);
                });
            });

            context(@"for the second section", ^{
                it(@"should be 1", ^{
                    [controller tableView:controller.tableView numberOfRowsInSection:1] should equal(1);
                });
            });
        });

        describe(@"tableView:cellForRowAtIndexPath:", ^{
            __block UITableViewCell *cell;

            context(@"for the first cell in the first section (title row)", ^{
                beforeEach(^{
                    cell = [controller tableView:controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                });

                it(@"should return the textFieldCell", ^{
                    cell should be_same_instance_as(controller.textFieldCell);
                });
            });

            context(@"for the first cell in the second section (story row)", ^{
                beforeEach(^{
                    cell = [controller tableView:controller.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
                });

                it(@"should return the textViewCell", ^{
                    cell should be_same_instance_as(controller.textViewCell);
                });
            });
        });
    });
});

SPEC_END
