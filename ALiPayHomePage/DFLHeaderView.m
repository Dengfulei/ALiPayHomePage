//
//  HeaderView.m
//  ALiPayHomePage
//
//  Created by 杭州移领 on 17/1/20.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import "DFLHeaderView.h"

@interface DFLHeaderView ()


@end

@implementation DFLHeaderView

- (NSArray *)titles {
    
    return @[@"扫码",@"付款",@"卡券",@"定位"];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        for (NSInteger i = 0; i < [[self titles] count]; i ++) {
            CGRect frame = CGRectMake((self.frame.size.width - 4 * 60)/5 + ((self.frame.size.width - 4 * 60)/5 +60) * i, 60, 60, 60);
            
            UIButton *button = [[UIButton alloc] initWithFrame:frame];
            [button setTitle:[self titles][i] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor redColor];
            button.tag = i;
            [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            button.layer.cornerRadius = 30;
            button.layer.masksToBounds = YES;
            [self addSubview:button];
        }
    }
    return self;
}

- (void)click:(UIButton *)button {
    NSLog(@"%ld",(long)button.tag);
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
        
        CGPoint convertedPoint = [subview convertPoint:point fromView:self];
        UIView *hitTestView = [subview hitTest:convertedPoint withEvent:event];
        if (hitTestView) {
            return hitTestView;
        }
    }
    return [super hitTest:point withEvent:event];
}




@end
