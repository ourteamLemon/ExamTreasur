//
//  CustomButton.m
//  ExamTreasured
//
//  Created by yuan on 14-5-27.
//  Copyright (c) 2014年 yuan. All rights reserved.
//

#import "UIButton+UIButtonImageWithLable.h"
#import "UIImageView+WebCache.h"
@implementation UIButton (UIButtonImageWithLable)
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType {
    //UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
    
//    CGSize titleSize = [title sizeWithFont:[UIFont systemFontOfSize:12.0]];
//    [self.imageView setContentMode:UIViewContentModeCenter];
//    [self setImageEdgeInsets:UIEdgeInsetsMake(-8.0,
//                                              0.0,
//                                              0.0,
//                                              -titleSize.width)];
//    [self setImage:image forState:stateType];
//    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(100.0,
                                              0.0,
                                              0.0,
                                              0.0)];
    [self setTitle:title forState:stateType];
}

@end
