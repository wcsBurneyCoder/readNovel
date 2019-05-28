

#import "UIView+NIB.h"

@implementation UIView (NIB)

+ (instancetype)viewFromNib
{
    id obj = nil;
    @try {
        obj = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
    } @catch (NSException *exception) {
        return nil;
    }
    return obj;
}

- (void)addShadowWithColor:(UIColor *)color
{
    self.layer.shadowColor = color?color.CGColor:[[UIColor blackColor] colorWithAlphaComponent:0.2].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 2);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 4;
}

@end
