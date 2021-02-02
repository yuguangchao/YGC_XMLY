//
//  YMHomePageView.m
//  XMLY
//
//  Created by 于光超 on 2021/1/28.
//

#import "YMHomePageView.h"
#import "YMCarouselView.h"
#import "YMGloableDefine.h"
#import "YMTabItemView.h"
#import "YMOrderComponent.h"
#import "YMLocationManager.h"
@interface YMHomePageView () <YMCarouselViewDelegate>
@property (nonatomic, strong) YMCarouselView *slideView;
@property (nonatomic, strong) UIView *tabView;
@property (nonatomic, strong) YMTabItemView *orderItemView;
@property (nonatomic, strong) YMTabItemView *balanceItemView;
@property (nonatomic, strong) YMTabItemView *evaluateItemView;
@property (nonatomic, strong) YMBaseView *mapView;
@property (nonatomic, strong) YMOrderComponent *orderComponent;
@property (nonatomic, strong) NSArray<UIImage *> *orderImageArr;
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
    [self addSubview:self.tabView];
    [self.tabView addSubview:self.orderItemView];
    [self.tabView addSubview:self.balanceItemView];
    [self.tabView addSubview:self.evaluateItemView];
    [self addSubview:self.mapView];
    [self.mapView addSubview:[YMLocationManager sharedInstance].mapView];
    [self.mapView addSubview:self.orderComponent];
}
- (void)addUIConstraint
{
    [self.slideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.height.mas_equalTo(140*SCREEN_SCALE_375);
    }];
    
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.slideView.mas_bottom);
        make.height.mas_equalTo(60*SCREEN_SCALE_375);
    }];
    
    CGFloat itemWidth = SCREEN_WIDTH/3;
    [self.orderItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(self.tabView);
        make.width.mas_equalTo(itemWidth);
    }];
    
    [self.balanceItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.tabView);
        make.width.mas_equalTo(itemWidth);
        make.centerX.mas_equalTo(self.tabView);
    }];
    
    [self.evaluateItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(self.tabView);
        make.width.mas_equalTo(itemWidth);
    }];
    
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.top.mas_equalTo(self.tabView.mas_bottom);
    }];
    
    [[YMLocationManager sharedInstance].mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.mapView);
    }];
    
    [self.orderComponent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.mapView);
        make.width.height.mas_equalTo(120*SCREEN_SCALE_375);
    }];
}
#pragma mark -public func
- (void)refreshBanner:(NSArray<YMBannerModel *> *)model
{
    [self.slideView refreshCarousel:model];
}
- (void)refreshItem:(NSArray<YMItemModel *> *)model
{
    [self.orderItemView refreshTabItem:model[0]];
    [self.balanceItemView refreshTabItem:model[1]];
    [self.evaluateItemView refreshTabItem:model[2]];
}
- (void)startOrderAnimation
{
    [self.orderComponent startAnimation];
}
- (void)stopOrderAnimation
{
    [self.orderComponent stopAnimation];
}
#pragma mark -private func
- (void)clickOrder
{
    if (self.orderBlock) {
        self.orderBlock();
    }
}
- (void)clickBalance
{
    if (self.balanceBlock) {
        self.balanceBlock();
    }
}
- (void)clickEvaluate
{
    if (self.evaluateBlock) {
        self.evaluateBlock();
    }
}
- (void)startOrderClick
{
    if (self.startOrderBlock) {
        self.startOrderBlock();
    }
}
#pragma mark -YMCarouselViewDelegate
- (void)carouselViewIndexOfClickedImage:(NSInteger)index
{
    if (self.bannerBlock) {
        self.bannerBlock(index);
    }
}
#pragma mark - lazy init
- (YMCarouselView *)slideView
{
    if (!_slideView) {
        _slideView = ({
            YMCarouselView *carousel = [[YMCarouselView alloc] init];
            carousel.delegate = self;
            carousel;
        });
    }
    return _slideView;
}
- (UIView *)tabView
{
    if (!_tabView) {
        _tabView = ({
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor whiteColor];
            view;
        });
    }
    return _tabView;
}
- (YMTabItemView *)orderItemView
{
    if (!_orderItemView) {
        _orderItemView = ({
            YMTabItemView *view = [[YMTabItemView alloc] init];
            __weak typeof(self) weakSelf = self;
            view.clickBlock = ^{
                [weakSelf clickOrder];
            };
            view;
        });
    }
    return _orderItemView;
}
- (YMTabItemView *)balanceItemView
{
    if (!_balanceItemView) {
        _balanceItemView = ({
            YMTabItemView *view = [[YMTabItemView alloc] init];
            __weak typeof(self) weakSelf = self;
            view.clickBlock = ^{
                [weakSelf clickBalance];
            };
            view;
        });
    }
    return _balanceItemView;
}
- (YMTabItemView *)evaluateItemView
{
    if (!_evaluateItemView) {
        _evaluateItemView = ({
            YMTabItemView *view = [[YMTabItemView alloc] init];
            __weak typeof(self) weakSelf = self;
            view.clickBlock = ^{
                [weakSelf clickEvaluate];
            };
            view;
        });
    }
    return _evaluateItemView;
}
- (YMBaseView *)mapView
{
    if (!_mapView) {
        _mapView = ({
            YMBaseView *view = [[YMBaseView alloc] init];
            view;
        });
    }
    return _mapView;
}
- (YMOrderComponent *)orderComponent
{
    if (!_orderComponent) {
        _orderComponent = ({
            YMOrderComponent *view = [[YMOrderComponent alloc] initWithImageArr:self.orderImageArr title:@"开始\n接单" defaultImage:[UIImage imageNamed:@"OrderButton1"]];
            __weak typeof(self) weakSelf = self;
            view.clickBlock = ^{
                [weakSelf startOrderClick];
            };
            view;
        });
    }
    return _orderComponent;
}
- (NSArray<UIImage *> *)orderImageArr
{
    if (!_orderImageArr) {
        _orderImageArr = ({
            NSMutableArray *imageArr = [NSMutableArray array];
            for (int i = 1; i < 10; i++) {
                [imageArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"OrderButton%d",i]]];
            }
            imageArr;
        });
    }
    return _orderImageArr;
}
@end
