#import "StoryViewController.h"
#import "TextFieldCell.h"
#import "TextViewCell.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(StoryViewControllerSpec)

describe(@"StoryViewController", ^{
    __block StoryViewController *controller;

    beforeEach(^{
        controller = [[[StoryViewController alloc] init] autorelease];
        controller.view should_not be_nil;
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
