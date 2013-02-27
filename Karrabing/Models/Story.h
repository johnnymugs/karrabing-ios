#import <Foundation/Foundation.h>

@interface Story : NSObject<NSCoding>

@property (nonatomic, strong) NSString *title, *content;
@property (nonatomic, strong) NSData *imageJPEGData;

@end
