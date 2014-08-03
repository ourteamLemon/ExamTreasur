//
//  CustomButton.h
//  ExamTreasured
//
//  Created by yuan on 14-5-27.
//  Copyright (c) 2014年 yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GongLueModel.h"
@interface UIButton (UIButtonImageWithLable)

- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType;

@end
