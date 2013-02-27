#import "Karrabing.h"

using namespace Cedar::Matchers;
using namespace Cedar::Doubles;

SPEC_BEGIN(KarrabingSpec)

describe(@"Karrabing", ^{
    describe(@"+sharedInstance", ^{
        it(@"should always return the same instance", ^{
            Karrabing.sharedInstance should be_same_instance_as(Karrabing.sharedInstance);
        });
    });
});

SPEC_END
