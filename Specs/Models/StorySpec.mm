#import "Story.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(StorySpec)

describe(@"Story", ^{
    __block Story *story;

    beforeEach(^{
        story = [[[Story alloc] init] autorelease];
    });

    describe(@"NSCoding protocol", ^{
        __block Story *decodedStory;

        beforeEach(^{
            story.title = @"I have a stream";
            story.content = @"A stream that one day...";
            story.imageJPEGData = [@"thisIsDummyDataForTheImage" dataUsingEncoding:NSUTF8StringEncoding];
            NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:story];
            decodedStory = [NSKeyedUnarchiver unarchiveObjectWithData:archivedData];
        });

        it(@"should encode and decode the title", ^{
            decodedStory.title should equal(story.title);
        });

        it(@"should encode and decode the content", ^{
            decodedStory.content should equal(story.content);
        });

        it(@"should encode and decode the archivedData", ^{
            decodedStory.imageJPEGData should equal(story.imageJPEGData);
        });
    });
});

SPEC_END
