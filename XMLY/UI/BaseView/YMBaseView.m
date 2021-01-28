//
//  YMBaseView.m
//  XMLY
//
//  Created by 于光超 on 2021/1/28.
//

#import "YMBaseView.h"
#import "YMGloableDefine.h"
@interface YMBaseView ()

@end
@implementation YMBaseView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor YM_ColorWithRed:191 green:191 blue:191 alpha:1];
    }
    return self;
}
@end
