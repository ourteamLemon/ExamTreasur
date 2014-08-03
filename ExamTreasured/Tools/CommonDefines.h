//
//  NSObject_CommonDefines.h
//  ExamTreasured
//
//  Created by mac on 14-5-15.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0

#define MAINSCREEDN     [UIScreen mainScreen].bounds

#define m_AppDelegate (((AppDelegate*)[UIApplication sharedApplication].delegate))
#define  DOCUMENT               [NSHomeDirectory() stringByAppendingString:@"/Documents/"]

#define AUTOLOGIN       @"autologinFlag"

#define SAVEPASSWORD    @"savepasswd"


#define UPLOADTOPIC     @"uploadtopic"
/**
 获取屏幕的大小
 */
#define MAINSCREENRECT      [[UIScreen mainScreen] bounds]
#define MAINSCREENWIDTH     [[UIScreen mainScreen] bounds].size.width
#define MAINSCREENHEIGHT    [[UIScreen mainScreen] bounds].size.height


#pragma mark 定义通知
/**
 添加对象到数组中
 */
#define ADDARRAYOBJECT   @"addarrayobject"

