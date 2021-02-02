//
//  YMOrderComponent.m
//  XMLY
//
//  Created by 于光超 on 2021/2/2.
//

#import "YMOrderComponent.h"
#import "YMGloableDefine.h"
@interface YMOrderComponent ()
@property (nonatomic, strong) UIImageView *imagev;
@property (nonatomic, strong) UIImage *defaultImage;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray<UIImage *> *orderImageArr;
@end
@implementation YMOrderComponent

- (instancetype)initWithImageArr:(NSArray<UIImage *> *)imageArr title:(NSString *)title defaultImage:(UIImage *)defaultImage
{
    self = [super init];
    if (self) {
        self.defaultImage = defaultImage;
        self.title = title;
        self.orderImageArr = imageArr;
        [self setupUI];
        [self addUIConstraint];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
        [self addGestureRecognizer:tap];
        self.userInteractionEnabled = YES;
    }
    return self;
}
#pragma mark - setupUI
- (void)setupUI
{
    [self addSubview:self.imagev];
    [self addSubview:self.label];
}
- (void)addUIConstraint
{
    [self.imagev mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self);
    }];
}
#pragma mark - public func
- (void)startAnimation
{
    [self.imagev startAnimating];
}
- (void)stopAnimation
{
    [self.imagev stopAnimating];
}
#pragma mark -click
- (void)click
{
    if (self.clickBlock) {
        self.clickBlock();
    }
}
#pragma mark -lazy init
- (UIImageView *)imagev
{
    if (!_imagev) {
        _imagev = ({
            UIImageView *view = [[UIImageView alloc] initWithImage:self.defaultImage];
            view.animationImages = self.orderImageArr;
            view.animationDuration = 0.8;
            view.animationRepeatCount = 0;
            view;
        });
    }
    return _imagev;
}
- (UILabel *)label
{
    if (!_label) {
        _label = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:14 * SCREEN_SCALE_375];
            label.textColor = [UIColor whiteColor];
            label.numberOfLines = 0;
            label.textAlignment = NSTextAlignmentCenter;
            label.text = self.title;
            label;
        });
    }
    return _label;
}
@end
