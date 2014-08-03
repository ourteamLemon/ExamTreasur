//
//  ShowBiJiViewController.m
//  ExamTreasured
//
//  Created by yuan on 14-6-3.
//  Copyright (c) 2014年 yuan. All rights reserved.
//

#import "ShowBiJiViewController.h"
#import "MBProgressHUD.h"
#import "ChapterA1ViewController.h"
#define SendViewHeight 49
#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@interface ShowBiJiViewController ()

@end

@implementation ShowBiJiViewController
@synthesize dataDic;
@synthesize dataSourceDic;
@synthesize scbtn;
@synthesize scLabel;
@synthesize bianjiLabel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithDictionary:(NSDictionary *)dic
{
    dataDic = [[NSDictionary alloc]initWithDictionary:dic];
    self = [super initWithNibName:nil  bundle:nil];
    if (self) {
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    dataSourceDic = [[NSMutableDictionary alloc]init];
    [self addNaviLeftBtnWithImageName:@"back" andFrame:CGRectMake(0, 2,30,30) target:self action:@selector(backController)];
    [self setNaviTitle:[dataDic objectForKey:@"XJ_MC"]];
    
    UIImage *nav_background = [UIImage imageNamed:@"navgation"];
    [self setNaviBackGroundWithImage:nav_background];
    [self addNaviRightBtn];

    [self creattabView];
//    [self creatWebView];
        // Do any additional setup after loading the view.
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
- (void)creattabView
{
    CGRect rect;
    CGPoint point;
    //tabview
    rect = CGRectMake(0, 0, 320, SendViewHeight);
    point = CGPointMake(160, IOS7?self.view.frame.size.height-20-44-20:self.view.frame.size.height-20-44);
    UIView *tabView = [[UIView alloc]initWithFrame:rect];
    tabView.center = point;
    tabView.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    [self.view addSubview:tabView];
    
    //tab Item 收藏
    rect = CGRectMake(0, 0, 20, 20);
    point = CGPointMake(50, 15);
    scbtn   = [UIButton buttonWithType:UIButtonTypeCustom];
    scbtn.frame       = rect;
    scbtn.center      = point;
    scbtn.tag         = 106;
    [self.scbtn setBackgroundImage:[UIImage imageNamed:@"gonglue_sc.png"] forState:UIControlStateNormal];
    [self.scbtn setBackgroundImage:[UIImage imageNamed:@"gonglue_sc_h.png"] forState:UIControlStateHighlighted];
    [scbtn addTarget:self action:@selector(scBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    rect = CGRectMake(0, 0, 40, 20);
    point = CGPointMake(50, 32);
    scLabel           = [[UILabel alloc]init];
    scLabel.frame              = rect;
    scLabel.center             = point;
    scLabel.text               = @"收藏";
    scLabel.font               = [UIFont systemFontOfSize:10];
    scLabel.textAlignment      = NSTextAlignmentCenter;
    scLabel.textColor          = [UIColor grayColor];
    scLabel.backgroundColor    = [UIColor clearColor];
    [tabView addSubview:scLabel];
    [tabView addSubview:scbtn];
    
    //tab Item 编辑-保存
    rect = CGRectMake(0, 0, 20, 20);
    point = CGPointMake(160, 15);
    UIButton *huiyuan   = [UIButton buttonWithType:UIButtonTypeCustom];
    huiyuan.frame       = rect;
    huiyuan.center      = point;
    huiyuan.tag         = 107;
    [huiyuan setBackgroundImage:[UIImage imageNamed:@"biji_bianji"] forState:UIControlStateNormal];
    [huiyuan setBackgroundImage:[UIImage imageNamed:@"biji_bianji_h"] forState:UIControlStateHighlighted];
    [huiyuan addTarget:self action:@selector(bianjiBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    rect = CGRectMake(0, 0, 40, 20);
    point = CGPointMake(160, 32);
    bianjiLabel           = [[UILabel alloc]init];
    bianjiLabel.frame              = rect;
    bianjiLabel.center             = point;
    bianjiLabel.text               = @"编辑";
    bianjiLabel.font               = [UIFont systemFontOfSize:10];
    bianjiLabel.textAlignment      = NSTextAlignmentCenter;
    bianjiLabel.textColor          = [UIColor grayColor];
    bianjiLabel.backgroundColor    = [UIColor clearColor];
    [tabView addSubview:bianjiLabel];
    [tabView addSubview:huiyuan];
    
    //tab Item 开始练习
    rect = CGRectMake(0, 0, 25, 25);
    point = CGPointMake(270, 13);
    UIButton *buy   = [UIButton buttonWithType:UIButtonTypeCustom];
    buy.frame       = rect;
    buy.center      = point;
    buy.tag         = 108;
    [buy setBackgroundImage:[UIImage imageNamed:@"biji_lianxi"] forState:UIControlStateNormal];
    [buy setBackgroundImage:[UIImage imageNamed:@"biji_lianxi_h"] forState:UIControlStateHighlighted];
    [buy addTarget:self action:@selector(lianxiBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    rect = CGRectMake(0, 0, 40, 20);
    point = CGPointMake(270, 32);
    UILabel *buyLabel           = [[UILabel alloc]init];
    buyLabel.frame              = rect;
    buyLabel.center             = point;
    buyLabel.text               = @"开始练习";
    buyLabel.font               = [UIFont systemFontOfSize:10];
    buyLabel.textAlignment      = NSTextAlignmentCenter;
    buyLabel.textColor          = [UIColor grayColor];
    buyLabel.backgroundColor    = [UIColor clearColor];
    [tabView addSubview:buyLabel];
    [tabView addSubview:buy];
}
- (void)creatWebView
{
    iWebView = [[UIWebView alloc]init];
    iWebView.frame = CGRectMake(0, 0, 320, 416+(isIPhone5?88:0)-SendViewHeight);
    iWebView.delegate = self;
    [self.view addSubview:iWebView];
    iWebView.scrollView.bounces=NO;
    MBProgressHUD  *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    NSDictionary  *dic = [[NSDictionary alloc]initWithObjectsAndKeys:[dataDic objectForKey:@"XJ_ID"],@"xj_id",@"31",@"login_id",m_AppDelegate.zy_ID,@"zy_id",@"0",@"start",@"10",@"end",m_AppDelegate.yh_ID,@"yh_id",nil];
    MKNetworkOperation  *op = [m_AppDelegate.networkEngineinstace getdata:dic path:NOTE_GETNOTEBYTXJID httpMethod:POST];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         
         NSArray  *tempArray = [completedOperation responseJSON];
         if (tempArray && [tempArray count]>0) {
             dataSourceDic = [NSMutableDictionary dictionaryWithDictionary:[tempArray objectAtIndex:0]];
             [self shoucangChange];
             NSString *urlStr = [dataSourceDic objectForKey:@"bj_nr"];
             NSString *BT = [dataSourceDic objectForKey:@"bj_bt"];
             NSString *nrStr = [NSString stringWithFormat:@"<div style=\"width:310px; height:30px; padding-top:5px;\"><span style=\"font-size:20px; padding-left:15px; \">%@</span></div><div style=\"border-bottom:1px solid #ccc; text-align:right; width:310px; height:18px;\"><span style=\"font-size:12px; padding-right:15px;\">标题</span></div><div style=\" text-align:right; width:310px; height:20px; padding-top:5px;\"><span style=\"font-size:12px; padding-right:15px;\">内容</span></div>%@",BT,urlStr];
             [iWebView loadHTMLString:nrStr baseURL:nil];
         }
         hub.hidden = YES;
     }errorHandler:^(MKNetworkOperation *completedOperation, NSError *error)
     {
         hub.hidden = YES;
     }];
}
- (void)shoucangToBiji:(NSDictionary*)tempDic
{
    iWebView = [[UIWebView alloc]init];
    iWebView.frame = CGRectMake(0, 0, 320, 416+(isIPhone5?88:0)-SendViewHeight);
    iWebView.delegate = self;
    [self.view addSubview:iWebView];
    iWebView.scrollView.bounces=NO;
    [self shoucangChange];

    if (tempDic && [tempDic count]>0) {
        dataSourceDic = [NSMutableDictionary dictionaryWithDictionary:tempDic];
        [self shoucangChange];
        NSString *urlStr = [dataSourceDic objectForKey:@"bj_nr"];
        NSString *BT = [dataSourceDic objectForKey:@"bj_bt"];
        NSString *nrStr = [NSString stringWithFormat:@"<div style=\"width:310px; height:30px; padding-top:5px;\"><span style=\"font-size:20px; padding-left:15px; \">%@</span></div><div style=\"border-bottom:1px solid #ccc; text-align:right; width:310px; height:18px;\"><span style=\"font-size:12px; padding-right:15px;\">标题</span></div><div style=\" text-align:right; width:310px; height:20px; padding-top:5px;\"><span style=\"font-size:12px; padding-right:15px;\">内容</span></div>%@",BT,urlStr];
        [iWebView loadHTMLString:nrStr baseURL:nil];
    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)shoucangChange
{
    if (dataSourceDic) {
        NSString *scId = [dataSourceDic objectForKey:@"storNote_id"];
        if ([scId intValue]==-1) {
            [self.scbtn setBackgroundImage:[UIImage imageNamed:@"gonglue_sc.png"] forState:UIControlStateNormal];
            [self.scbtn setBackgroundImage:[UIImage imageNamed:@"gonglue_sc_h.png"] forState:UIControlStateHighlighted];
            scLabel.text = @"收藏";
        }
        else{
            [self.scbtn setBackgroundImage:[UIImage imageNamed:@"gonglue_qxsc.png"] forState:UIControlStateNormal];
            [self.scbtn setBackgroundImage:[UIImage imageNamed:@"gonglue_qxsc_h.png"] forState:UIControlStateHighlighted];
            scLabel.text = @"取消收藏";
        }
    }
}

- (void)scBtnPressed:(id)sender
{
    NSString *scId = [dataSourceDic objectForKey:@"storNote_id"];
    if ([scId intValue]==-1) {
        MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        NSDictionary  *dic = [[NSDictionary alloc]initWithObjectsAndKeys:[dataSourceDic objectForKey:@"zj_id"],@"storageNote.CHAPTER_ID",[dataSourceDic objectForKey:@"xj_id"],@"storageNote.MINUTIA_ID",[dataSourceDic objectForKey:@"bj_id"],@"storageNote.NOTE_ID",m_AppDelegate.yh_ID,@"storageNote.YH_ID",m_AppDelegate.zy_ID,@"storageNote.ZY_ID",nil];
        MKNetworkOperation *op =   [m_AppDelegate.networkEngineinstace  getdata:dic path:STORAGE_ADDNote httpMethod:POST];
        
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
         {
             NSDictionary *dic = [completedOperation responseJSON];
             if (dic && [dic objectForKey:@"success"]) {
                 [self showMBProgressHUDByString:@"收藏成功"];
                 NSString *value = [dic objectForKey:@"storageNoteid"];
                 [dataSourceDic setObject:value forKey:@"storNote_id"];
                 [self shoucangChange];
             }
             hub.hidden = YES;
         } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
             hub.hidden = YES;
         }];

    }
    else{
        MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        NSDictionary  *dic = [[NSDictionary alloc]initWithObjectsAndKeys:[dataSourceDic objectForKey:@"storNote_id"],@"storNote_id",m_AppDelegate.yh_ID,@"yh_id",nil];
        MKNetworkOperation *op =   [m_AppDelegate.networkEngineinstace  getdata:dic path:STORAGE_DELETENOTE httpMethod:POST];
        
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
         {
             NSDictionary *dic = [completedOperation responseJSON];
             if (dic && [dic objectForKey:@"success"]) {
                 NSString *sssss = [dic objectForKey:@"message"];
                 [self showMBProgressHUDByString:sssss];
                 [dataSourceDic setObject:@"-1" forKey:@"storNote_id"];
                 [self shoucangChange];
             }
             hub.hidden = YES;
         } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
             hub.hidden = YES;
         }];
    }
}
- (void)bianjiBtnPressed:(id)sender
{
    
}

#pragma mark 练习
- (void)lianxiBtnPressed:(id)sender
{
    
//    ChapterA1ViewController  *chapterVC = [ChapterA1ViewController alloc]initWithStyle:UITableViewStylePlain Dictinary:<#(NSDictionary *)#> index:<#(int)#>
    
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

@end
