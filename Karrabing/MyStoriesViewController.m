#import "MyStoriesViewController.h"

@interface MyStoriesViewController ()
@property (strong, nonatomic, readwrite) UIBarButtonItem *cameraButton;
@end

@implementation MyStoriesViewController

- (id)init
{
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

#pragma mark - private

- (void)cameraButtonWasTapped:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:nil];
}

@end
