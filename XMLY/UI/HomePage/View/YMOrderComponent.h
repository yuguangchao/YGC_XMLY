//
//  YMOrderComponent.h
//  XMLY
//
//  Created by 于光超 on 2021/2/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YMOrderComponent : UIView
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, copy) void (^clickBlock)(void);
- (instancetype)initWithImageArr:(NSArray<UIImage *> *)imageArr title:(NSString *)title defaultImage:(UIImage *)defaultImage;
- (void)startAnimation;
- (void)stopAnimation;
@end

NS_ASSUME_NONNULL_END
