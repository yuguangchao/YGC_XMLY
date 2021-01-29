//
//  YMHomePageView.h
//  XMLY
//
//  Created by 于光超 on 2021/1/28.
//

#import "YMBaseView.h"
#import "YMBannerModel.h"
#import "YMItemModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface YMHomePageView : YMBaseView
@property (nonatomic, copy) void (^bannerBlock)(NSInteger index);
@property (nonatomic, copy) void (^orderBlock)(void);
@property (nonatomic, copy) void (^balanceBlock)(void);
@property (nonatomic, copy) void (^evaluateBlock)(void);
- (void)refreshBanner:(NSArray<YMBannerModel *> *)model;
- (void)refreshItem:(NSArray<YMItemModel *> *)model;
@end

NS_ASSUME_NONNULL_END
