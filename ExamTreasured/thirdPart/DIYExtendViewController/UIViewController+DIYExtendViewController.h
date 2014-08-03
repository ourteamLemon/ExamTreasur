//
//  UIViewController+DIYExtendViewController.h
//  ExamTreasured
//
//  Created by mac on 14-5-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (DIYExtendViewController)
//自定义ios7 ios6的rect
- (CGRect)returnFrame:(CGRect) ios7Rect  ios6:(CGRect)ios6Rect;
//设置naviTitle
- (void)setNaviTitle:(NSString *)iTitle;
//设置naviLeftBtn 设置图片
- (void)addNaviLeftBtnWithImageName:(NSString*)imageName andFrame:(CGRect)rect target:(id)aTarget action:(SEL)action;
//设置naviLeftBtn 设置文字
- (void)addNaviLeftBtnWithName:(NSString*)iName andFrame:(CGRect)rect target:(id)aTarget action:(SEL)action;
//设置nav的背景图
- (void)setNaviBackGroundWithImage:(UIImage *)iImage;
//提示文字显示3秒
- (void)showMBProgressHUDByString:(NSString*)title;
//设置naviRightBtn 设置文字
- (void)addNaviRightBtn;

@end
