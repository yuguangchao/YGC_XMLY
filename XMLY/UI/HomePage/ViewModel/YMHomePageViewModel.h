//
//  YMHomePageViewModel.h
//  XMLY
//
//  Created by 于光超 on 2021/1/29.
//

#import <Foundation/Foundation.h>
#import "YMBannerModel.h"
#import "YMItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface YMHomePageViewModel : NSObject
- (NSArray<YMBannerModel *> *)fetchBannerModel;
- (NSArray<YMItemModel *> *)fetchItemModel;
@end

NS_ASSUME_NONNULL_END
