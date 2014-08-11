//
//  RegisterViewController.m
//  ExamTreasured
//
//  Created by mac on 14-5-20.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "RegisterViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"
#import "NSString+MD5.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize iTableView;
@synthesize nameTextField,passWdTextField,suerPasswdTextField,neroTextField,emailTextField,phoneNumTextField;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithtitle :(NSString*)titleString
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        [self setNaviTitle:@"注册"];
        [self addNaviRightBtn];
     
    }
    return self;
}

- (void)setNavgation
{
    [self addNaviLeftBtnWithImageName:@"back" andFrame:CGRectMake(0, 2,30,30) target:self action:@selector(backController)];
    
    UIImage *nav_background = [UIImage imageNamed:@"navgation"];
    [self setNaviBackGroundWithImage:nav_background];
}


- (void)backController
{
    if ([self.navigationController.childViewControllers objectAtIndex:0] == self)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setiTextField
{
    nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(100,10 ,200  ,30 )];
    passWdTextField = [[UITextField alloc] initWithFrame:CGRectMake(100,10 ,200  ,30 )];
    suerPasswdTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, 200, 30)];
    
    neroTextField = [[UITextField alloc] initWithFrame:CGRectMake(100,10 ,200  ,30 )];
    emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(100,10 ,200  ,30 )];
    phoneNumTextField = [[UITextField alloc] initWithFrame:CGRectMake(100, 10, 200, 30)];
    
    passWdTextField.secureTextEntry = YES;
    suerPasswdTextField.secureTextEntry = YES;
    
    nameTextField.placeholder = @"邮箱/手机号";
    passWdTextField.placeholder = @"请输入您的密码";
    suerPasswdTextField.placeholder = @"请再输入一遍密码";

    neroTextField.placeholder = @"输入您的呢称";
    emailTextField.placeholder = @"输入您的邮箱";
    phoneNumTextField.placeholder = @"输入您的手机号码";
    
    nameTextField.delegate = self;
    passWdTextField.delegate = self;
    suerPasswdTextField.delegate = self;
    neroTextField.delegate = self;
    emailTextField.delegate = self;
    phoneNumTextField.delegate = self;
    phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
}

-(void)setreturnBtn
{
    UIButton  *returnbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnbtn.frame = self.view.frame;
    [returnbtn addTarget:self action:@selector(regisertbecome) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:returnbtn];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    
    [self setreturnBtn];
    [self setNavgation];
    [self setiTextField];
    [self initiTableView];
    [self initbtn];
    
    
}

- (void)initbtn
{
    UIButton  *registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registBtn.frame= CGRectMake( 0, 0  ,225  ,40 );
    registBtn.center = CGPointMake(160, self.iTableView.frame.size.height+20);
    [registBtn setBackgroundImage:[UIImage imageNamed:@"button_unpress9.png"] forState:UIControlStateNormal];
    [registBtn setBackgroundImage:[UIImage imageNamed:@"button_press9.png"] forState:UIControlStateHighlighted];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(setregisterBtnEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
}

- (void)initiTableView
{
    iTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 230) style:UITableViewStyleGrouped];
    iTableView.delegate = self;
    iTableView.dataSource = self;
    iTableView.scrollEnabled = NO;
    iTableView.layer.cornerRadius = 5;
    
    UIView  *itableViewBack = [[UIView alloc]initWithFrame:iTableView.frame];
    itableViewBack.backgroundColor = [UIColor clearColor];
    iTableView.backgroundView = itableViewBack;

    [self.view addSubview:self.iTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark tableViewdelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==  0)
    {
        return  2;
    }
    else
    {
        return 1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,40)];
        
        UIButton  *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(regisertbecome) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = headview.frame;
        [headview addSubview:btn];
        
        headview.backgroundColor = [UIColor clearColor];
        UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake( 20, 0, 280, 40)];
        [titlelabel setNumberOfLines:0];
        titlelabel.text = @"昵称将显示在本软件互动模块中，请输入常用的邮箱和手机号，用于找回或修改密码！";
        titlelabel.font = [UIFont systemFontOfSize:14];
        titlelabel.textColor = [UIColor blackColor];
        titlelabel.backgroundColor= [UIColor clearColor];
        [headview addSubview:titlelabel];
        return  headview;
    }
    else return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section? 40.0f:0.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    
//    UITableViewCell  *cell = [tableView  dequeueReusableCellWithIdentifier:identifier];

     UITableViewCell*  cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.backgroundView.backgroundColor = [UIColor redColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UILabel *namelabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 90, 30)];
    namelabel.textColor = [UIColor blackColor];
    namelabel.backgroundColor = [UIColor clearColor];
    
    if (indexPath.section == 0)
    {
        switch (indexPath.row)
        {
            case 0:
                {
                    namelabel.text = @"账号:";
                    [cell addSubview:nameTextField];

                }break;
            case 1:
                {
                    namelabel.text = @"密码:";
                    [cell addSubview:passWdTextField];

                }
                break;
            case 2:
                {
                   
                    namelabel.text = @"确定密码：";
                   
                    [cell addSubview:suerPasswdTextField];
                }break;
                
            default:
                break;
        }
    }
    else
    {
      
        switch (indexPath.row) {
            case 0:
                {
                    namelabel.text = @"昵称：";
                    [cell addSubview:neroTextField];
                }
                break;
            case 1:
                {
                    namelabel.text = @"邮箱：";
                    [cell addSubview:emailTextField];

                }
                break;
            case 2:
                {
                    namelabel.text = @"手机号码：";
                    [cell addSubview:phoneNumTextField];
                }
                break;
            default:
                break;
        }
    }
    [cell addSubview:namelabel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self regisertbecome];
}

- (void)regisertbecome
{
    [nameTextField resignFirstResponder];
    [passWdTextField resignFirstResponder];
    [suerPasswdTextField resignFirstResponder];
    [neroTextField resignFirstResponder];
    [emailTextField resignFirstResponder];
    [phoneNumTextField resignFirstResponder];
    
    int ios7Height = IOS7?64:0;
    
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:0.30f];
    self.view.frame = CGRectMake(0, ios7Height, self.view.frame.size.width, self.view.frame.size.height);
    [UIView commitAnimations];
}

- (BOOL)checkIsemail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:emailTextField.text];
}

- (BOOL)checkPasswd
{
    if ([passWdTextField.text isEqualToString:suerPasswdTextField.text])
    {
        return  YES;
    }
    return  NO;
}


- (BOOL)checkItemTextField
{
    if ([nameTextField.text isEqualToString: @""])
    {
        [self showMBProgressHUDByString:@"请输入账号"];
        return NO;
    }
    
    if ([passWdTextField.text isEqualToString:@""] )
    {
        [self showMBProgressHUDByString:@"请输入密码"];
        return NO;
    }
    
    if ([neroTextField.text isEqualToString:@""])
    {
        [self showMBProgressHUDByString:@"请输入昵称"];
        return NO;
    }
    return YES;
}


//提交
- (void)setregisterBtnEvent
{
    
//    user.ACCOUNT
//    user.PASSWORD
//    user.USERNAME
//    user.ENABLED       default is 1
//    user.LOCKED        default is 1
//    user.SEX           default is 1
//    user.IMEI      可传可不传
//    user.IMEIMD5   可传可不传
//    user.MAC       可传可不传
//    user.IMSI      可传可不传
//    user.OSLX      可传可不传
//    user.OSBB      可传可不传
//    m_AppDelegate.UUidStr,@"user.IMEI",[m_AppDelegate.UUidStr md5] ,@"user.IMEIMD5"
  
    if ([self checkItemTextField])
    {
        NSDictionary  *dic = [[NSDictionary alloc]initWithObjectsAndKeys:nameTextField.text,@"user.ACCOUNT",
                              passWdTextField.text,@"user.PASSWORD" , neroTextField.text,@"user.USERNAME",
                             @"1",@"user.ENABLED",@"1",@"user.LOCKED",@"1",@"user.SEX" ,nil];
        MKNetworkOperation *op =   [m_AppDelegate.networkEngineinstace  getdata:dic path:ADDUSER httpMethod:GET];
        
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
         {
             NSDictionary *resultDic = [completedOperation responseJSON];
             if (resultDic) {
                 
                 if ([[resultDic objectForKey:@"amount"]isEqualToString:@"3"])
                 {
                     MBProgressHUD *hud  = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                     hud.labelText = @"注册成功，首次注册赠送3天会员";
                     hud.mode = MBProgressHUDModeText;
                     [hud hide:YES afterDelay:2];
                     [self registerSuccessed];

                 }

             }
         } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
         }];
    }
}

-(void)registerSuccessed
{
    ReadAndWrite  *readWrite = [[ReadAndWrite alloc]init];
    [readWrite deleteDocument];
    
    LoginViewController  *loginVC = (LoginViewController*)[[self.navigationController childViewControllers]firstObject];
    
    loginVC.nameTextField.text = nameTextField.text;
    loginVC.pwdTextField.text = passWdTextField.text;
    [self performSelector:@selector(backController)
               withObject:@"Grand Central Dispatch"
               afterDelay:2.0];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:0.30f];
    
    int ss =  IOS7?44:0;
    if (textField == nameTextField)
    {
        
        self.view.frame = CGRectMake(0, 0+ss, self.view.frame.size.width ,self.view.frame.size.height);
    }
    else if(textField  == passWdTextField)
    {
        self.view.frame = CGRectMake(0, -textField.frame.size.height*1 +ss, self.view.frame.size.width, self.view.frame.size.height);
    }
    else if (textField  == suerPasswdTextField)
    {
        self.view.frame = CGRectMake(0, -textField.frame.size.height*2+ss, 320, self.view.frame.size.height);
    }
    else if (textField == neroTextField)
    {
          self.view.frame = CGRectMake(0, -textField.frame.size.height, 320, self.view.frame.size.height);
    }
    else if (textField == emailTextField)
    {
        self.view.frame = CGRectMake(0, -textField.frame.size.height*4+ss, 320, self.view.frame.size.height);
    }
    else if (textField == phoneNumTextField)
    {
        self.view.frame = CGRectMake(0, -textField.frame.size.height*5+ss, 320, self.view.frame.size.height);
    }
    [UIView commitAnimations];
}
@end
