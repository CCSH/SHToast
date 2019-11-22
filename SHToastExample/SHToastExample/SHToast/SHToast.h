//
//  SHToast.h
//  SHToast
//
//  Created by CSH on 2017/8/16.
//  Copyright © 2017年 CSH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - Toast配置
//弹框内部间隔
#define kSHToastEdgeInsets UIEdgeInsetsMake(10, 20, 10, 20)

//弹框整体间隔
#define kSHToastMargin 45

//默认显示时间
#define kSHToastTime 1.0f

//背景颜色
#define kSHToastRGB [[UIColor blackColor] colorWithAlphaComponent:0.6];

//字体颜色
#define kSHToastTextRGB [UIColor whiteColor]
//字体大小
#define kSHToastTextFont [UIFont systemFontOfSize:14]

#pragma mark - push配置
//Push内部间隔
#define kSHPushEdgeInsets UIEdgeInsetsMake(12, 10, 12, 10)

//推送时间
#define kSHPushTime 3.0f

//推送背景颜色
#define kSHPushRGB [[UIColor blackColor] colorWithAlphaComponent:0.86];

//推送标题颜色
#define kSHPushTitleRGB [UIColor lightGrayColor]
//标题字体大小
#define kSHPushTitleFont [UIFont systemFontOfSize:14]

//推送内容颜色
#define kSHPushContentRGB [UIColor whiteColor]
//内容字体大小
#define kSHPushContentFont [UIFont systemFontOfSize:14]

@interface SHToast : NSObject

#pragma mark - Toast (text 可以是 NSString、NSAttributedString)
//中间位置显示
+ (void)showWithText:(id)text;
+ (void)showWithText:(id)text duration:(CGFloat)duration;

//自定义位置显示
+ (void)showWithText:(id)text offset:(CGFloat)offset;
+ (void)showWithText:(id)text offset:(CGFloat)offset duration:(CGFloat)duration;

#pragma mark - Push (title、content 可以是 NSString、NSAttributedString)
+ (void)showPushWithContent:(id)content title:(id)title image:(UIImage *)image block:(void(^)(void))block;
+ (void)showPushWithContent:(id)content title:(id)title image:(UIImage *)image duration:(CGFloat)duration block:(void(^) (void))block;

@end
