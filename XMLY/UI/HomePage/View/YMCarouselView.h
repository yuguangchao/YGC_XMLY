
#import <UIKit/UIKit.h>
#import "YMBannerModel.h"
@class YMCarouselView;
@protocol YMCarouselViewDelegate <NSObject>
@optional
/**
 *  点击图片的回调事件
 */
- (void)carouselViewIndexOfClickedImage:(NSInteger)index;
@end

@interface YMCarouselView : UIView
//传入图片数组
- (void)refreshCarousel:(NSArray<YMBannerModel *> *)images;
@property (weak, nonatomic) id<YMCarouselViewDelegate> delegate;

@end
