//
//  YMHomePageView.m
//  XMLY
//
//  Created by 于光超 on 2021/1/28.
//

#import "YMHomePageView.h"
#import "YMCarouselView.h"
#import "YMGloableDefine.h"
@interface YMHomePageView () <YMCarouselViewDelegate>
@property (nonatomic, strong) YMCarouselView *slideView;
@end

@implementation YMHomePageView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self addUIConstraint];
    }
    return self;
}
#pragma mark - setupUI
- (void)setupUI
{
    [self addSubview:self.slideView];
}
- (void)addUIConstraint
{
    [self.slideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.height.mas_equalTo(140*SCREEN_SCALE_375);
    }];
}
#pragma mark -private func
#pragma mark -YMCarouselViewDelegate
- (void)carouselViewIndexOfClickedImage:(NSInteger)index
{
    NSLog(@"点击了第%d个广告",index);
}
#pragma mark - lazy init
- (YMCarouselView *)slideView
{
    if (!_slideView) {
        _slideView = ({
            YMCarouselView *carousel = [[YMCarouselView alloc] initWithimages:@[[UIImage imageNamed:@"banner1"],[UIImage imageNamed:@"banner2"],[UIImage imageNamed:@"banner3"]]];
            carousel.delegate = self;
            carousel;
        });
    }
    return _slideView;
}
@end
