//
//  LoginViewController.m
//  ExamTreasured
//
//  Created by mac on 14-5-10.
//  Copyright (c) 2014年 mac. All rights reserved.
//
#define i2s(s) [NSString stringWithFormat:@"%d", s]
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ReadAndWrite.h"
#import "ForgetPasswordVC.h"
#import "AppDelegate.h"
@interface LoginViewController ()
{
    NSMutableDictionary *_infoDict;

}
@end

@implementation LoginViewController
@synthesize nameTextField = _nameTextField,pwdTextField = _pwdTextField;
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
    [self addNaviRightBtn];
    self.view.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    
    //点击退出键盘
    returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = self.view.frame;
    [returnBtn setBackgroundColor:[UIColor clearColor]];
    if ([_nameTextField isFirstResponder] || [_pwdTextField isFirstResponder]) {
        returnBtn.hidden = NO;
    }
    else{
        returnBtn.hidden = YES;
    }
    [returnBtn addTarget:self action:@selector(returnBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnBtn];
    
    [self setNavgation];
    [self initializationTextView];
    [self initializationAotuLoginBtn];
    [self initializationFreeBtn];
    [self checkRememberPassword];
}
- (void)initializationBackBtn
{
    
    
}
- (void)initializationTextView{
    CGRect  rect ;
    CGPoint point;
    //icon
    rect = CGRectMake(0, 0, 65, 75);
    point = CGPointMake(160, 45);
    UIView *iconView = [[UIView alloc]initWithFrame:rect];
    iconView.center = point;
    iconView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_icon.png"]];
    [self.view addSubview:iconView];
    
    //账号密码view
    rect = CGRectMake(0, 0, 280, 80);
    point = CGPointMake(160, 130);
    UIView *nameAndPwdView = [[UIView alloc]initWithFrame:rect];
    nameAndPwdView.center = point;
    nameAndPwdView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_textfieldbg.png"]];
    [self.view addSubview:nameAndPwdView];
    
    //账号
    rect = CGRectMake(0, 0, 45, 20);
    point = CGPointMake(30, 20);
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:rect];
    nameLabel.center = point;
    nameLabel.text = @"账号:";
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textAlignment = NSTextAlignmentRight;
    [nameAndPwdView addSubview:nameLabel];
    
    rect = CGRectMake(0, 0, 220, 20);
    point = CGPointMake(175, 20);
    _nameTextField = [[UITextField alloc]initWithFrame:rect];
    _nameTextField.center = point;
    _nameTextField.textAlignment = NSTextAlignmentLeft;
    _nameTextField.placeholder = @"输入您的账号";
    _nameTextField.delegate = self;
    _nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    [nameAndPwdView addSubview:_nameTextField];
    
    //密码
    rect = CGRectMake(0, 0, 45, 20);
    point = CGPointMake(30, 60);
    UILabel *pwdLabel = [[UILabel alloc]initWithFrame:rect];
    pwdLabel.center = point;
    pwdLabel.text = @"密码:";
    pwdLabel.textColor = [UIColor blackColor];
    pwdLabel.backgroundColor = [UIColor clearColor];
    pwdLabel.textAlignment = NSTextAlignmentRight;
    [nameAndPwdView addSubview:pwdLabel];
    
    rect = CGRectMake(0, 0, 220, 20);
    point = CGPointMake(175, 60);
    _pwdTextField = [[UITextField alloc]initWithFrame:rect];
    _pwdTextField.center = point;
    _pwdTextField.placeholder = @"输入您的密码";
    _pwdTextField.secureTextEntry = YES;
    _pwdTextField.delegate = self;
    _pwdTextField.clearButtonMode = UITextFieldViewModeWhileEditing; //编辑时会出现个修改X
    _pwdTextField.textAlignment = NSTextAlignmentLeft;
    [nameAndPwdView addSubview:_pwdTextField];

}
- (void)initializationAotuLoginBtn{
    CGRect  rect ;
    CGPoint point;
    
    //保存密码
    rect = CGRectMake(0, 0, 25, 28);
    point = CGPointMake(65, 200);
    savePwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    savePwdBtn.frame = rect;
    savePwdBtn.center = point;
    [savePwdBtn setBackgroundImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [savePwdBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    savePwdBtn.tag = 120;
    [self.view addSubview:savePwdBtn];
    
    rect = CGRectMake(0, 0, 80, 28);
    point = CGPointMake(125, 200);
    UILabel *saveLabel = [[UILabel alloc]initWithFrame:rect];
    saveLabel.center = point;
    saveLabel.textColor = [UIColor blackColor];
    saveLabel.backgroundColor = [UIColor clearColor];
    saveLabel.text = @"保存密码";
    [self.view addSubview:saveLabel];
    
    //自动登录
    rect = CGRectMake(0, 0, 25, 28);
    point = CGPointMake(185, 200);
    UIButton *aotuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    aotuBtn.frame = rect;
    aotuBtn.center = point;
    aotuBtn.tag = 1;
    [aotuBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [aotuBtn setBackgroundImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [self.view addSubview:aotuBtn];
    
    rect = CGRectMake(0, 0, 80, 28);
    point = CGPointMake(245, 200);
    UILabel *aotuLabel = [[UILabel alloc]initWithFrame:rect];
    aotuLabel.center = point;
    aotuLabel.text = @"自动登录";
    aotuLabel.textColor = [UIColor blackColor];
    aotuLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:aotuLabel];

    //登录按钮
    rect = CGRectMake(0, 0, 225, 40);
    point = CGPointMake(160, 250);
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = rect;
    loginBtn.center = point;
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"button_unpress9.png"] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"button_press9.png"] forState:UIControlStateHighlighted];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.tag =3;
    [loginBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
}
- (void)initializationFreeBtn{
    CGRect  rect ;
    CGPoint point;
    
    //免费注册
    rect = CGRectMake(0, 0, 80, 28);
    point = CGPointMake(100, 295);
    UIButton *freeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    freeBtn.frame = rect;
    freeBtn.center = point;
    [freeBtn setTitle:@"免费注册" forState:UIControlStateNormal];
    freeBtn.tag = 2;
    [freeBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [freeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.view addSubview:freeBtn];

    //line
    rect = CGRectMake(0, 0, 1, 15);
    point = CGPointMake(160, 295);
    UIView *line = [[UIView alloc]initWithFrame:rect];
    line.center = point;
    line.backgroundColor = [UIColor blackColor];
    [self.view addSubview:line];
    
    //找回密码
    rect = CGRectMake(0, 0, 80, 28);
    point = CGPointMake(220, 295);
    UIButton *goBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    goBackBtn.frame = rect;
    goBackBtn.center = point;
    [goBackBtn setTitle:@"找回密码" forState:UIControlStateNormal];
    [goBackBtn addTarget:self action:@selector(gobackbtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [goBackBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:goBackBtn];

    //第三方登录  qq登录
    rect = CGRectMake(0, 0, 30, 30);
    point = CGPointMake(90, 330);
    UIButton *qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    qqBtn.frame = rect;
    qqBtn.center = point;
    [qqBtn addTarget:self action:@selector(QQBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [qqBtn setBackgroundImage:[UIImage imageNamed:@"qq_logo"] forState:UIControlStateNormal];
    [self.view addSubview:qqBtn];

    //line
    rect = CGRectMake(0, 0, 1, 15);
    point = CGPointMake(125, 330);
    UIView *line1 = [[UIView alloc]initWithFrame:rect];
    line1.center = point;
    line1.backgroundColor = [UIColor blackColor];
    [self.view addSubview:line1];

    //新浪登录
    rect = CGRectMake(0, 0, 30, 30);
    point = CGPointMake(160, 330);
    UIButton *sinaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sinaBtn.frame = rect;
    sinaBtn.center = point;
    [sinaBtn setBackgroundImage:[UIImage imageNamed:@"sina_logo"] forState:UIControlStateNormal];
    [sinaBtn addTarget:self action:@selector(sinaBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sinaBtn];
    
    //line
    rect = CGRectMake(0, 0, 1, 15);
    point = CGPointMake(195, 330);
    UIView *line2 = [[UIView alloc]initWithFrame:rect];
    line2.center = point;
    line2.backgroundColor = [UIColor blackColor];
    [self.view addSubview:line2];

    //人人登录
    rect = CGRectMake(0, 0, 30, 30);
    point = CGPointMake(230, 330);
    UIButton *renrenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    renrenBtn.frame = rect;
    renrenBtn.center = point;
    [renrenBtn setBackgroundImage:[UIImage imageNamed:@"renren_logo"] forState:UIControlStateNormal];
    [renrenBtn addTarget:self action:@selector(renrenBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:renrenBtn];

    //logo
    rect = CGRectMake(0, 0, 320, 20);
    point = CGPointMake(160, IOS7?self.view.frame.size.height-10-44-20:self.view.frame.size.height-20-44);
    UILabel *logoLabel = [[UILabel alloc]initWithFrame:rect];
    logoLabel.center = point;
    logoLabel.text =@"©2014南京风尚信息科技有限公司.版权所有.";
    logoLabel.font = [UIFont systemFontOfSize:11.0f];
    logoLabel.backgroundColor = [UIColor clearColor];
    logoLabel.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1];
    logoLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:logoLabel];
    
}
-(void)renrenBtnClick:(UIButton *)sender
{
    [ShareSDK cancelAuthWithType:ShareTypeRenren];
    [self login:ShareTypeRenren];
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
- (void)QQBtnPressed:(UIButton*)sender
{
    [ShareSDK cancelAuthWithType:ShareTypeQQSpace];
    [self login:ShareTypeQQSpace];
   
}
- (void)login:(ShareType )_shareType
{
    
    loginemum = _shareType;
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    [ShareSDK getUserInfoWithType:_shareType
                      authOptions:authOptions
                           result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
                               
                               if (result)
                               {
                                   [_infoDict removeAllObjects];
                                   [self fillSinaWeiboUser:userInfo];
                                   NSLog(@"------useerinfo%@",userInfo.nickname);
                                   
                                   NSString   *string;
                                   NSString   *typeStr;
                                   switch (loginemum)
                                   {
                                       case 1:
                                           string = Sina;
                                           typeStr = @"Sina";
                                           break;
                                       case 6:
                                           string = QQ;
                                           typeStr = @"QQ";
                                           break;
                                       case 7:
                                           string = renren;
                                           typeStr = @"Renren";
                                           break;
                                   }
                                   
                                   NSDictionary  *dic = [[NSDictionary alloc]initWithObjectsAndKeys:string,@"user.PLATFORM_ID",userInfo.nickname ,@"user.USERNAME",typeStr ,@"user.PLATFORM",nil];
                                   [self thirdlogin:dic];
                               }
                               
                           }];

}

- (void)setNavgation
{
    [self addNaviLeftBtnWithImageName:@"back" andFrame:CGRectMake(0, 2,30,30) target:self action:@selector(backController)];
    
    [self setNaviTitle:@"登陆"];
    UIImage *nav_background = [UIImage imageNamed:@"navgation"];
    [self setNaviBackGroundWithImage:nav_background];
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

- (void)btnPressed:(id)sender
{
    UIButton *tempBtn = (UIButton*)sender;
    switch (tempBtn.tag) {
        case 120:
        {
            m_AppDelegate.savePwd = !m_AppDelegate.savePwd;
            if (m_AppDelegate.savePwd) {
                [tempBtn setBackgroundImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateNormal];
            }
            else{
                [tempBtn setBackgroundImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
            }

        }
            break;
        case 1:
        {
            m_AppDelegate.aotuLogin = !m_AppDelegate.aotuLogin;
            if (m_AppDelegate.aotuLogin) {
                [tempBtn setBackgroundImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateNormal];
            }
            else{
                [tempBtn setBackgroundImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
            }
            
        }
            break;
        case 2:
        {
            RegisterViewController  *regiVC = [[RegisterViewController alloc]initWithtitle:@"注册"];
            [self.navigationController pushViewController:regiVC animated:YES];
        }
            break;
        case 3:
        {
                NSDictionary  *dic = [[NSDictionary alloc]initWithObjectsAndKeys:_nameTextField.text,@"user.ACCOUNT",
                                      _pwdTextField.text,@"user.PASSWORD",nil];
                MKNetworkOperation *op =   [m_AppDelegate.networkEngineinstace  getdata:dic path:LOGINACTION httpMethod:GET];
                
                [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
                 {
                     NSDictionary *dic = [completedOperation responseJSON];
                     NSMutableDictionary *writedic = [dic mutableCopy];
                     NSLog(@"%@",[dic objectForKey:@"message"]);
                     if ([dic allKeys].count>2 )
                     {
                         NSString *returnStr = [dic objectForKey:@"message"];
                         [self showMBProgressHUDByString:returnStr];
                         
                         m_AppDelegate.yh_ID = [dic objectForKey:YH_ID];
                         m_AppDelegate.username = [dic objectForKey:USERNAME];
                         m_AppDelegate.login_ID = [dic objectForKey:LOGIN_ID];
                         m_AppDelegate.isLog = YES;
                         NSNumber  *autologinFlag = [NSNumber numberWithBool:m_AppDelegate.aotuLogin];
                         [writedic setObject:autologinFlag forKey:AUTOLOGIN];
                        
                         NSNumber  *remberPassword = [NSNumber numberWithBool:m_AppDelegate.savePwd];
                         [writedic setObject:remberPassword forKey:SAVEPASSWORD];
                         
                         [writedic setObject:self.pwdTextField.text   forKey:PASSWORD];
                         
                         ReadAndWrite  *rdwr = [[ReadAndWrite alloc]init];
                         [rdwr deleteDocument];
                         [rdwr writePlistFile:writedic];
                         //需要做一步检查权限
                         [self checkUserAuthority];
                      
                     }
                     else
                     {
                         MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                         hud.mode = MBProgressHUDModeText;
                         hud.labelText = [dic objectForKey:@"message"];
                         [hud hide:YES afterDelay:2];
                     }
                     
                 } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
                     
                 }];

        }
            break;
        default:
            break;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([_pwdTextField isFirstResponder])
    {
        [_pwdTextField resignFirstResponder];
    }
    if ([_nameTextField isFirstResponder])
    {
        [_pwdTextField becomeFirstResponder];
    }
    if ([_nameTextField isFirstResponder] || [_pwdTextField isFirstResponder]) {
        returnBtn.hidden = NO;
    }
    else{
        returnBtn.hidden = YES;
    }

    return YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    returnBtn.hidden = NO;
    return  YES;
}

- (void)returnBtnPressed
{
    [_pwdTextField resignFirstResponder];
    [_nameTextField resignFirstResponder];
}

-(void)sinaBtnPressed:(id)sender

{
    [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
    [self login:ShareTypeSinaWeibo];
}
- (void)fillSinaWeiboUser:(id<ISSPlatformUser>)userInfo
{
    NSArray *keys = [[userInfo sourceData] allKeys];
    for (int i = 0; i < [keys count]; i++)
    {
        NSString *keyName = [keys objectAtIndex:i];
        id value = [[userInfo sourceData] objectForKey:keyName];
        if (![value isKindOfClass:[NSString class]])
        {
            if ([value respondsToSelector:@selector(stringValue)])
            {
                value = [value stringValue];
            }
            else
            {
                value = @"";
            }
        }
        
        if ([keyName isEqualToString:@"id"])
        {
            [_infoDict setObject:value forKey:@"UID"];
        }
        else if([keyName isEqualToString:@"idstr"])
        {
            [_infoDict setObject:value forKey:NSLocalizedString(@"TEXT_UID_STR", @"字符串型UID")];
        }
        else if([keyName isEqualToString:@"screen_name"])
        {
            [_infoDict setObject:value forKey:NSLocalizedString(@"TEXT_NICKNAME", @"用户昵称")];
        }
        else if([keyName isEqualToString:@"name"])
        {
            [_infoDict setObject:value forKey:NSLocalizedString(@"TEXT_SCREEN_NAME", @"显示名称")];
        }
        else if([keyName isEqualToString:@"province"])
        {
            [_infoDict setObject:value forKey:NSLocalizedString(@"TEXT_PROVINCE_ID", @"省级ID")];
        }
        else if([keyName isEqualToString:@"city"])
        {
            [_infoDict setObject:value forKey:NSLocalizedString(@"TEXT_CITY_ID", @"城市ID")];
        }
        else if([keyName isEqualToString:@"location"])
        {
            [_infoDict setObject:value forKey:NSLocalizedString(@"TEXT_LOCATION", @"所在地")];
        }
        else if([keyName isEqualToString:@"description"])
        {
            [_infoDict setObject:value forKey:NSLocalizedString(@"TEXT_DESCRIPTION", @"个人描述")];
        }
        else if([keyName isEqualToString:@"url"])
        {
            [_infoDict setObject:value forKey:NSLocalizedString(@"TEXT_BLOG_URL", @"博客地址")];
        }
        else if([keyName isEqualToString:@"profile_image_url"])
        {
            [_infoDict setObject:value forKey:NSLocalizedString(@"TEXT_AVATAR_URL", @"头像地址")];
        }
        else if([keyName isEqualToString:@"profile_url"])
        {
            [_infoDict setObject:value forKey:NSLocalizedString(@"TEXT_WEIBO_URL", @"微博统一URL地址")];
        }
        else if([keyName isEqualToString:@"domain"])
        {
            [_infoDict setObject:value forKey:NSLocalizedString(@"TEXT_CUSTOM_DOMAIN", @"个性化域名")];
        }
        else if([keyName isEqualToString:@"weihao"])
        {
            [_infoDict setObject:value forKey:NSLocalizedString(@"TEXT_WEIHAO", @"微号")];
        }
        else if([keyName isEqualToString:@"gender"])
        {
            [_infoDict setObject:value forKey:NSLocalizedString(@"TEXT_GENDER", @"性别")];
        }
        else if([keyName isEqualToString:@"followers_count"])
        {
            [_infoDict setObject:value forKey:NSLocalizedString(@"TEXT_FANS_COUNT", @"粉丝数")];
        }
        else if([keyName isEqualToString:@"friends_count"])
        {
            [_infoDict setObject:value forKey:NSLocalizedString(@"TEXT_FOLLOW_COUNT", @"关注数")];
        }
        else if([keyName isEqualToString:@"statuses_count"])
        {
            [_infoDict setObject:value forKey:NSLocalizedString(@"TEXT_WEIBO_COUNT", @"微博数")];
        }
        else if([keyName isEqualToString:@"favourites_count"])
        {
            [_infoDict setObject:value forKey:NSLocalizedString(@"TEXT_FAV_COUNT", @"收藏数")];
        }
        else if([keyName isEqualToString:@"created_at"])
        {
            [_infoDict setObject:value forKey:NSLocalizedString(@"TEXT_REG_TIME", @"注册时间")];
        }
        else if([keyName isEqualToString:@"following"])
        {
            [_infoDict setObject:value forKey:@"following"];
        }
        else if([keyName isEqualToString:@"allow_all_act_msg"])
        {
            [_infoDict setObject:value forKey:NSLocalizedString(@"TEXT_ALLOW_SEND_LETTER", @"是否允许给我发私信")];
        }
        else if([keyName isEqualToString:@"geo_enabled"])
        {
            [_infoDict setObject:value forKey:NSLocalizedString(@"TEXT_ALLOW_GEO", @"是否允许标识地理位置")];
        }
        else if([keyName isEqualToString:@"verified"])
        {
            [_infoDict setObject:value forKey:NSLocalizedString(@"TEXT_IS_WEIBO_VERIFIED_USER", @"是否是微博认证用户")];
        }
        else if([keyName isEqualToString:@"verified_type"])
        {
            [_infoDict setObject:value forKey:@"verified_type"];
        }
        else if([keyName isEqualToString:@"remark"])
        {
            [_infoDict setObject:value forKey:NSLocalizedString(@"TEXT_REMARK", @"备注信息")];
        }
        else if([keyName isEqualToString:@"allow_all_comment"])
        {
            [_infoDict setObject:value forKey:NSLocalizedString(@"TEXT_ALLOW_COMMENT_STATUS", @"是否允许对我的微博进行评论")];
        }
        else if([keyName isEqualToString:@"avatar_large"])
        {
            [_infoDict setObject:value forKey:NSLocalizedString(@"TEXT_LARGE_AVATAR_URL", @"大头像地址")];
        }
        else if([keyName isEqualToString:@"verified_reason"])
        {
            [_infoDict setObject:value forKey:NSLocalizedString(@"TEXT_VERIFIED_REASON", @"认证原因")];
        }
        else if([keyName isEqualToString:@"follow_me"])
        {
            [_infoDict setObject:value forKey:NSLocalizedString(@"TEXT_FOLLOW_ME", @"是否关注我")];
        }
        else if([keyName isEqualToString:@"online_status"])
        {
            [_infoDict setObject:value forKey:NSLocalizedString(@"TEXT_ONLINE_STATUS", @"在线状态")];
        }
        else if([keyName isEqualToString:@"bi_followers_count"])
        {
            [_infoDict setObject:value forKey:NSLocalizedString(@"TEXT_BI_FOLLOWER_COUNT", @"互粉数")];
        }
        else if([keyName isEqualToString:@"lang"])
        {
            [_infoDict setObject:value forKey:NSLocalizedString(@"TEXT_LANG", @"语言版本")];
        }
    }
    NSLog(@"-----dic%@",_infoDict);
    

}


- (void)gobackbtnEvent:(id)sender
{
    ForgetPasswordVC  *forgetVC = [[ForgetPasswordVC alloc]initWithHTTP:@"www.baidu.com"];
    [self.navigationController pushViewController: forgetVC animated: YES];
}

//第三方登陆
- (void)thirdlogin:(NSDictionary *)dic
{
    
    MKNetworkOperation *op = [m_AppDelegate.networkEngineinstace  getdata:dic path:USER_LOGIN_FOR_THIRPARY httpMethod:GET];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *dic = [completedOperation responseJSON];
        
        NSLog(@"%@",[dic objectForKey:@"message"]);
        
        if ([[dic objectForKey:@"message"]isEqualToString:@"登陆成功"])
        {
            NSMutableDictionary *dicss = [[NSMutableDictionary alloc]initWithDictionary:dic];
            [dicss removeObjectForKey:@"message"];
            ReadAndWrite *readVC = [[ReadAndWrite alloc]init];
            [readVC deleteDocument];
            [readVC writePlistFile:dicss];
            
            m_AppDelegate.yh_ID = [dic objectForKey:@"yh_id"];
            m_AppDelegate.username = [dic objectForKey:@"username"];
            m_AppDelegate.login_ID = [dic objectForKey:@"login_id"];
            [m_AppDelegate  enterMianViewController];
        }
        else
        {
            UIAlertView  *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:[dic objectForKey:@"message"]delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alertView show];
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
    }];
    
    
}

//    zy_id=1
//    yh_id=272  用户ID  登陆给返回

-(void)checkUserAuthority
{
    NSDictionary  *ProfessionDic = [[NSDictionary alloc]initWithObjectsAndKeys:m_AppDelegate.zy_ID,@"zy_id",m_AppDelegate.yh_ID,@"yh_id",nil];
    MKNetworkOperation *op = [m_AppDelegate.networkEngineinstace  getdata:ProfessionDic path:UserHavePreWithProfession httpMethod:POST];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *resultDic = [completedOperation responseJSON];
        
        if ([resultDic objectForKey:IS_HAVE])
        {
            m_AppDelegate.ishaveAuthority = [[resultDic objectForKey:IS_HAVE]boolValue];
            
            NSNumber  *ishaveAuthority = [NSNumber numberWithBool:m_AppDelegate.ishaveAuthority];
            ReadAndWrite  *readWridte = [[ReadAndWrite alloc]init];
            NSMutableDictionary *readdic = [readWridte readPlistFile];
            [readdic setObject:ishaveAuthority forKey:IS_HAVE];
            [readWridte writePlistFile:readdic];

        }
        else
        {
            
        }
        [self backController];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)checkRememberPassword
{
    ReadAndWrite  *read = [[ReadAndWrite alloc]init];
    NSMutableDictionary *dictionary = [read readPlistFile];
    if (!dictionary )
    {
        return;
    }
    
    self.nameTextField.text = [dictionary objectForKey:KEY_ACCOUNT];
  
    if ([[dictionary objectForKey:SAVEPASSWORD]boolValue] == YES)
    {
               //写密码  lys
        m_AppDelegate.savePwd = [[dictionary objectForKey:SAVEPASSWORD]boolValue];
        self.pwdTextField.text = [dictionary objectForKey:PASSWORD];
        UIButton  *btn = (UIButton *)[self.view viewWithTag:120];
        [btn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    }
    
    return  ;
}
@end
