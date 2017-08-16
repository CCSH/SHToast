//
//  SHToast.m
//  SHToast
//
//  Created by CSH on 2017/8/16.
//  Copyright © 2017年 CSH. All rights reserved.
//

#import "SHToast.h"

@interface SHToast ()
{
    NSString *_text;
    UIButton *_contentView;
    CGFloat _duration;
}

@end

@implementation SHToast

#pragma mark 公共方法
- (void)deviceOrientationDidChanged:(NSNotification *)not{
    [self dismissToast];
}

- (void)dismissToast{
    [_contentView removeFromSuperview];
}

- (void)setDuration:(CGFloat) duration{
    _duration = duration;
}

#pragma mark - 吐丝
#pragma mark 实例化
- (id)initWithText:(NSString *)text{
    
    if (self = [super init]) {
        
        _text = [text copy];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        CGSize textSize = [text boundingRectWithSize:CGSizeMake(window.frame.size.width - 4*kSHToastMargin, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kSHToastTextFont} context:nil].size;
        
        //内容
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSHToastMargin, 0, textSize.width + kSHToastMargin, textSize.height + 10)];
        textLabel.opaque = YES;
        textLabel.textColor = kSHToastTextColor;
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = kSHToastTextFont;
        textLabel.text = text;
        textLabel.numberOfLines = 0;
        
        //背景
        _contentView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, textLabel.frame.size.width + 2*kSHToastMargin, textLabel.frame.size.height)];
        _contentView.layer.cornerRadius = 5.0f;
        _contentView.layer.borderWidth = 1.0f;
        _contentView.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
        _contentView.backgroundColor = kSHToastBackGroundColor;
        [_contentView addSubview:textLabel];
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_contentView addTarget:self
                        action:@selector(toastClick:)
              forControlEvents:UIControlEventTouchDown];
        _contentView.alpha = 0.0f;
        
        _duration = kSHToastTime;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(deviceOrientationDidChanged:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:[UIDevice currentDevice]];
    }
    return self;
}

#pragma mark 点击提示框
- (void)toastClick:(UIButton *)sender{
    [self hideAnimation];
}

#pragma mark 显示动画
- (void)showAnimation{
    [UIView beginAnimations:@"show" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.3];
    _contentView.alpha = 1.0f;
    [UIView commitAnimations];
}

#pragma mark 隐藏动画
- (void)hideAnimation{
    [UIView beginAnimations:@"hide" context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(dismissToast)];
    [UIView setAnimationDuration:0.3];
    _contentView.alpha = 0.0f;
    [UIView commitAnimations];
}

#pragma mark 进行显示
- (void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _contentView.center = window.center;
    [window  addSubview:_contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:_duration];
}

#pragma mark 显示方法
- (void)showFromTopOffset:(CGFloat)top{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _contentView.center = CGPointMake(window.center.x, top + _contentView.frame.size.height/2);
    [window  addSubview:_contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:_duration];
}

- (void)showFromBottomOffset:(CGFloat)bottom{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _contentView.center = CGPointMake(window.center.x, window.frame.size.height- (bottom + _contentView.frame.size.height/2));
    [window  addSubview:_contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:_duration];
}

+ (void)showWithText:(NSString *)text{
    [SHToast showWithText:text duration:kSHToastTime];
}

+ (void)showWithText:(NSString *)text
            duration:(CGFloat)duration{
    SHToast *toast = [[SHToast alloc] initWithText:text];
    [toast setDuration:duration];
    [toast show];
}

+ (void)showWithText:(NSString *)text
           topOffset:(CGFloat)topOffset{
    [SHToast showWithText:text topOffset:topOffset duration:kSHToastTime];
}

+ (void)showWithText:(NSString *)text
           topOffset:(CGFloat)topOffset
            duration:(CGFloat)duration{
    SHToast *toast = [[SHToast alloc] initWithText:text];
    [toast setDuration:duration];
    [toast showFromTopOffset:topOffset];
}

+ (void)showWithText:(NSString *)text
        bottomOffset:(CGFloat)bottomOffset{
    [SHToast showWithText:text bottomOffset:bottomOffset duration:kSHToastTime];
}

+ (void)showWithText:(NSString *)text
        bottomOffset:(CGFloat)bottomOffset
            duration:(CGFloat)duration{
    SHToast *toast = [[SHToast alloc] initWithText:text];
    [toast setDuration:duration];
    [toast showFromBottomOffset:bottomOffset];
}

#pragma mark - 上方推拉
#pragma mark 实例化
- (id)initTopWithText:(NSString *)text{
    
    if (self = [super init]) {

        _text = [text copy];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        CGSize textSize = [text boundingRectWithSize:CGSizeMake(window.frame.size.width - 2*kSHToastMargin, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kSHToastTopTextFont} context:nil].size;
        
        //内容
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(kSHToastMargin, 20, textSize.width, textSize.height + 10)];
        textLabel.opaque = YES;
        textLabel.textColor = kSHToastTopTextColor;
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = kSHToastTopTextFont;
        textLabel.text = text;
        textLabel.numberOfLines = 0;
        
        //背景
        _contentView = [[UIButton alloc] initWithFrame:CGRectMake(0, -textLabel.frame.size.height - 20, window.frame.size.width, textLabel.frame.size.height + 20)];
        _contentView.backgroundColor = kSHToastTopBackGroundColor;
        [_contentView addSubview:textLabel];
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_contentView addTarget:self
                         action:@selector(toastTopClick)
               forControlEvents:UIControlEventTouchDown];

        _duration = kSHToastTime;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(deviceOrientationDidChanged:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:[UIDevice currentDevice]];
    }
    return self;
}

#pragma mark 显示动画
- (void)showTopAnimation{
    
    __block CGRect frame = _contentView.frame;
    
    [UIView animateWithDuration:0.3 animations:^{
   
        frame.origin.y = 0;
        _contentView.frame = frame;
    }];
}

#pragma mark 隐藏动画
- (void)hideTopAnimation{
    
    __block CGRect frame = _contentView.frame;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        frame.origin.y = -frame.size.height;
        _contentView.frame = frame;
    }completion:^(BOOL finished) {
        [self dismissToast];
    }];
}

#pragma mark 点击提示框
- (void)toastTopClick{
    [self hideTopAnimation];
}

#pragma mark 进行显示
- (void)showTop{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_contentView];
    [self showTopAnimation];
    [self performSelector:@selector(hideTopAnimation) withObject:nil afterDelay:_duration];
}

#pragma mark 显示方法
+ (void)showTopWithText:(NSString *)text{
    [SHToast showTopWithText:text duration:kSHToastTime];
}

+ (void)showTopWithText:(NSString *)text
               duration:(CGFloat)duration{
    
    SHToast *toast = [[SHToast alloc]initTopWithText:text];
    [toast setDuration:duration];
    [toast showTop];
}

@end
