#import "TextFieldCell.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(TextFieldCellSpec)

describe(@"TextFieldCell", ^{
    __block TextFieldCell *cell;

    beforeEach(^{
        cell = [[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"foo"] autorelease];
    });

    describe(@"textField", ^{
        it(@"should exist", ^{
            cell.textField should_not be_nil;
        });

        it(@"should place the textField in the cell's contentView", ^{
            cell.contentView.subviews should contain(cell.textField);
        });
    });
});

SPEC_END
