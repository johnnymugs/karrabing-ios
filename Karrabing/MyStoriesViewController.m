#import "MyStoriesViewController.h"
#import "StoryViewController.h"
#import "Story.h"
#import "Karrabing.h"

static const CGFloat kImageCompressionQuality = 0.8f;
static NSString * const kStoryCellIdentifier = @"story-cell";

@interface MyStoriesViewController ()
@property (strong, nonatomic, readwrite) UIBarButtonItem *cameraButton;
@end

@implementation MyStoriesViewController

- (id)init {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.title = @"My Stories";
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.cameraButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                                                                      target:self
                                                                      action:@selector(cameraButtonWasTapped:)];
    self.navigationItem.rightBarButtonItem = self.cameraButton;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - UIImagePickerControllerDelegate protocol

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    Story *story = [[Story alloc] init];
    story.imageJPEGData = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], kImageCompressionQuality);
    StoryViewController *storyViewController = [[StoryViewController alloc] initWithStory:story];
    [self.navigationController pushViewController:storyViewController animated:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [Karrabing.sharedInstance.stories count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kStoryCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kStoryCellIdentifier];
    }
    cell.textLabel.text = [[Karrabing.sharedInstance.stories objectAtIndex:indexPath.row] title];

    return cell;
}

#pragma mark - private

- (void)cameraButtonWasTapped:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];
}

@end
