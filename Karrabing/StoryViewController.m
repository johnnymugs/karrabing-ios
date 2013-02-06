#import "StoryViewController.h"
#import "TextFieldCell.h"
#import "TextViewCell.h"

@interface StoryViewController ()

@property (nonatomic, strong, readwrite) Story *story;
@property (nonatomic, strong, readwrite) TextFieldCell *textFieldCell;
@property (nonatomic, strong, readwrite) TextViewCell *textViewCell;

@end

enum {
    TitleSection,
    StorySection
};

@implementation StoryViewController

#pragma mark - Table view data source

- (id)initWithStory:(Story *)story {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.story = story;
    }
    return self;
}

- (void)loadView {
    [super loadView];

    self.textFieldCell = [[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"titleCell"];
    self.textFieldCell.textField.placeholder = @"Title";
    self.textViewCell = [[TextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"storyCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == TitleSection) {
        return self.textFieldCell;
    } else if (indexPath.section == StorySection) {
        return self.textViewCell;
    }
    return nil;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

@end
