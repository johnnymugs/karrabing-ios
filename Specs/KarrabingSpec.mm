#import "Karrabing+Spec.h"
#import "Story.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(KarrabingSpec)

describe(@"Karrabing", ^{
    __block NSString *serializedPath;

    beforeEach(^{
        NSString *documentsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        serializedPath = [documentsDir stringByAppendingPathComponent:@"stories"];
    });

    describe(@"+sharedInstance", ^{
        it(@"should always return the same instance", ^{
            Karrabing.sharedInstance should be_same_instance_as(Karrabing.sharedInstance);
        });
    });

    context(@"when there were no stories stored on the filesystem", ^{
        beforeEach(^{
            [[NSFileManager defaultManager] fileExistsAtPath:serializedPath] should_not be_truthy;
        });

        it(@"should have no stories by default", ^{
            Karrabing.sharedInstance.stories should be_empty;
        });
    });

    context(@"when there are stories stored on the filesystem", ^{
        beforeEach(^{
            Story *story = [[[Story alloc] init] autorelease];
            story.title = @"The title.";
            story.content = @"What would be really long text if this was real.";
            story.imageJPEGData = [@"thisShouldBeBinaryJPEGData" dataUsingEncoding:NSUTF8StringEncoding];
            [Karrabing.sharedInstance addStory:story];

            [[NSFileManager defaultManager] fileExistsAtPath:serializedPath] should be_truthy;

            [Karrabing reset];
        });

        it(@"should recover the stories from the filesystem", ^{
            [Karrabing.sharedInstance.stories count] should equal(1);
        });
    });


    describe(@"addStory:", ^{
        __block Story *story;

        beforeEach(^{
            story = [[[Story alloc] init] autorelease];
            story.title = @"The title.";
            story.content = @"What would be really long text if this was real.";
            story.imageJPEGData = [@"thisShouldBeBinaryJPEGData" dataUsingEncoding:NSUTF8StringEncoding];
            [Karrabing.sharedInstance addStory:story];
        });

        it(@"should add the story to stories list", ^{
            Karrabing.sharedInstance.stories should equal(@[ story ]);
        });

        it(@"should write the list of stories to disk", ^{
            [NSFileManager.defaultManager fileExistsAtPath:serializedPath] should be_truthy;
        });

        describe(@"the serialized stories", ^{
            __block NSArray *stories;
            beforeEach(^{
                stories = [NSKeyedUnarchiver unarchiveObjectWithFile:serializedPath];
            });

            it(@"should serialize all the stories", ^{
                [stories count] should equal(1);
            });

            it(@"should serialize the salient properties of the stories", ^{
                [[stories lastObject] title] should equal(story.title);
                [[stories lastObject] content] should equal(story.content);
                [[stories lastObject] imageJPEGData] should equal(story.imageJPEGData);
            });
        });
    });
});

SPEC_END
