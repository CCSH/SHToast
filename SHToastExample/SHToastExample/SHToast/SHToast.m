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
    //内容
    UIButton *_contentView;
}

//消失时间
@property (nonatomic, assign) CGFloat duration;

@end

@implementation SHToast

#pragma mark 屏幕旋转通知方法
- (void)deviceOrientationDidChanged:(NSNotification *)not{
    [self dismissToast];
}

- (void)dismissToast{
    [_contentView removeFromSuperview];
}

#pragma mark - 获取内容Size
- (CGSize)getTextSizeWithText:(id)text maxSize:(CGSize)maxSize{
    
    //内容
    if ([text isKindOfClass:[NSString class]]) {//字符串
        
        NSString *str = (NSString *)text;
        return [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:kSHToastTextFont} context:nil].size;
    }else if ([text isKindOfClass:[NSAttributedString class]]){//富文本
        
        NSAttributedString *att = (NSAttributedString *)text;
        return [att boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    }else{//其他
        return CGSizeZero;
    }
}

#pragma mark - 吐丝
#pragma mark 实例化
- (id)initWithText:(id)text{
    
    if (self = [super init]) {
        
        //内容视图
        _contentView = [UIButton buttonWithType:UIButtonTypeCustom];
        _contentView.backgroundColor = kSHToastRGB;
        [_contentView setTitleColor:kSHToastTextRGB forState:0];
        _contentView.titleLabel.font = kSHToastTextFont;
        _contentView.titleLabel.numberOfLines = 0;
        _contentView.alpha = 0.0f;
        [_contentView setTitleEdgeInsets:UIEdgeInsetsMake(kSHToastTextMargin, kSHToastTextMargin, kSHToastTextMargin, kSHToastTextMargin)];
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_contentView addTarget:self action:@selector(hideAnimation) forControlEvents:UIControlEventTouchDown];
        
        _contentView.layer.cornerRadius = 5.0f;
        _contentView.layer.borderWidth = 1.0f;
        _contentView.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;
        
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2*kSHToastMargin - 2*kSHToastTextMargin, CGFLOAT_MAX);
        CGSize textSize = [self getTextSizeWithText:text maxSize:maxSize];
        _contentView.frame = CGRectMake(0, 0, textSize.width + 2*kSHToastTextMargin, textSize.height + 2*kSHToastTextMargin);
        
        //内容
        if ([text isKindOfClass:[NSString class]]) {//字符串
            
            NSString *str = (NSString *)text;
            [_contentView setTitle:str forState:0];
        }else if ([text isKindOfClass:[NSAttributedString class]]){//富文本
            
            NSAttributedString *att = (NSAttributedString *)text;
            [_contentView setAttributedTitle:att forState:0];
        }
        
        //添加旋转通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChanged:) name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
    }
    return self;
}

#pragma mark 显示动画
- (void)showAnimation{
    
    self->_contentView.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        self->_contentView.alpha = 1;
    }];
}

#pragma mark 隐藏动画
- (void)hideAnimation{
    
    self->_contentView.alpha = 1;
    [UIView animateWithDuration:0.3 animations:^{
        self->_contentView.alpha = 0;
    }completion:^(BOOL finished) {
        [self dismissToast];
    }];
}

#pragma mark 自定义位置显示
- (void)showWithOffset:(CGFloat)offset{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _contentView.center = CGPointMake(window.center.x, offset);
    [window  addSubview:_contentView];
    [self showAnimation];
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:self.duration];
}

#pragma mark 显示方法
#pragma mark 中间位置显示
+ (void)showWithText:(id)text{
    
    [SHToast showWithText:text duration:kSHToastTime];
}

+ (void)showWithText:(id)text duration:(CGFloat)duration{
    
    if (!text) {
        return;
    }
    SHToast *toast = [[self alloc] initWithText:text];
    toast.duration = duration;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [toast showWithOffset:window.center.y];
}

#pragma mark 自定义位置显示
+ (void)showWithText:(id)text offset:(CGFloat)offset{
    [SHToast showWithText:text offset:offset duration:kSHToastTime];
}

+ (void)showWithText:(id)text offset:(CGFloat)offset duration:(CGFloat)duration{
    if (!text) {
        return;
    }
    SHToast *toast = [[SHToast alloc] initWithText:text];
    toast.duration = duration;
    [toast showWithOffset:offset];
}

#pragma mark - 上方推拉
#pragma mark 实例化
- (id)initTopWithText:(id)text{
    
    if (self = [super init]) {

        //内容视图
        _contentView = [UIButton buttonWithType:UIButtonTypeCustom];
        _contentView.backgroundColor = kSHToastTopRGB;
        [_contentView setTitleColor:kSHToastTopTextRGB forState:0];
        _contentView.titleLabel.font = kSHToastTopTextFont;
        _contentView.titleLabel.numberOfLines = 0;
         [_contentView setTitleEdgeInsets:UIEdgeInsetsMake([[UIApplication sharedApplication] statusBarFrame].size.height + kSHToastTextMargin, kSHToastTextMargin, kSHToastTextMargin, kSHToastTextMargin)];
        _contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_contentView addTarget:self action:@selector(hideTopAnimation) forControlEvents:UIControlEventTouchDown];
        
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2*kSHToastTextMargin, CGFLOAT_MAX);
        CGSize textSize = [self getTextSizeWithText:text maxSize:maxSize];
        CGFloat content_h = textSize.height + [[UIApplication sharedApplication] statusBarFrame].size.height + 2*kSHToastTextMargin;
        _contentView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, content_h);
        
        //内容
        if ([text isKindOfClass:[NSString class]]) {//字符串
            
            NSString *str = (NSString *)text;
            [_contentView setTitle:str forState:0];
        }else if ([text isKindOfClass:[NSAttributedString class]]){//富文本
            
            NSAttributedString *att = (NSAttributedString *)text;
            [_contentView setAttributedTitle:att forState:0];
        }

        //添加旋转通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChanged:) name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
    }
    return self;
}

#pragma mark 显示动画
- (void)showTopAnimation{
    
    __block CGRect frame = _contentView.frame;
    frame.origin.y = -_contentView.frame.size.height;
    _contentView.frame = frame;
    
    [UIView animateWithDuration:0.3 animations:^{
        frame.origin.y = 0;
        self->_contentView.frame = frame;
    }];
}

#pragma mark 隐藏动画
- (void)hideTopAnimation{
    
    __block CGRect frame = _contentView.frame;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        frame.origin.y = -frame.size.height;
        self->_contentView.frame = frame;
    }completion:^(BOOL finished) {
        [self dismissToast];
    }];
}

#pragma mark 进行显示
- (void)showTop{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_contentView];
    [self showTopAnimation];
    [self performSelector:@selector(hideTopAnimation) withObject:nil afterDelay:self.duration];
}

#pragma mark 显示方法
+ (void)showTopWithText:(id)text{
    [SHToast showTopWithText:text duration:kSHToastTime];
}

+ (void)showTopWithText:(id)text duration:(CGFloat)duration{
    if (!text) {
        return;
    }
    SHToast *toast = [[SHToast alloc]initTopWithText:text];
    [toast setDuration:duration];
    [toast showTop];
}

@end
