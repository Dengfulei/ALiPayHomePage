//
//  DFLRefreshNormalHeader.m
//  MJRefreshAnimation
//
//  Created by 杭州移领 on 17/1/18.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import "DFLRefreshHeader.h"

@interface DFLRefreshHeader ()

@property (nonatomic , strong) UILabel *label;

@property (nonatomic , strong) UIImageView *imageView;

@end

@implementation DFLRefreshHeader

- (void)prepare {
    [super prepare];
    //设置header高度
    self.backgroundColor = [UIColor yellowColor];
    self.mj_h = 50;
    UILabel *label = [UILabel new];
    label.textColor = [UIColor  blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:12];
    [self addSubview:label];
    self.label = label;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"arrow"];
    imageView.layer.masksToBounds = YES;
    [self addSubview:imageView];
    self.imageView = imageView;
}

//在这里设置控件的frame
- (void)placeSubviews {
    [super placeSubviews];
    self.label.frame = CGRectMake((self.frame.size.width - 100) / 2, -40, 100, 50);
     self.imageView.frame = CGRectMake((self.frame.size.width - 30) / 2, 5, 30, 30);
    self.imageView.layer.cornerRadius = 15;
}

- (void)scrollViewPanStateDidChange:(NSDictionary *)change {
    
    [super scrollViewPanStateDidChange:change];
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
    
    [super scrollViewContentSizeDidChange:change];
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    
    [super scrollViewContentOffsetDidChange:change];
}

- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState;

    switch (state) {
        case MJRefreshStateIdle:
           
            self.label.text = @"我的生活";
            [self endAnimation];
            break;
        case MJRefreshStatePulling:
            self.label.text = @"我的生活";
            [self endAnimation];
            break;

        case MJRefreshStateRefreshing:
            self.label.text = @"我的生活";
            [self startAnimation];
            break;
        default:
            break;
    }
}

- (void)startAnimation {
    
    CABasicAnimation *basicAni= [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAni.duration = 1;
    basicAni.repeatCount = MAXFLOAT;
    basicAni.toValue = @(M_PI * 2);
    [self.imageView.layer addAnimation:basicAni forKey:nil];
}

- (void)endAnimation
{
    [self.imageView.layer removeAllAnimations];
}
@end
