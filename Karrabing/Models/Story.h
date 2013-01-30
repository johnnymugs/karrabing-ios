#import <Foundation/Foundation.h>

@interface Story : NSObject

@property (nonatomic, strong) NSString *title, *content;
@property (nonatomic, strong) NSData *imageJPEGData;

@end
