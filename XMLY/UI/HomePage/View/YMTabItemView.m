//
//  YMTabItemView.m
//  XMLY
//
//  Created by 于光超 on 2021/1/29.
//

#import "YMTabItemView.h"
#import "YMGloableDefine.h"
@interface YMTabItemView ()
@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UILabel *detailL;
@end
@implementation YMTabItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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
    [self addSubview:self.titleL];
    [self addSubview:self.detailL];
}
- (void)addUIConstraint
{
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self).mas_offset(-10*SCREEN_SCALE_375);
    }];
    
    [self.detailL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self).mas_offset(10*SCREEN_SCALE_375);
    }];
}
#pragma mark -refresh
- (void)refreshTabItem:(YMItemModel *)model
{
    self.detailL.text = model.detail;
    self.titleL.text = model.title;
}
#pragma mark -click
- (void)click
{
    if (self.clickBlock) {
        self.clickBlock();
    }
}
#pragma mark -lazy init
- (UILabel *)titleL
{
    if (!_titleL) {
        _titleL = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:12 * SCREEN_SCALE_375];
            label.textColor = [UIColor blackColor];
            label.numberOfLines = 0;
            label.textAlignment = NSTextAlignmentCenter;
            label;
        });
    }
    return _titleL;
}
- (UILabel *)detailL
{
    if (!_detailL) {
        _detailL = ({
            UILabel *label = [[UILabel alloc] init];
            label.font = [UIFont systemFontOfSize:16 * SCREEN_SCALE_375];
            label.textColor = [UIColor orangeColor];
            label.numberOfLines = 0;
            label.textAlignment = NSTextAlignmentCenter;
            label;
        });
    }
    return _detailL;
}
@end
