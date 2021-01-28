
#import "YMCarouselView.h"
#import "YMGloableDefine.h"

@interface YMCarouselView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView*scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSArray<UIImage *> *images;
@end

@implementation YMCarouselView
- (instancetype)initWithimages:(NSArray<UIImage *> *)images {
    if (self = [super init]) {
        if (images.count) {
            NSMutableArray *mutImages = [NSMutableArray arrayWithArray:images];
            [mutImages addObject:images.firstObject];
            [mutImages insertObject:images.lastObject atIndex:0];
            self.images = mutImages;
            [self setUPUI];
            [self addUIConstraint];
        }
    }
    return self;
}
#pragma mark - setUPUI
- (void)setUPUI
{
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
}

- (void)addUIConstraint
{
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(20*SCREEN_SCALE_375);
    }];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.scrollView) {
        
        CGFloat width = SCREEN_WIDTH;
        NSInteger count = self.images.count;
        
        CGFloat currentPoint_x = scrollView.contentOffset.x;
        
            if (currentPoint_x == (self.images.count - 1) * width) {
                scrollView.contentOffset = CGPointMake(width, 0);
                }
                
            if (currentPoint_x == 0) {
                scrollView.contentOffset = CGPointMake((count - 2) * width, 0);
            }
        
         CGFloat newPoint_x = scrollView.contentOffset.x;
        self.pageControl.currentPage = newPoint_x / width - 1;
    }
}

- (void)imageClick {
    if ([self.delegate respondsToSelector:@selector(carouselViewIndexOfClickedImage:)]){
        [self.delegate carouselViewIndexOfClickedImage:self.pageControl.currentPage];
    }
}
#pragma mark - layz init
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = ({
            
            CGFloat width = SCREEN_WIDTH;
            CGFloat height = 140*SCREEN_SCALE_375;
            NSInteger count = self.images.count;
            
            UIScrollView *view = [[UIScrollView alloc] init];
            view.delegate = self;
            view.showsVerticalScrollIndicator = NO;
            view.showsHorizontalScrollIndicator = NO;
            view.pagingEnabled = YES;
            view.scrollEnabled = YES;
            view.bounces = NO;
            view.contentSize = CGSizeMake(width * count, height);
            view.contentOffset = CGPointMake(width, 0);
            
            for (int i = 0; i < count; i++) {
                UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width * i, 0,width, height)];
                imageView.image=self.images[i];
                imageView.userInteractionEnabled = YES;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageClick)];
                [imageView addGestureRecognizer:tap];
                [view addSubview:imageView];
            }
            view;
        });
    }
    return _scrollView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = ({
            NSInteger count = self.images.count;
            UIPageControl *control = [[UIPageControl alloc] init];
            control.numberOfPages = count-2;
            control.currentPage = 0;
            control.currentPageIndicatorTintColor = [UIColor orangeColor];
            control.pageIndicatorTintColor = [UIColor grayColor];
            control;
        });
    }
    return _pageControl;
}
@end
