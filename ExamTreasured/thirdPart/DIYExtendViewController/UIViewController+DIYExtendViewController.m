//
//  UIViewController+DIYExtendViewController.m
//  ExamTreasured
//
//  Created by mac on 14-5-18.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "UIViewController+DIYExtendViewController.h"

@implementation UIViewController (DIYExtendViewController)
- (CGRect)returnFrame:(CGRect) ios7Rect  ios6:(CGRect)ios6Rect
{
    if (IOS7)
    {
        return ios7Rect;
    }
    else
    {
        return ios6Rect;
    }
}
- (void)setNaviTitle:(NSString *)iTitle
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 230, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
    titleLabel.font = [UIFont boldSystemFontOfSize:20];  //设置文本字体与大小
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.text = iTitle;  //设置标题
    self.navigationItem.titleView = titleLabel;
//    [self.navigationController.navigationBar addSubview:titleLabel];
}
- (void)addNaviLeftBtnWithImageName:(NSString*)imageName andFrame:(CGRect)rect target:(id)aTarget action:(SEL)action
{
    UIButton *_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *_img = [UIImage imageNamed:imageName];
    _backBtn.frame = rect;
    [_backBtn setBackgroundImage:_img forState:UIControlStateNormal];
    [_backBtn addTarget:aTarget action:action forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
}
- (void)addNaviLeftBtnWithName:(NSString*)iName andFrame:(CGRect)rect target:(id)aTarget action:(SEL)action
{
    UIButton *_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = rect;
    [_backBtn setTitle:iName forState:UIControlStateNormal];
    _backBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    _backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_backBtn addTarget:aTarget action:action forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
}
- (void)addNaviRightBtn
{
    UIButton *_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 2,130,30);
    [_backBtn setTitle:@"www.doctorvbook.com" forState:UIControlStateNormal];
    _backBtn.titleLabel.font = [UIFont systemFontOfSize:8.0];
    _backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
}

- (void)setNaviBackGroundWithImage:(UIImage *)iImage
{
    if( [self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        [self.navigationController.navigationBar setBackgroundImage:iImage forBarMetrics:UIBarMetricsDefault];
    } else {
        self.navigationController.navigationBar.layer.contents = (id) iImage.CGImage;
    }
}
- (void)showMBProgressHUDByString:(NSString*)title
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    hud.margin = 5.f;
    hud.yOffset = MAINSCREENHEIGHT/2.0f - 65;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
    [m_AppDelegate.window addSubview:hud];
}

@end
