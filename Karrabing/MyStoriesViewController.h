#import <UIKit/UIKit.h>

@interface MyStoriesViewController : UITableViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic, readonly) UIBarButtonItem *cameraButton;

@end
