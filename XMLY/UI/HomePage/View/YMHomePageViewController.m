//
//  YMHomePageViewController.m
//  XMLY
//
//  Created by 于光超 on 2021/1/28.
//

#import "YMHomePageViewController.h"
#import "YMGloableDefine.h"
#import "YMHomePageView.h"
#import "YMHomePageViewModel.h"
@interface YMHomePageViewController ()
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) YMHomePageView *homePageView;
@property (nonatomic, strong) YMHomePageViewModel *viewModel;
@end

@implementation YMHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUPNavigationItem];
    [self setupUI];
    [self initData];
}

#pragma mark - setnavigationItem
- (void)setUPNavigationItem
{
    self.navigationItem.title = @"日日顺快线";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
}
#pragma mark - setupUI
- (void)setupUI
{
    [self.view addSubview:self.homePageView];
}
#pragma mark -initData
- (void)initData
{
    [self.homePageView refreshBanner:[self.viewModel fetchBannerModel]];
    [self.homePageView refreshItem:[self.viewModel fetchItemModel]];
}
#pragma mark - private func
- (void)sidebarClick
{
    
}
- (void)locationClick
{
    
}
- (void)clickBanner:(NSInteger)index
{
    
}
- (void)clickOrder
{
    
}
- (void)clickBalance
{
    
}
- (void)clickEvaluate
{
    
}
#pragma mark - lazy init
- (UIButton *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setBackgroundImage:[UIImage imageNamed:@"sidebar_icon"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(sidebarClick) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _leftBtn;
}
- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:@"青岛" forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:15 * SCREEN_SCALE_375];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(locationClick) forControlEvents:UIControlEventTouchUpInside];
            button;
        });
    }
    return _rightBtn;
}
- (YMHomePageView *)homePageView
{
    if (!_homePageView) {
        _homePageView = ({
            YMHomePageView *view = [[YMHomePageView alloc] initWithFrame:self.view.frame];
            __weak typeof(self) weakSelf = self;
            view.bannerBlock = ^(NSInteger index) {
                [weakSelf clickBanner:index];
            };
            view.orderBlock = ^{
                [weakSelf clickOrder];
            };
            view.balanceBlock = ^{
                [weakSelf clickBalance];
            };
            view.evaluateBlock = ^{
                [weakSelf clickEvaluate];
            };
            view;
        });
    }
    return _homePageView;
}
- (YMHomePageViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = ({
            YMHomePageViewModel *viewmodel = [[YMHomePageViewModel alloc] init];
            viewmodel;
        });
    }
    return _viewModel;
}
@end
