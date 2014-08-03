//
//  GongLueViewController.m
//  ExamTreasured
//
//  Created by yuan on 14-5-28.
//  Copyright (c) 2014年 yuan. All rights reserved.
//

#import "GongLueViewController.h"
#import "UMSocialSnsService.h"
#import "UMSocialSnsPlatformManager.h"
#define SendViewHeight 49
#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@interface GongLueViewController ()

@end

@implementation GongLueViewController
@synthesize glModel;
@synthesize pinglunBtn;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
#ifdef __IPHONE_5_0
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 5.0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chatViewChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    }
#endif
    [self addNaviRightBtn];

    [self addNaviLeftBtnWithImageName:@"back" andFrame:CGRectMake(0, 2,30,30) target:self action:@selector(backController)];
    [self setNaviTitle:@"攻略"];
    
    UIImage *nav_background = [UIImage imageNamed:@"navgation"];
    [self setNaviBackGroundWithImage:nav_background];

    
    [self creatWebView];
    // Do any additional setup after loading the view.
}
- (void)backController
{
    if ([self.navigationController.childViewControllers objectAtIndex:0] == self)
    {
        [m_AppDelegate enterMianViewController];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)creatWebView
{
    iWebView = [[UIWebView alloc]init];
    iWebView.frame = CGRectMake(0, 0, 320, 416+(isIPhone5?88:0)-SendViewHeight-40);
    iWebView.delegate = self;
    [self.view addSubview:iWebView];
    iWebView.scrollView.bounces=NO;
    CGRect rect = CGRectMake(0, 0, 225, 40);
    CGPoint point = CGPointMake(160, 416+(isIPhone5?88:0)-SendViewHeight-40+20);
    pinglunBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    pinglunBtn.frame = rect;
    pinglunBtn.center = point;
    [pinglunBtn setBackgroundImage:[UIImage imageNamed:@"button_unpress9.png"] forState:UIControlStateNormal];
    [pinglunBtn setBackgroundImage:[UIImage imageNamed:@"button_press9.png"] forState:UIControlStateHighlighted];
    [pinglunBtn setTitle:@"网友评论" forState:UIControlStateNormal];
    pinglunBtn.tag =3;
    [pinglunBtn addTarget:self action:@selector(pinglunPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pinglunBtn];

    
    
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    if (glModel) {
        NSDictionary  *dic = [[NSDictionary alloc]initWithObjectsAndKeys:glModel.GL_ID,@"gl_id",nil];
        MKNetworkOperation *op =   [m_AppDelegate.networkEngineinstace  getdata:dic path:STRATEGY_GETSTRATEGY httpMethod:POST];
        
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
         {
             NSDictionary *dic = [completedOperation responseJSON];
             if (dic && [dic count]>0) {
                 NSString *urlStr =  [dic objectForKey:@"ps_zw"];
                 glModel.GL_NR = [NSString stringWithString:urlStr];
                 [iWebView loadHTMLString:urlStr baseURL:nil];
                 hub.hidden = YES;
             }
         }errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        }];

    }
    self.sendView = [[UIView alloc]initWithFrame:CGRectMake(0, 416+(isIPhone5?88:0)-SendViewHeight, 320, SendViewHeight)];
    self.sendView.backgroundColor = [UIColor colorWithRed:188/255.0 green:188/255.0 blue:188/255.0 alpha:0.3f];
    [self.view addSubview:self.sendView];
    self.shoucangBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shoucangBtn setFrame:CGRectMake(5, 10, 30 , 30)];
    [self  shoucangChange];
    [self.shoucangBtn addTarget:self action:@selector(shoucangButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.sendView addSubview:self.shoucangBtn];
    
    self.sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sendBtn setFrame:CGRectMake(285, 7, 35, 35)];
    [self.sendBtn setBackgroundImage:[UIImage imageNamed:@"gonglue_send.png"] forState:UIControlStateNormal];
    [self.sendBtn setBackgroundImage:[UIImage imageNamed:@"gonglue_send_h.png"] forState:UIControlStateHighlighted];
    [self.sendBtn addTarget:self action:@selector(sendButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.sendView addSubview:self.sendBtn];
    
    self.messageTextField = [[UITextField alloc]initWithFrame:CGRectMake(75, 9, 200, 31)];
    self.messageTextField.delegate = self;
    [self.messageTextField setBorderStyle:UITextBorderStyleLine];
    self.messageTextField.secureTextEntry = NO;
    [self.messageTextField setBackground:[UIImage imageNamed:@"message_input_voice0.png"]];
    self.messageTextField.autocorrectionType = UITextBorderStyleNone;
    self.messageTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.messageTextField.returnKeyType = UIReturnKeyDone;
    self.messageTextField.placeholder = @"我也说两句";
    //    self.messageTextField.userInteractionEnabled = NO;
    [self.sendView addSubview:self.messageTextField];

    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setFrame:CGRectMake(40, 10, 30, 30)];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"gonglue_share.png"] forState:UIControlStateNormal];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"gonglue_share_h.png"] forState:UIControlStateHighlighted];
    [shareBtn addTarget:self action:@selector(shareBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.sendView addSubview:shareBtn];

}
- (void)shoucangChange
{
    if (glModel) {
        NSString *scId = [NSString stringWithFormat:@"%@",glModel.SC_ID];
        if ([scId intValue]==-1) {
            [self.shoucangBtn setBackgroundImage:[UIImage imageNamed:@"gonglue_sc.png"] forState:UIControlStateNormal];
            [self.shoucangBtn setBackgroundImage:[UIImage imageNamed:@"gonglue_sc_h.png"] forState:UIControlStateHighlighted];
        }
        else{
            [self.shoucangBtn setBackgroundImage:[UIImage imageNamed:@"gonglue_qxsc.png"] forState:UIControlStateNormal];
            [self.shoucangBtn setBackgroundImage:[UIImage imageNamed:@"gonglue_qxsc_h.png"] forState:UIControlStateHighlighted];
        }
    }
}
- (void)shoucangButton:(id)sender{
    if (glModel) {
        NSString *scId = [NSString stringWithFormat:@"%@",glModel.SC_ID];
        if ([scId intValue]==-1) {
            MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            NSDictionary  *dic = [[NSDictionary alloc]initWithObjectsAndKeys:glModel.GL_ID,@"storageStrategy.STRATEGY_ID",m_AppDelegate.yh_ID,@"storageStrategy.YH_ID",m_AppDelegate.zy_ID,@"storageStrategy.ZY_ID",nil];
            MKNetworkOperation *op =   [m_AppDelegate.networkEngineinstace  getdata:dic path:STORAGE_ADDSTRATEGY httpMethod:POST];
            
            [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
             {
                 NSDictionary *dic = [completedOperation responseJSON];
                 if (dic && [dic objectForKey:@"success"]) {
                     [self showMBProgressHUDByString:@"收藏成功"];
                     glModel.SC_ID = [dic objectForKey:@"storageStrategyid"];
                     [self shoucangChange];
                 }
                 hub.hidden = YES;
             } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
                 hub.hidden = YES;
             }];
        }
        else{
            MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            
            NSDictionary  *dic = [[NSDictionary alloc]initWithObjectsAndKeys:scId,@"storageStrategy.ID",nil];
            MKNetworkOperation *op =   [m_AppDelegate.networkEngineinstace  getdata:dic path:STORAGE_DELEGATESTRATEGY httpMethod:POST];
            
            [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
             {
                 NSDictionary *dic = [completedOperation responseJSON];
                 if (dic && [dic objectForKey:@"success"]) {
                     NSString *sssss = [dic objectForKey:@"message"];
                     [self showMBProgressHUDByString:sssss];
                     glModel.SC_ID = @"-1";
                     [self shoucangChange];
                 }
                 hub.hidden = YES;
             } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
                 hub.hidden = YES;
             }];

        }
    }
}
- (void)sendButton:(id)sender {
    
    if (glModel && [self.messageTextField.text length]>0) {
        MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSDictionary  *dic = [[NSDictionary alloc]initWithObjectsAndKeys:glModel.GL_ID,@"raidersCommentVO.ps_id",m_AppDelegate.yh_ID,@"raidersCommentVO.cm_yhid",self.messageTextField.text,@"raidersCommentVO.cm_nr",nil];
        MKNetworkOperation *op =   [m_AppDelegate.networkEngineinstace  getdata:dic path:FORUM_ADDCOMMENT httpMethod:POST];
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
         {
             NSDictionary *dic = [completedOperation responseJSON];
             self.messageTextField.text = @"";
             [self.messageTextField resignFirstResponder];
             [self chatViewChange:nil];
             hub.hidden = YES;
         } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
             
         }];
    }
}

- (void)setGlModel:(GongLueModel *)iglModel
{
    if (iglModel) {
        glModel = iglModel;        
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)chatViewChange:(NSNotification*)notification
{
    int keybardHeight;
    if (notification) {
        NSDictionary *userInfo = [notification userInfo];
        
        NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        
        CGRect keyboardRect = [aValue CGRectValue];
        keybardHeight = keyboardRect.size.height;
    }
    else{
        keybardHeight = 216;
    }
    
    if ([self.messageTextField isFirstResponder]){
        //键盘弹出，界面上述
        int offset = 416+(isIPhone5?88:0)-SendViewHeight - keybardHeight;//键盘高度216
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationDuration:0.30f];
        if(offset > 0)
        {
            CGRect rect = CGRectMake(0, 0,320,offset);
            iWebView.frame = rect;
            
            self.sendView.frame = CGRectMake(0, offset, 320, SendViewHeight);
        }
        [UIView commitAnimations];
        
    }
    else{
        //键盘关闭，界面下降
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        CGRect rect = CGRectMake(0.0f, 0,320,416+(isIPhone5?88:0)-SendViewHeight-40);
        iWebView.frame = rect;
        
        self.sendView.frame = CGRectMake(0, 416+(isIPhone5?88:0)-SendViewHeight, 320, SendViewHeight);
        
        [UIView commitAnimations];
        
    }
}
#pragma mark - UITextField Delegate Mehtods

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self chatViewChange:nil];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.messageTextField resignFirstResponder];
    [self chatViewChange:nil];
    
    return YES;
}

- (void)pinglunPressed:(id)sender
{
    NSDictionary  *dic = [[NSDictionary alloc]initWithObjectsAndKeys:glModel.GL_ID,@"postid",nil];
    MKNetworkOperation *op =   [m_AppDelegate.networkEngineinstace  getdata:dic path:FORUM_GETPOSTINFO httpMethod:POST];
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         NSDictionary *dic = [completedOperation responseJSON];
         if (dic && [dic count]>0) {
             NSLog(@"start  %@",glModel.GL_NR);
             glModel.GL_NR = [NSString stringWithFormat:@"%@%@",glModel.GL_NR,[dic objectForKey:@"ps_zw"]];
             NSLog(@"endln  %@",glModel.GL_NR);
             NSLog(@"ZW   %@",[dic objectForKey:@"ps_zw"]);
             [iWebView loadHTMLString:glModel.GL_NR baseURL:nil];
         }
         hub.hidden = YES;
     } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
         hub.hidden = YES;
     }];
}
- (void)shareBtnPressed:(id)sender
{
//      NSArray *oneKeyShareList = [ShareSDK getShareListWithType:
//    ShareTypeSinaWeibo,
//    ShareTypeTencentWeibo,
//    ShareType163Weibo,
//    ShareTypeDouBan,
//    nil];
//    id<ISSShareOptions> shareOptions = [ShareSDK defaultShareOptionsWithTitle:nil      //分享视图标题
//                                                              oneKeyShareList:oneKeyShareList           //一键分享菜单
//                                                               qqButtonHidden:NO                               //QQ分享按钮是否隐藏
//                                                        wxSessionButtonHidden:NO                   //微信好友分享按钮是否隐藏
//                                                       wxTimelineButtonHidden:NO                 //微信朋友圈分享按钮是否隐藏
//                                                         showKeyboardOnAppear:NO                  //是否显示键盘
//                                                            shareViewDelegate:nil                            //分享视图委托
//                                                          friendsViewDelegate:nil                          //好友视图委托
//                                                        picViewerViewDelegate:nil];                    //图片浏览视图委托
//    
//    id<ISSContent> publishContent = [ShareSDK content:@"fsfd"
//                                       defaultContent:@""
//                                                image:nil
//                                                title:@"ShareSDK"
//                                                  url:@"http://www.sharesdk.cn"
//                                          description:@"这是一条测试信息"
//                                            mediaType:SSPublishContentMediaTypeNews];
//    
//    
//    [ShareSDK showShareActionSheet:nil
//                         shareList:nil
//                           content:publishContent
//                     statusBarTips:YES
//                       authOptions:nil
//                      shareOptions: nil
//                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
//                                if (state == SSResponseStateSuccess)
//                                {
//                                    NSLog(@"分享成功");
//                                }
//                                else if (state == SSResponseStateFail)
//                                {
//                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
//                                }
//                            }];
    [self umscoialmethod];
}

-(void)umscoialmethod
{
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"53a5b3a156240bbe780b0d47"
                                      shareText:@"hjkhklhjlhjklhjklhkljhjklhjllhjlhjlhjklhjlhjklhjlklhjklhjklhjk"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToDouban,UMShareToQzone,UMShareToEmail,UMShareToSms,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToFacebook,UMShareToTwitter,nil]
                                       delegate:nil];
    
}
@end
