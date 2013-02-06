#import <UIKit/UIKit.h>

@class Story, TextFieldCell, TextViewCell;

@interface StoryViewController : UITableViewController

@property (nonatomic, strong, readonly) TextFieldCell *textFieldCell;
@property (nonatomic, strong, readonly) TextViewCell *textViewCell;

- (id)initWithStory:(Story *)story;

@end
