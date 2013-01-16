#import "StoryViewController.h"
#import "TextFieldCell.h"

@interface StoryViewController ()

@end

enum {
    TitleSection,
    StorySection
};

@implementation StoryViewController

#pragma mark - Table view data source

- (id)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {

    }
    return self;
}

- (void)loadView {
    [super loadView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == TitleSection) {
        TextFieldCell *textFieldCell = [tableView dequeueReusableCellWithIdentifier:@"titleCell"];

        if (!textFieldCell) {
            textFieldCell = [[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"titleCell"];
        }

        return textFieldCell;
    }
    return nil;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

@end
