#import "Karrabing.h"
#import "Story.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(KarrabingSpec)

describe(@"Karrabing", ^{
    describe(@"+sharedInstance", ^{
        it(@"should always return the same instance", ^{
            Karrabing.sharedInstance should be_same_instance_as(Karrabing.sharedInstance);
        });
    });

    it(@"should have no stories by default", ^{
        Karrabing.sharedInstance.stories should be_empty;
    });

    describe(@"addStory:", ^{
        __block Story *story;

        beforeEach(^{
            story = nice_fake_for([Story class]);
            [Karrabing.sharedInstance addStory:story];
        });

        it(@"should add the story to stories list", ^{
            Karrabing.sharedInstance.stories should equal(@[ story ]);
        });
    });
});

SPEC_END
