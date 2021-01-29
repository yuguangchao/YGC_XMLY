
#import "YMCarouselView.h"
#import "YMGloableDefine.h"

@interface YMCarouselView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView*scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSArray<UIImage *> *images;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat scrollVWidth;
@property (nonatomic, assign) NSInteger imageCount;
@end

@implementation YMCarouselView
- (instancetype)initWithimages:(NSArray<UIImage *> *)images {
    if (self = [super init]) {
        if (images.count > 0) {
            NSMutableArray *mutImages = [NSMutableArray arrayWithArray:images];
            [mutImages addObject:images.firstObject];
            [mutImages insertObject:images.lastObject atIndex:0];
            self.images = mutImages;
            self.scrollVWidth = SCREEN_WIDTH;
            self.imageCount = self.images.count;
            [self setUPUI];
            [self addUIConstraint];
            [self startTimer];
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
#pragma mark - 定时器

- (void)startTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}
- (void)nextImage
{
        CGFloat currentX = self.scrollView.contentOffset.x;
        CGFloat nextX = currentX + self.scrollVWidth;
        
        if (nextX == (self.imageCount - 1) * self.scrollVWidth) {
            
            [UIView animateWithDuration:0.2 animations:^{
                self.scrollView.contentOffset = CGPointMake(nextX, 0);
            } completion:^(BOOL finished) {
                self.scrollView.contentOffset = CGPointMake(self.scrollVWidth, 0);
                self.pageControl.currentPage = 0;
            }];
        }else{
            [UIView animateWithDuration:0.2 animations:^{
                self.scrollView.contentOffset = CGPointMake( nextX, 0);
                self.pageControl.currentPage = self.scrollView.contentOffset.x / self.scrollVWidth - 1;
            } completion:^(BOOL finished) {

//                //改变对应的分页控件显示圆点
//                self.pageControl.currentPage = self.scrollView.contentOffset.x / self.scrollVWidth - 1;
            }];
        }
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //31231
    if (scrollView == self.scrollView) {
        
        CGFloat currentPoint_x = scrollView.contentOffset.x;
        
            if (currentPoint_x == (self.imageCount - 1) * self.scrollVWidth) {
                scrollView.contentOffset = CGPointMake(self.scrollVWidth, 0);
                }
                
            if (currentPoint_x == 0) {
                scrollView.contentOffset = CGPointMake((self.imageCount - 2) * self.scrollVWidth, 0);
            }
        
         CGFloat newPoint_x = scrollView.contentOffset.x;
        self.pageControl.currentPage = newPoint_x / self.scrollVWidth - 1;
    }
}
#pragma mark - tap
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
            CGFloat height = 140*SCREEN_SCALE_375;
            UIScrollView *view = [[UIScrollView alloc] init];
            view.delegate = self;
            view.showsVerticalScrollIndicator = NO;
            view.showsHorizontalScrollIndicator = NO;
            view.pagingEnabled = YES;
            view.scrollEnabled = YES;
            view.bounces = NO;
            view.contentSize = CGSizeMake(self.scrollVWidth * self.imageCount, height);
            view.contentOffset = CGPointMake(self.scrollVWidth, 0);
            
            for (int i = 0; i < self.imageCount; i++) {
                UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.scrollVWidth * i, 0,self.scrollVWidth, height)];
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
            UIPageControl *control = [[UIPageControl alloc] init];
            control.numberOfPages = self.imageCount-2;
            control.currentPage = 0;
            control.currentPageIndicatorTintColor = [UIColor orangeColor];
            control.pageIndicatorTintColor = [UIColor grayColor];
            control;
        });
    }
    return _pageControl;
}
@end
