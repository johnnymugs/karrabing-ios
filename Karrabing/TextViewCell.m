#import "TextViewCell.h"

@interface TextViewCell ()

@property (weak, nonatomic, readwrite) UITextView *textView;

@end

@implementation TextViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UITextView *newTextView = [[UITextView alloc] init];
        self.textView = newTextView;
        [self.contentView addSubview:newTextView];
    }
    return self;
}

@end
