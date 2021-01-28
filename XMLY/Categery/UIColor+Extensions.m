
#import "UIColor+Extensions.h"

@implementation UIColor (Extensions)

+ (instancetype)YM_ColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    if (red > 0.0) {
        red /= 255.;
    }
    if (green > 0.0) {
        green /= 255.;
    }
    if (blue > 0.0) {
        blue /= 255.;
    }
    return [self colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
