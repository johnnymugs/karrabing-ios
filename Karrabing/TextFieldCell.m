#import "TextFieldCell.h"

@interface TextFieldCell ()

@property (nonatomic, weak, readwrite) UITextField *textField;

@end


@implementation TextFieldCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UITextField *textField = [[UITextField alloc] init];
        self.textField = textField;
        [self.contentView addSubview:textField];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textField.frame = CGRectInset(self.contentView.bounds, 5.f, 8.f);
}

@end
