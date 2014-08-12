//
//  AppDelegate.h
//  ExamTreasured
//
//  Created by mac on 14-5-10.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "LeftViewController.h"
#import "MiddleViewController.h"
#import "NetworkEngine.h"
#import <ShareSDK/ShareSDK.h>
#define QQ      @"101100683"
#define Sina    @"1010521261"
#define renren  @"268503"

@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate>
{
    MMDrawerController *drawerController;
    LeftViewController *leftVC;
    MiddleViewController *middleVC;
    Reachability  *ok;
    UINavigationController *navleft;
    NSArray *allProfession;
    //保存密码
    BOOL _savePwd;
    //自动登录
    BOOL _aotuLogin;
    NSDictionary *updatedic;
    NSString *_yh_ID;
    NSString *_login_ID;
    NSString *_username;
    NSString *_zy_ID;
    NSDictionary *_zyDic;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MMDrawerController *drawerController;
@property (strong, nonatomic) NetworkEngine   *networkEngineinstace;
@property (assign) BOOL savePwd;
@property (assign) BOOL aotuLogin;
@property (assign) BOOL isLog;
/**
 *  是否有权限   1表示有
 */
@property (assign, nonatomic) BOOL  ishaveAuthority;

/*!
 *(
 {"IS_USE""ZY_ID" "ZY_LX""ZY_MC"  "ZY_NF" "ZY_XF"  })
 */
@property (strong, nonatomic) NSArray *allProfession;
//用户ID
@property (strong, nonatomic) NSString *yh_ID;
//登陆ID
@property (strong, nonatomic) NSString *login_ID;
//用户名称
@property (strong, nonatomic) NSString *username;
//职业ID
@property (strong, nonatomic) NSString *zy_ID;

@property (strong, nonatomic) NSDictionary *zyDic;

@property (strong, nonatomic) MiddleViewController *middleVC;
//uuid
@property (strong, nonatomic) NSString  *UUidStr;



- (void)enterLoginView;
- (void)enterMianViewController;
/** 壓縮到指定的尺寸，完全填充不會有空白 */
+ (UIImage *) clipImage: (UIImage *)image clipSize:(CGSize)clipSize;
/** 壓縮到指定的尺寸，可能會有空白 */
+ (UIImage *) miniImage: (UIImage *)image maxSize:(CGSize)maxSize;
- (UIImage *) loadWebImage:(NSString*)urlStr;
- (UIImage *) formartForName:(NSString*)sName;

- (void)customShareMenuClickHandler:(UIButton *)sender;
- (NSString *)KeyChianItem;

- (void)assignmentAppvalue;
@end
