//
//  ViewController.m
//  shopCarDemo
//
//  Created by 徐仲平 on 2016/9/30.
//  Copyright © 2016年 徐仲平. All rights reserved.
//
#import "ViewController.h"
#import "JUAnimationManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UIButton *shopCarButton;
@property (nonatomic, strong) CALayer *goodsLayer;
@property (weak, nonatomic) IBOutlet UIView *shopCarSuperView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [[JUAnimationManager sharedJUAnimationManager] ju_shopCarAnimationGoodsView:_goodsImageView contrlView:self.view fromPoint:_goodsImageView.frame.origin toPoint:CGPointMake(_shopCarButton.frame.origin.x,_shopCarSuperView.frame.origin.y + _shopCarButton.frame.origin.y) animationComplete:^{
        
        [[JUAnimationManager sharedJUAnimationManager] ju_shopCarAnimation:_shopCarButton animationComplete:^{
            NSLog(@"执行完毕");
        }];
    }];
    
}

@end
