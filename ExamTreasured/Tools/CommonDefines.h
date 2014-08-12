//
//  NSObject_CommonDefines.h
//  ExamTreasured
//
//  Created by mac on 14-5-15.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0

#define m_AppDelegate (((AppDelegate*)[UIApplication sharedApplication].delegate))

#define  DOCUMENT               [NSHomeDirectory() stringByAppendingString:@"/Documents/"]


/*!
 *  PLIST 读取出来的key
 */
#define AUTOLOGIN       @"autologinFlag"
#define SAVEPASSWORD    @"savepasswd"
#define PASSWORD        @"password"
#define UPLOADTOPIC     @"uploadtopic"
#define YH_ID           @"yh_id"
#define USERNAME        @"username"
#define LOGIN_ID        @"login_id"

//是否有权限
#define IS_HAVE         @"isHave"


/**
 *  登陆返回值
 //account = Openj;
 //email = "";
 //"login_id" = E6C138C4E9B9F580613D32AD821715C2;
 //message = "\U767b\U9646\U6210\U529f";
 //"phone_num" = "";
 //platform = "";
 //success = 1;
 //username = Jfkf;
 //"yh_id" = 362;
 */
#define KEY_ACCOUNT  @"account"
#define LOGIN_ID     @"login_id"




/*!
 获取屏幕的大小
 */
#define MAINSCREENRECT      [[UIScreen mainScreen] bounds]
#define MAINSCREENWIDTH     [[UIScreen mainScreen] bounds].size.width
#define MAINSCREENHEIGHT    [[UIScreen mainScreen] bounds].size.height


#pragma mark 定义通知
/*!
 添加对象到数组中
 */
#define ADDARRAYOBJECT   @"addarrayobject"




