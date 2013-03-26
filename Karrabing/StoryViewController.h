#import <UIKit/UIKit.h>

@class Story, TextFieldCell, TextViewCell;

@interface StoryViewController : UITableViewController

@property (nonatomic, strong, readonly) UIBarButtonItem *saveButton;
@property (nonatomic, strong, readonly) TextFieldCell *textFieldCell;
@property (nonatomic, strong, readonly) TextViewCell *textViewCell;
@property (nonatomic, strong, readonly) UIImageView *siteImageView;

- (id)initWithStory:(Story *)story;

@end
