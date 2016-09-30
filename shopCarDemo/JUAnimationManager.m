//
//  JUAnimationManager.m
//  shopCarDemo
//
//  Created by 徐仲平 on 2016/9/30.
//  Copyright © 2016年 徐仲平. All rights reserved.
//

#import "JUAnimationManager.h"
#import <objc/message.h>
@interface JUAnimationManager ()

{
    UIView *_controlView;
    UIView *_shopCar;
}

@property (nonatomic, copy) void (^sportBlcok)();
@property (nonatomic, copy) void (^shopCarBlcok)();
@property (nonatomic, weak) CALayer *goodsLayer;
@property (nonatomic, weak) CALayer *shopCarLayer;
@end
@implementation JUAnimationManager
JHSingletonM(JUAnimationManager)

static void * pathKey = @"pathKey";
static void * shopCarKey = @"shopCarKey";

- (void)ju_shopCarAnimationGoodsView:(UIView *)goodsView contrlView:(UIView *)controlView fromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint animationComplete:(void (^)())completeBlock{
    if (!goodsView) {
        @throw [NSException exceptionWithName:@"未设置商品View" reason:@"请传入一个用来执行动画的View" userInfo:nil];
        return;
    }
    _controlView = controlView;
    self.sportBlcok = completeBlock;
    CALayer *goodsLayer = [CALayer layer];
    goodsLayer.contents = goodsView.layer.contents;
    goodsLayer.bounds = goodsView.bounds;
    goodsLayer.position = fromPoint;
    goodsLayer.anchorPoint = CGPointZero;
    [controlView.layer addSublayer:goodsLayer];
    self.goodsLayer = goodsLayer;
    UIBezierPath *sportPath = [UIBezierPath bezierPath];
    [sportPath moveToPoint:fromPoint];
#warning 此处设置你的贝塞尔曲线控制点
    CGPoint controlPoint = CGPointMake(fromPoint.x + 300, fromPoint.y - 100);
    [sportPath addQuadCurveToPoint:toPoint controlPoint:controlPoint];
    
    
    controlView.userInteractionEnabled = NO;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.path = sportPath.CGPath;
    pathAnimation.rotationMode = kCAAnimationRotateAuto;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    objc_setAssociatedObject(pathAnimation, pathKey, @"path", OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    CABasicAnimation *largenAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    largenAnimation.toValue = @(2.0);
    largenAnimation.beginTime = 0;
    largenAnimation.duration = 0.5;
    
    CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    narrowAnimation.fromValue = @(2.0);
    narrowAnimation.toValue = @(0);
    narrowAnimation.beginTime = 0.5;
    narrowAnimation.duration = 1.5;
    group.animations = @[pathAnimation,largenAnimation,narrowAnimation];
    group.duration = 2.0;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.delegate = self;
    [goodsLayer addAnimation:group forKey:@"group"];
    
}



- (void)ju_shopCarAnimation:(UIView *)shopCar animationComplete:(void (^)())completeBlock{
    _shopCar = shopCar;
    self.shopCarBlcok = completeBlock;
    _shopCar.userInteractionEnabled = NO;
    CABasicAnimation *shopCarAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    shopCarAnimation.fromValue = @(-5);
    shopCarAnimation.toValue = @(5);
    shopCarAnimation.duration = 0.25;
    shopCarAnimation.delegate = self;
    [shopCar.layer addAnimation:shopCarAnimation forKey:@"shopCar"];
    self.shopCarLayer = shopCar.layer;
    objc_setAssociatedObject(shopCarAnimation, shopCarKey, @"shopCar", OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)getPropertyValue:(void *)key object:(id)object{
    NSString *value = objc_getAssociatedObject(object, key);
    return value;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if ([anim isKindOfClass:[CAAnimationGroup class]]) {
        CAAnimationGroup *group = (CAAnimationGroup *)anim;
        if ([[self getPropertyValue:pathKey object:group.animations.firstObject] isEqualToString:@"path"]) {
            [_goodsLayer removeAnimationForKey:@"group"];
            [_goodsLayer removeFromSuperlayer];
            _controlView.userInteractionEnabled = YES;
            if (!_sportBlcok) return;
            _sportBlcok();
        }
        
    }else if ([[self getPropertyValue:shopCarKey object:anim] isEqualToString:@"shopCar"]){
        _shopCar.userInteractionEnabled = YES;
        [_shopCarLayer removeAnimationForKey:@"shopCar"];
        [_shopCarLayer removeFromSuperlayer];
        if ((!_shopCarBlcok)) return;
        _shopCarBlcok();
    }
}



@end
