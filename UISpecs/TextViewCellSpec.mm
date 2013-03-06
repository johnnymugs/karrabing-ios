#import "TextViewCell.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(TextViewCellSpec)

describe(@"TextViewCell", ^{
    __block TextViewCell *cell;

    beforeEach(^{
        cell = [[[TextViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"whatever"] autorelease];
    });

    describe(@"textView", ^{
        it(@"should exist", ^{
            cell.textView should_not be_nil;
        });

        it(@"should place the textView in the cell's contentView", ^{
            cell.contentView.subviews should contain(cell.textView);
        });
    });
});

SPEC_END
