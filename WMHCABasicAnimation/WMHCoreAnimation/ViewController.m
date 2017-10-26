//
//  ViewController.m
//  WMHCoreAnimation
//
//  Created by Archer on 2017/10/20.
//  Copyright © 2017年 Archer. All rights reserved.
//

#define SCREENWIDTH self.view.bounds.size.width
#define SCREEHEIGHT self.view.bounds.size.height
#define MAX_SIZE 20
#define FPS  30.0

#import "ViewController.h"

@interface ViewController ()<CAAnimationDelegate>
{
    NSInteger oldTag;
    UIImageView *backImgView;
}
@property(nonatomic, assign)NSInteger count;
@property(getter=isRemovedOnCompletion) BOOL removedOnCompletion;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.count = 0;
    oldTag = 10000;
    
    //创建背景
    backImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREEHEIGHT)];
    backImgView.image = [UIImage imageNamed:@"backBg"];
    [self.view addSubview:backImgView];
    
    [NSTimer scheduledTimerWithTimeInterval:20 / FPS target:self selector:@selector(createUI) userInfo:nil repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:30 / FPS target:self selector:@selector(createUI2) userInfo:nil repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:40 / FPS target:self selector:@selector(createUI3) userInfo:nil repeats:YES];
    [self createUI];
}

- (void)createUI{
    UIImageView *sakura1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sakura1"]];
    CGFloat size = arc4random() % MAX_SIZE + MAX_SIZE;
    sakura1.frame = CGRectMake(arc4random() % (int)SCREENWIDTH, arc4random() % (int)SCREEHEIGHT, size, size);
    [sakura1.layer addAnimation:[self basicAnimationAction] forKey:@"hahah"];
    [backImgView addSubview:sakura1];
    self.count++;
    sakura1.tag = self.count + 10000;
    
    if (sakura1.tag > 200) {
        UIImageView *oldImg = (id)[self.view viewWithTag:sakura1.tag - 200];
        [oldImg removeFromSuperview];
        oldImg = nil;
    }
}

- (void)createUI2{
    UIImageView *sakura2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sakura1"]];
    CGFloat size = arc4random() % MAX_SIZE + MAX_SIZE;
    sakura2.frame = CGRectMake(arc4random() % (int)SCREENWIDTH, arc4random() % (int)SCREEHEIGHT, size, size);
    [sakura2.layer addAnimation:[self basicAnimationAction2] forKey:@"hahah"];
    [backImgView addSubview:sakura2];
    self.count++;
    sakura2.tag = self.count + 20000;
    
    if (sakura2.tag > 10) {
        UIImageView *oldImg = (id)[self.view viewWithTag:sakura2.tag - 10];
        [oldImg removeFromSuperview];
        oldImg = nil;
    }
}

- (void)createUI3{
    //创建一片雪花
    UIImageView *sakura3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sakura1"]];
    //雪花的大小随机生成
    CGFloat size = arc4random() % MAX_SIZE + MAX_SIZE;
    sakura3.frame = CGRectMake(arc4random() % (int)SCREENWIDTH, arc4random() % (int)SCREEHEIGHT, size, size);
    [sakura3.layer addAnimation:[self basicAnimationAction3] forKey:@"hahah"];
    [backImgView addSubview:sakura3];
    self.count++;
    sakura3.tag = self.count + 30000;
    NSLog(@"snow.tag==========%ld",sakura3.tag);
    
    if (sakura3.tag > 100) {
        UIImageView *oldImg = (id)[self.view viewWithTag:sakura3.tag - 100];
        [oldImg removeFromSuperview];
        oldImg = nil;
    }
}

//可以散布整个底部的花瓣
- (CAAnimationGroup *)basicAnimationAction{
    CABasicAnimation *positionAni1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    positionAni1.duration = 3.0;
    positionAni1.fromValue = [NSNumber numberWithFloat:0.0];
    positionAni1.toValue = [NSNumber numberWithFloat:M_PI];
    
    /*
     kCAMediaTimingFunctionLinear （匀速）
     kCAMediaTimingFunctionEaseIn （慢进快出）
     kCAMediaTimingFunctionEaseOut （快进慢出）
     kCAMediaTimingFunctionEaseInEaseOut （慢进慢出，中间加速）
     kCAMediaTimingFunctionDefault （默认
         */
    
    positionAni1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    //设置动画循环无限循环
//    positionAni.repeatCount = HUGE_VALF;
    //设置动画循环持续时间
    positionAni1.repeatDuration = 3.0;
    positionAni1.removedOnCompletion = NO;
    positionAni1.fillMode = kCAFillModeForwards;
    
    
    CABasicAnimation *positionAni2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    positionAni2.duration = 3.0;
    positionAni2.fromValue = [NSNumber numberWithFloat:0.0];
    positionAni2.toValue = [NSNumber numberWithFloat:M_PI];
    positionAni2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    //设置动画循环无限循环
    //设置动画循环持续时间
    positionAni2.repeatDuration = 3.0;
    positionAni2.removedOnCompletion = NO;
    positionAni2.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *positionAni3 = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAni3.duration = 3.0;
    positionAni3.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, arc4random() % 200)];
    float a = arc4random() % 375;
    NSLog(@"%f",a);
    positionAni3.toValue = [NSValue valueWithCGPoint:CGPointMake(a, SCREEHEIGHT - arc4random() % 30)];
    positionAni3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    //设置动画循环无限循环
    //    positionAni.repeatCount = HUGE_VALF;
    //设置动画循环持续时间
    positionAni3.repeatDuration = 3.0;
    positionAni3.removedOnCompletion = NO;
    positionAni3.fillMode = kCAFillModeForwards;
    
    
    CAKeyframeAnimation *positionAni4 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    // 设置动画的路径为心形路径
    positionAni4.path = [self createCurvedLine].CGPath;
    // 动画时间间隔
    positionAni4.duration = 3.0f;
    // 重复次数为最大值
    positionAni4.repeatCount = FLT_MAX;
    positionAni4.removedOnCompletion = NO;
    positionAni4.fillMode = kCAFillModeForwards;
    
    //设置动画组
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 3.0;
    group.repeatCount = 1;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    [group setAnimations:[NSArray arrayWithObjects:positionAni1,positionAni2,positionAni4, nil]];
    
    return group;
}

//屏幕外的花瓣
- (CAAnimationGroup *)basicAnimationAction2{
    CABasicAnimation *positionAni1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    positionAni1.duration = 2.0;
    positionAni1.fromValue = [NSNumber numberWithFloat:0.0];
    positionAni1.toValue = [NSNumber numberWithFloat:M_PI];
    positionAni1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    positionAni1.repeatDuration = 2.0;
    positionAni1.removedOnCompletion = NO;
    positionAni1.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *positionAni2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    positionAni2.duration = 2.0;
    positionAni2.fromValue = [NSNumber numberWithFloat:0.0];
    positionAni2.toValue = [NSNumber numberWithFloat:M_PI];
    positionAni2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    positionAni2.repeatDuration = 2.0;
    positionAni2.removedOnCompletion = NO;
    positionAni2.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *positionAni3 = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAni3.duration = 2.0;
    positionAni3.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, arc4random() % 200)];
    positionAni3.toValue = [NSValue valueWithCGPoint:CGPointMake(375 + arc4random() % 376, SCREEHEIGHT - arc4random() % 30)];
    positionAni3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    positionAni3.repeatDuration = 2.0;
    positionAni3.removedOnCompletion = NO;
    positionAni3.fillMode = kCAFillModeForwards;
    
    //设置动画组
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 2.0;
    group.repeatCount = 1;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    [group setAnimations:[NSArray arrayWithObjects:positionAni1,positionAni2,positionAni3, nil]];
    
    return group;
}

//后半部分的花瓣
- (CAAnimationGroup *)basicAnimationAction3{
    CABasicAnimation *positionAni1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    positionAni1.duration = 2.0;
    positionAni1.fromValue = [NSNumber numberWithFloat:0.0];
    positionAni1.toValue = [NSNumber numberWithFloat:M_PI];
    positionAni1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    positionAni1.repeatDuration = 2.0;
    positionAni1.removedOnCompletion = NO;
    positionAni1.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *positionAni2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    positionAni2.duration = 2.0;
    positionAni2.fromValue = [NSNumber numberWithFloat:0.0];
    positionAni2.toValue = [NSNumber numberWithFloat:M_PI];
    positionAni2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    positionAni2.repeatDuration = 2.0;
    positionAni2.removedOnCompletion = NO;
    positionAni2.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *positionAni3 = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAni3.duration = 2.0;
    positionAni3.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, arc4random() % 200)];
    positionAni3.toValue = [NSValue valueWithCGPoint:CGPointMake(180 + arc4random() % 181, SCREEHEIGHT - arc4random() % 30)];
    positionAni3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    positionAni3.repeatDuration = 2.0;
    positionAni3.removedOnCompletion = NO;
    positionAni3.fillMode = kCAFillModeForwards;
    
    //设置动画组
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 2.0;
    group.repeatCount = 1;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    [group setAnimations:[NSArray arrayWithObjects:positionAni1,positionAni2,positionAni3, nil]];
    
    return group;
}

-(UIBezierPath *)createCurvedLine
{
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    aPath.lineWidth = 5.0;
    aPath.lineCapStyle = kCGLineCapRound; //线条拐角
    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
    [aPath moveToPoint:CGPointMake(0, arc4random() % 200)];
    float a = arc4random() % 375;
    [aPath addQuadCurveToPoint:CGPointMake(a, SCREEHEIGHT - arc4random() % 30) controlPoint:CGPointMake(0, SCREEHEIGHT)];
    
    return aPath;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
