//
//  YMHomePageViewModel.m
//  XMLY
//
//  Created by 于光超 on 2021/1/29.
//

#import "YMHomePageViewModel.h"

@implementation YMHomePageViewModel
- (NSArray<YMBannerModel *> *)fetchBannerModel
{
    NSArray *bannerArr = @[@"banner1",@"banner2",@"banner3"];
    NSMutableArray *muBanerArr = [NSMutableArray array];
    for (NSString *imageStr in bannerArr) {
        YMBannerModel *model = [[YMBannerModel alloc] init];
        model.bannerStr = imageStr;
        [muBanerArr addObject:model];
    }
    return muBanerArr;
}
- (NSArray<YMItemModel *> *)fetchItemModel
{
    NSArray *itemArr = @[
        @{ @"完成订单" : @"5单" },
        @{ @"账户余额" : @"280元" },
        @{ @"好评" : @"90%" },
    ];
    NSMutableArray *muItemArr = [NSMutableArray array];

    for (NSDictionary *itemDic in itemArr) {
        if (itemDic.allKeys.count > 0) {
            YMItemModel *model = [[YMItemModel alloc] init];
            model.title = itemDic.allKeys.firstObject;
            model.detail = itemDic[model.title];
            [muItemArr addObject:model];
        }
    }
    return muItemArr;
}
@end
