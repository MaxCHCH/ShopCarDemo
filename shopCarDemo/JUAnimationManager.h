//
//  JUAnimationManager.h
//  shopCarDemo
//
//  Created by 徐仲平 on 2016/9/30.
//  Copyright © 2016年 徐仲平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "JHSingleton.h"
@interface JUAnimationManager : NSObject
JHSingletonH(JUAnimationManager)

/**
 *  快速实现一个添加购物车的动画
 *
 *  @param goodsView     需要实现动画的View
 *  @param controlView   当前屏幕显示的的View
 *  @param fromPoint     出发点
 *  @param toPoint       终点
 *  @param completeBlock 动画结束后的回调
 */
- (void )ju_shopCarAnimationGoodsView:(UIView *)goodsView contrlView:(UIView *)controlView fromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint animationComplete:(void(^)()) completeBlock;
/**
 *  购物车的跳动效果
 *
 *  @param shopCarn      传入你的购物车View
 *  @param completeBlock 跳动后完成后的回调
 */
- (void)ju_shopCarAnimation:(UIView *)shopCarn animationComplete:(void(^)())completeBlock;
@end
