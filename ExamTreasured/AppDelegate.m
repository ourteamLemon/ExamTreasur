//
//  AppDelegate.m
//  ExamTreasured
//
//  Created by mac on 14-5-10.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "CollectViewController.h"
#import "PayViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <Parse/Parse.h>
#import <RennSDK/RennClient.h>
#import <Crashlytics/Crashlytics.h>
#import "UMSocial.h"
#import "AlixPayResult.h"
#import "KeychainItemWrapper.h"
#import <Security/SecItem.h>

@implementation AppDelegate
@synthesize drawerController = drawerController;
@synthesize aotuLogin = _aotuLogin;
@synthesize savePwd = _savePwd;
@synthesize zy_ID = _zy_ID;
@synthesize zyDic = _zyDic;
@synthesize middleVC;
@synthesize allProfession;
@synthesize login_ID = _login_ID;
@synthesize username = _username;
@synthesize yh_ID = _yh_ID;
@synthesize UUidStr;
@synthesize ishaveAuthority;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window                 = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.networkEngineinstace   = [[NetworkEngine alloc]initWithHostName:HOST portNumber:PROT apiPath:nil customHeaderFields:nil];
    
    [self initAppvalue];
    [self initththirdPart];
    [self enterMianViewController];
    [Crashlytics startWithAPIKey:@"0d408bcd977f800691e4f63493abf44da3adc9f9"];
    [self.window makeKeyAndVisible];
    [self checkVersion];
     return YES;
}


/***********设置第三方平台使用***********/
-(void)initththirdPart
{
//    [[Crashlytics sharedInstance]crash];
    
    [ShareSDK registerApp:@"1c3280d5db94"];
    [UMSocialData setAppKey:@"53a5b3a156240bbe780b0d47"];
    [UMSocialData openLog:YES];
    
    [ShareSDK connectQZoneWithAppKey:@"101100683"
                           appSecret:@"fc70f70c18d3b036afeb876fec889685"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    
    [ShareSDK connectSinaWeiboWithAppKey:@"1010521261" appSecret:@"914066e25aaaa31f7629c3bd6679fed8" redirectUri:@"http://www.baidu.com"];
    
    [ShareSDK connectRenRenWithAppId:@"267761" appKey:@"3d2cb85feeca4b279473b442e608ad7c" appSecret:@"5648276daa454d9d85b9ced43accce07" renrenClientClass:[RennClient class]];
    
    [Parse setApplicationId:@"GAvNvSHdGt5Gd37vkZ8ugsoda0OcZ5iocuerrfsR"
                  clientKey:@"GyGpkDhqIl78fwZXmHzReGvaA25fpg5CD1ITW8R7"];
    
}
 

/*************设备唯一号*********/
- (NSString *)KeyChianItem
{
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"Password" accessGroup:nil];
    NSString *udidstr = [wrapper objectForKey:(id)kSecAttrAccount];
    if (!udidstr || [udidstr isEqualToString:@""])
    {
        [wrapper resetKeychainItem];
        udidstr = [NSString uniqueString];
        [wrapper setObject:udidstr forKey:(id)kSecAttrAccount];
    }
    return udidstr;
    
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void)enterMianViewController
{
    leftVC = [[LeftViewController alloc]init];
    navleft = [[UINavigationController alloc]initWithRootViewController:leftVC];
    navleft.navigationBarHidden = YES;
    //中间的选项
    middleVC = [[MiddleViewController alloc]init];
    UINavigationController *NavMiddleVC = [[UINavigationController alloc]initWithRootViewController:middleVC];
    
    drawerController = [[MMDrawerController alloc] initWithCenterViewController: NavMiddleVC leftDrawerViewController:navleft ];
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [drawerController setMaximumLeftDrawerWidth:240];
    [self.window setRootViewController:drawerController];
    
    [drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController1, MMDrawerSide drawerSide, CGFloat percentVisible) {
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [MMDrawerVisualState parallaxVisualStateBlockWithParallaxFactor:2.0];
        block(drawerController1, drawerSide, percentVisible);
    }];
}

-(void)enterLoginView
{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.type = kCATransitionReveal;
    animation.subtype = kCATransitionFromTop;
    [self.window.layer addAnimation:animation forKey:@"animation"];
    
    
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    UINavigationController  *Navlogin = [[UINavigationController alloc]initWithRootViewController:loginVC];
    self.window.rootViewController = Navlogin;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    [self parse:url application:application];
    [ShareSDK handleOpenURL:url wxDelegate:nil];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:nil];
}
+ (UIImage *) clipImage: (UIImage *)image clipSize:(CGSize)clipSize
{
    float clipFloatX=clipSize.width/image.size.width;
    float clipFloatY=clipSize.height/image.size.height;
    float clipFloat = clipFloatX>clipFloatY ? clipFloatX : clipFloatY;
    
    CGSize size = clipSize;
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    transform = CGAffineTransformScale(transform, clipFloat, clipFloat);
    CGContextConcatCTM(context, transform);
    
    // Draw the image into the transformed context and return the image
    //20121204Modify移动图片到中间显示
    if((image.size.height-(((image.size.height*clipFloat-clipSize.height)/2.0)/clipFloat)*clipFloat) > clipSize.height&&clipFloatY<clipFloat)
    {
        [image drawAtPoint:CGPointMake(0.0f, -((image.size.height*clipFloat-clipSize.height)/2.0)/clipFloat)];
    }
    else if((image.size.width*clipFloat-(((image.size.width*clipFloat-clipSize.width)/2.0)/clipFloat)*clipFloat) > clipSize.width&&clipFloatX<clipFloat)
    {
        [image drawAtPoint:CGPointMake(-((image.size.width*clipFloat-clipSize.width)/2.0)/clipFloat,0.0f)];
    }
    else
    {
        [image drawAtPoint:CGPointMake(0.0f,0.0f)];
    }
    //20121204Modify
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}
/**
 根據給定的壓縮比例進行圖片壓縮
 @param  image 需要壓縮的圖片
 @param  scaleFloat 制定的壓縮比例
 @return UIImage* 壓縮后的圖片
 */
+ (UIImage *) miniImage: (UIImage *)image maxSize:(CGSize)maxSize
{
    float scaleFloatX=maxSize.width/image.size.width;
    float scaleFloatY=maxSize.height/image.size.height;
    float scaleFloat = scaleFloatX<scaleFloatY ? scaleFloatX : scaleFloatY;
    
    if (scaleFloat >= 1.0f)
    {
        return image;
    }
    CGSize size = CGSizeMake(image.size.width * scaleFloat, image.size.height * scaleFloat);
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    transform = CGAffineTransformScale(transform, scaleFloat, scaleFloat);
    CGContextConcatCTM(context, transform);
    
    // Draw the image into the transformed context and return the image
    [image drawAtPoint:CGPointMake(0.0f, 0.0f)];
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}




//版本检查
-(void)checkVersion
{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"IOS",@"App_os",nil];
    MKNetworkOperation *op = [m_AppDelegate.networkEngineinstace  getdata:dic path:APP_GETLATEST httpMethod:GET];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
         updatedic   = [[NSDictionary alloc]initWithDictionary:[completedOperation responseJSON]];
        if ([[updatedic objectForKey:@"app_version"]intValue ] > [app_Version intValue])
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"有新版本，是否更新" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"确定", nil];
            [alert show];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        
        
    }];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[updatedic objectForKey:@"app_url"]]];
    }
}

- (UIImage *) loadWebImage:(NSString*)urlStr
{
    UIImage* image=[UIImage imageNamed:@"sysmain_bg.png"];
    
    NSArray *pathArr = [urlStr componentsSeparatedByString:@"/"];
    NSString *namePath = [pathArr objectAtIndex:[pathArr count]-1];//图片名字，进行缓存
    NSString *userPath = [DOCUMENT stringByAppendingString:namePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:userPath]){
        //图片存在直接读取
        NSData *data = [NSData dataWithContentsOfFile:userPath];
        if (data!=nil) {
            image = [[UIImage alloc]initWithData:data];
        }
        return image;
    }
    else{
        //图片不存在需要下载
        NSURL* url = [NSURL URLWithString:urlStr];//网络图片url
        
        NSData* data = [NSData dataWithContentsOfURL:url];//获取网咯图片数据
        [data writeToFile:userPath atomically:YES];
        if(data!=nil)
        {
            image = [[UIImage alloc] initWithData:data];//根据图片数据流构造image
        }
        return image;
    }
}
- (UIImage *)formartForName:(NSString*)sName
{
    NSString *tempName = [NSString stringWithFormat:@"%@",sName];
    if (!isIPhone5) {
        tempName = [NSString stringWithFormat:@"%@4",tempName];
    }
    UIImage *tempImage = [UIImage imageNamed:tempName];
    return tempImage;
}


- (void)customShareMenuClickHandler:(UIButton *)sender
{
    
}



- (void)initializePlatForTrusteeship
{
    ///#begin zh-cn
    //导入QQ互联和QQ好友分享需要的外部库类型，如果不需要QQ空间SSO和QQ好友分享可以不调用此方法
    ///#end
    ///#begin en
    //Import QQ Connect classes, if not need share to QZone or QQ you can not call this method
    ///#end
    [ShareSDK importQQClass:[QQApiInterface class] tencentOAuthCls:[TencentOAuth class]];
    
    ///#begin zh-cn
    //导入人人网需要的外部库类型,如果不需要人人网SSO可以不调用此方法
    ///#end
    ///#begin en
    //Import RenRen classes, if not need share to RenRen you can not call this method
    ///#end
    [ShareSDK importRenRenClass:[RennClient class]];
    
    ///#begin zh-cn
    //导入腾讯微博需要的外部库类型，如果不需要腾讯微博SSO可以不调用此方法
    ///#end
    ///#begin en
    //Import Tencent Weibo classes, if not need share to Tencent Weibo you can not call this method
    ///#end
//    [ShareSDK importTencentWeiboClass:[WeiboApi class]];
//    
//    ///#begin zh-cn
//    //导入微信需要的外部库类型，如果不需要微信分享可以不调用此方法
//    ///#end
//    ///#begin en
//    //Import WeChat classes, if not need share to WeChat you can not call this method
//    ///#end
//    [ShareSDK importWeChatClass:[WXApi class]];
//    
//    ///#begin zh-cn
//    //导入Google+需要的外部库类型，如果不需要Google＋分享可以不调用此方法
//    ///#end
//    ///#begin en
//    //Import Google+ classes, if not need share to Google+ you can not call this method
//    ///#end
//    [ShareSDK importGooglePlusClass:[GPPSignIn class]
//                         shareClass:[GPPShare class]];
//    
//    ///#begin zh-cn
//    //导入Pinterest需要的外部库类型，如果不需要Pinterest分享可以不调用此方法
//    ///#end
//    ///#begin en
//    //Import Pinterest classes, if not need share to Pinterest you can not call this method
//    ///#end
//    [ShareSDK importPinterestClass:[Pinterest class]];
//    
//    ///#begin zh-cn
//    //导入易信需要的外部库类型，如果不需要易信分享可以不调用此方法
//    ///#end
//    ///#begin en
//    //Import YiXin classes, if not need share to YiXin you can not call this method
//    ///#end
//    [ShareSDK importYiXinClass:[YXApi class]];
}


#pragma mark- 支付宝
//独立客户端回调函数

- (void)parse:(NSURL *)url application:(UIApplication *)application {
    
    //结果处理
    AlixPayResult* result = [self handleOpenURL:url];
    
	if (result)
    {
		
		if (result.statusCode == 9000)
        {
			/*
			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
			 */
            
            //交易成功
            //            NSString* key = @"签约帐户后获取到的支付宝公钥";
            //			id<DataVerifier> verifier;
            //            verifier = CreateRSADataVerifier(key);
            //
            //			if ([verifier verifyString:result.resultString withSign:result.signString])
            //            {
            //                //验证签名成功，交易结果无篡改
            //			}
            
        }
        else
        {
            //交易失败
        }
    }
    else
    {
        //失败
    }
    
}

- (AlixPayResult *)resultFromURL:(NSURL *)url {
	NSString * query = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#if ! __has_feature(objc_arc)
    return [[[AlixPayResult alloc] initWithString:query] autorelease];
#else
	return [[AlixPayResult alloc] initWithString:query];
#endif
}

- (AlixPayResult *)handleOpenURL:(NSURL *)url {
    AlixPayResult * result = nil;

	if (url != nil && [[url host] compare:@"safepay"] == 0)
    {
    result                 = [self resultFromURL:url];
	}

	return result;
}
//
//account = 101100683;
//"login_id" = 9FD61C9C8D9746C4E3F6E41AD5ABDE31;
//message = "\U767b\U9646\U6210\U529f";
//platform = QQ;
//success = 1;
//username = "\U50bb\U74dc";
//"yh_id" = 39;

#pragma 初始化值
-(void)initAppvalue
{
    ReadAndWrite  *read      = [[ReadAndWrite alloc]init];
    NSMutableDictionary *dic = [read readPlistFile];
    if (dic)
    {
        
        self.yh_ID = [[dic objectForKey:@"yh_id"]stringValue];
        self.login_ID = [dic objectForKey:@"login_id"];
        self.username = [dic objectForKey:@"username"];
    }
    else
    {
        self.yh_ID    = [[NSString alloc]init];
        self.login_ID = [[NSString alloc]init];
        self.username = [[NSString alloc]init];
    }
  
    
    if (![dic objectForKey:@"zy_id"])
    {
        self.zy_ID =   @"1";
    }
    else
    {
        self.zy_ID  = [dic objectForKey:@"zy_id"];
    }
    
    self.savePwd   = NO;
    self.aotuLogin = NO;
    UUidStr   = [self KeyChianItem];
}
@end
