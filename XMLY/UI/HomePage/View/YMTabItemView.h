//
//  YMTabItemView.h
//  XMLY
//
//  Created by 于光超 on 2021/1/29.
//

#import <UIKit/UIKit.h>
#import "YMItemModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface YMTabItemView : UIView
@property (nonatomic, copy) void (^clickBlock)(void);
- (void)refreshTabItem:(YMItemModel *)model;

@end

NS_ASSUME_NONNULL_END
