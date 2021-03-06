#import "StoryViewController.h"
#import "TextFieldCell.h"
#import "TextViewCell.h"
#import "Story.h"
#import "Karrabing.h"

@interface StoryViewController ()

@property (nonatomic, strong, readwrite) Story *story;
@property (nonatomic, strong, readwrite) UIBarButtonItem *saveButton;
@property (nonatomic, strong, readwrite) TextFieldCell *textFieldCell;
@property (nonatomic, strong, readwrite) TextViewCell *textViewCell;
@property (nonatomic, strong, readwrite) UIImageView *siteImageView;

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

- (id)init {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (id)initWithStyle:(UITableViewStyle)style {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (void)loadView {
    [super loadView];

    self.navigationItem.rightBarButtonItem =
    self.saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save"
                                                       style:UIBarButtonItemStyleBordered
                                                      target:self
                                                      action:@selector(saveButtonWasTapped)];

    self.textFieldCell = [[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"titleCell"];
    self.textFieldCell.textField.placeholder = @"Title";
    self.textViewCell = [[TextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"storyCell"];
    self.tableView.tableHeaderView = [[UIView  alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];

    self.siteImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5,5, 110, 110)];
    self.siteImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.siteImageView.image = [UIImage imageWithData:self.story.imageJPEGData];
    [self.tableView.tableHeaderView addSubview:self.siteImageView];
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

#pragma mark - private

- (void)saveButtonWasTapped {
    self.story.title = self.textFieldCell.textField.text;
    self.story.content = self.textViewCell.textView.text;
    [Karrabing.sharedInstance addStory:self.story];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
