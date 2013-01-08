#import <UIKit/UIKit.h>

@interface MyStoriesViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic, readonly) UIBarButtonItem *cameraButton;

@end
