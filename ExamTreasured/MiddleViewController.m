//
//  MiddleViewController.m
//  ExamTreasured
//
//  Created by mac on 14-5-11.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MiddleViewController.h"
#import "MMDrawerVisualState.h"
#import "MMDrawerController.h"
#import "CollectView/Collect/CollectViewController.h"
#import "PayViewController.h"
#import "GongLue/GuoLueYuanViewController.h"
#import "ShowViewCotroller.h"
#import "AboutViewController.h"
#import "MemberViewController.h"
#import "CycleScrollView.h"
#import "GongLue/GongLueModel.h"
#import "UIImageView+WebCache.h"
#import "MainScrollViewController.h"
#import "YunBiJi/YunBiJiViewController.h"
#import "zhangjie/ZhangjieViewController.h"
#import "zhinengzujuan/ZhiNengZJViewController.h"
#import "PayView/ShoppingCartViewController.h"
@interface MiddleViewController ()
@property (nonatomic , retain) CycleScrollView *mainScorllView;

@end
@implementation MiddleViewController

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
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *nav_background = [UIImage imageNamed:@"navgation"];
    [self setNaviBackGroundWithImage:nav_background];
    [self addNaviLeftBtnWithName:@"临床执业医师" andFrame:CGRectMake(0, 2,130,30) target:self action:@selector(showLeftViewAction)];
    [self addNaviRightBtn];
    
    [self initializationUI];
    [self initializaionTabView];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // Do any additional setup after loading the view.
}
- (void)setNaviName:(NSString*)iString
{
    [self addNaviLeftBtnWithName:iString andFrame:CGRectMake(0, 2,130,30) target:self action:@selector(showLeftViewAction)];
}
- (void)showLeftViewAction
{
    [m_AppDelegate.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];

}
- (void)initializationUI
{
    if (!mainViewArray) {
        mainViewArray = [@[] mutableCopy];;
    }
    
    CGRect rect;
    CGPoint point;
    rect = CGRectMake(0, 0, 320, isIPhone5?183:183/568.0*480);
    point = CGPointMake(160, isIPhone5?92:183/568.0*480/2);
    self.mainScorllView = [[CycleScrollView alloc] initWithFrame:rect animationDuration:2];
    
    self.mainScorllView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    [self.view addSubview:self.mainScorllView];


    
    mainArrayData = [[NSMutableArray alloc]init];
    [self performSelectorInBackground:@selector(backGroundLoadMainViewArray) withObject:nil];

}
- (void)backGroundLoadMainViewArray
{
    NSDictionary  *dic = [[NSDictionary alloc]initWithObjectsAndKeys:m_AppDelegate.zy_ID,@"zy_id",nil];
    MKNetworkOperation *op =   [m_AppDelegate.networkEngineinstace  getdata:dic path:FORUM_GETMAINPOSTLIST httpMethod:POST];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         NSDictionary *dic = [completedOperation responseJSON];
         if (dic && [dic count]>0)
         {
             NSArray *tempArr = [dic objectForKey:@"data"];
             if (tempArr && [tempArr count]>0) {
                 [self zuzhuangArray:tempArr];
                 if (mainArrayData && [mainArrayData count]>0) {
                     for (int i = 0; i < [mainArrayData count]; i++) {
                         CGRect rect = CGRectMake(0, 0, 320, isIPhone5?183:183/568.0*480);
                         CGPoint point = CGPointMake(160, isIPhone5?92:183/568.0*480/2);
                         
                         UIView *tempBtn = [[UIView alloc]init];
                         tempBtn.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
                         GongLueModel *tempModel = (GongLueModel*)[mainArrayData objectAtIndex:i];
                         NSString *urlStr = tempModel.GL_cover;
                         
                         [tempBtn setBackgroundColor:[UIColor colorWithPatternImage:[AppDelegate clipImage:[m_AppDelegate loadWebImage:urlStr] clipSize:rect.size]]];
                         
                         [mainViewArray addObject:tempBtn];
                     }
                 }
             }
         }
         if (mainViewArray && [mainViewArray count]>0) {
             __block MiddleViewController *blockSelf = self;
             
             self.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
                 return blockSelf->mainViewArray[pageIndex];
             };
             self.mainScorllView.totalPagesCount = ^NSInteger(void){
                 return 3;
             };
             self.mainScorllView.TapActionBlock = ^(NSInteger pageIndex){
                 NSLog(@"点击了第%d个",pageIndex);
                 if (blockSelf->mainArrayData && [blockSelf->mainArrayData count]>pageIndex) {
                     GongLueModel *tempModel = [blockSelf->mainArrayData objectAtIndex:pageIndex];
                     MainScrollViewController *nest = [[MainScrollViewController alloc]init];
                     [blockSelf.navigationController pushViewController:nest animated:YES];
                     [nest setGlModel:tempModel];
                 }
                 
             };
             
         }
         
     } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
         
     }];


}
- (void)initializaionTabView
{
    float heightTabview = isIPhone5?183:183/568.0*480;

    CGRect rect;
    CGPoint point;
    //tabview
    rect = CGRectMake(0, 0, 320, 40);
    point = CGPointMake(160, IOS7?self.view.frame.size.height-20-44-20:self.view.frame.size.height-20-44);
    UIView *tabView = [[UIView alloc]initWithFrame:rect];
    tabView.center = point;
    tabView.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    [self.view addSubview:tabView];
    
    //tab Item fav
    rect = CGRectMake(0, 0, 20, 20);
    point = CGPointMake(50, 15);
    UIButton *fav   = [UIButton buttonWithType:UIButtonTypeCustom];
    fav.frame       = rect;
    fav.center      = point;
    fav.tag         = 106;
    [fav setBackgroundImage:[UIImage imageNamed:@"sysmain_fav"] forState:UIControlStateNormal];
    [fav setBackgroundImage:[UIImage imageNamed:@"sysmain_fav_h"] forState:UIControlStateHighlighted];
    [fav addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    rect = CGRectMake(0, 0, 40, 20);
    point = CGPointMake(50, 32);
    UILabel *favLabel           = [[UILabel alloc]init];
    favLabel.frame              = rect;
    favLabel.center             = point;
    favLabel.text               = @"收藏夹";
    favLabel.font               = [UIFont systemFontOfSize:10];
    favLabel.textAlignment      = NSTextAlignmentCenter;
    favLabel.textColor          = [UIColor grayColor];
    favLabel.backgroundColor    = [UIColor clearColor];
    [tabView addSubview:favLabel];
    [tabView addSubview:fav];

    //tab Item huiyuan
    rect = CGRectMake(0, 0, 20, 20);
    point = CGPointMake(160, 15);
    UIButton *huiyuan   = [UIButton buttonWithType:UIButtonTypeCustom];
    huiyuan.frame       = rect;
    huiyuan.center      = point;
    huiyuan.tag         = 107;
    [huiyuan setBackgroundImage:[UIImage imageNamed:@"sysmain_huiyuan"] forState:UIControlStateNormal];
    [huiyuan setBackgroundImage:[UIImage imageNamed:@"sysmain_huiyuan_h"] forState:UIControlStateHighlighted];
    [huiyuan addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];

    rect = CGRectMake(0, 0, 40, 20);
    point = CGPointMake(160, 32);
    UILabel *huiyuanLabel           = [[UILabel alloc]init];
    huiyuanLabel.frame              = rect;
    huiyuanLabel.center             = point;
    huiyuanLabel.text               = @"个人中心";
    huiyuanLabel.font               = [UIFont systemFontOfSize:10];
    huiyuanLabel.textAlignment      = NSTextAlignmentCenter;
    huiyuanLabel.textColor          = [UIColor grayColor];
    huiyuanLabel.backgroundColor    = [UIColor clearColor];
    [tabView addSubview:huiyuanLabel];
    [tabView addSubview:huiyuan];

    //tab Item buy
    rect = CGRectMake(0, 0, 25, 25);
    point = CGPointMake(270, 13);
    UIButton *buy   = [UIButton buttonWithType:UIButtonTypeCustom];
    buy.frame       = rect;
    buy.center      = point;
    buy.tag         = 108;
    [buy setBackgroundImage:[UIImage imageNamed:@"sysmain_buy"] forState:UIControlStateNormal];
    [buy setBackgroundImage:[UIImage imageNamed:@"sysmain_buy_h"] forState:UIControlStateHighlighted];
    [buy addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];

    rect = CGRectMake(0, 0, 40, 20);
    point = CGPointMake(270, 32);
    UILabel *buyLabel           = [[UILabel alloc]init];
    buyLabel.frame              = rect;
    buyLabel.center             = point;
    buyLabel.text               = @"充值";
    buyLabel.font               = [UIFont systemFontOfSize:10];
    buyLabel.textAlignment      = NSTextAlignmentCenter;
    buyLabel.textColor          = [UIColor grayColor];
    buyLabel.backgroundColor    = [UIColor clearColor];
    [tabView addSubview:buyLabel];
    [tabView addSubview:buy];
    
    //line
//    float height = isIPhone5?(self.view.frame.size.height-66-heightTabview-40):(self.view.frame.size.height-46-40-heightTabview);
    float height = IOS7?(self.view.frame.size.height-66-heightTabview-40):(self.view.frame.size.height-46-40-heightTabview);
    NSLog(@"height---%f",height);
    rect = CGRectMake(0, 0, 1, height);
    point = CGPointMake(160, height/2.0+heightTabview);
    UIView *line = [[UIView alloc]initWithFrame:rect];
    line.center = point;
    line.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    [self.view addSubview:line];
    
    rect = CGRectMake(0, 0, 320, 1);
    point = CGPointMake(160, height/3.0+heightTabview);
    UIView *line1 = [[UIView alloc]initWithFrame:rect];
    line1.center = point;
    line1.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    [self.view addSubview:line1];
    
    point = CGPointMake(160, height/3.0*2+heightTabview);
    UIView *line2 = [[UIView alloc]initWithFrame:rect];
    line2.center = point;
    line2.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    [self.view addSubview:line2];

    //攻略
    rect = CGRectMake(0, 0, 160, height/3.0);
    point = CGPointMake(80, height/6.0+heightTabview);
    UIButton *glBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    glBtn.frame = rect;
    glBtn.center = point;
    glBtn.tag = 100;
    [glBtn setBackgroundImage:[m_AppDelegate formartForName:@"sysmain_bkgl"] forState:UIControlStateNormal];
    [glBtn setBackgroundImage:[m_AppDelegate formartForName:@"sysmain_bkgl_h"] forState:UIControlStateHighlighted];
    [glBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:glBtn];
    
    //真题考场
    point = CGPointMake(240, height/6.0+heightTabview);
    UIButton *ztBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ztBtn.frame = rect;
    ztBtn.center = point;
    ztBtn.tag = 101;
    [ztBtn setBackgroundImage:[m_AppDelegate formartForName:@"sysmain_lnzt"] forState:UIControlStateNormal];
    [ztBtn setBackgroundImage:[m_AppDelegate formartForName:@"sysmain_lnzt_h"] forState:UIControlStateHighlighted];
    [ztBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ztBtn];
    
    //核心速记
    point = CGPointMake(80, height/2.0+heightTabview);
    UIButton *sjBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sjBtn.frame = rect;
    sjBtn.center = point;
    sjBtn.tag = 102;
    [sjBtn setBackgroundImage:[m_AppDelegate formartForName:@"sysmain_fxbj"] forState:UIControlStateNormal];
    [sjBtn setBackgroundImage:[m_AppDelegate formartForName:@"sysmain_fxbj_h"] forState:UIControlStateHighlighted];
    [sjBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sjBtn];

    //章节练习
    point = CGPointMake(240, height/2.0+heightTabview);
    UIButton *lxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lxBtn.frame = rect;
    lxBtn.center = point;
    lxBtn.tag = 103;
    [lxBtn setBackgroundImage:[m_AppDelegate formartForName:@"sysmain_zjlx"] forState:UIControlStateNormal];
    [lxBtn setBackgroundImage:[m_AppDelegate formartForName:@"sysmain_zjlx_h"] forState:UIControlStateHighlighted];
    [lxBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lxBtn];

    //只能组卷
    point = CGPointMake(80, height*5/6.0+heightTabview);
    UIButton *zjBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    zjBtn.frame = rect;
    zjBtn.center = point;
    zjBtn.tag = 104;
    [zjBtn setBackgroundImage:[m_AppDelegate formartForName:@"sysmain_mnks"] forState:UIControlStateNormal];
    [zjBtn setBackgroundImage:[m_AppDelegate formartForName:@"sysmain_mnks_h"] forState:UIControlStateHighlighted];
    [zjBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zjBtn];

    //考前冲刺
    point = CGPointMake(240, height*5/6.0+heightTabview);
    UIButton *ccBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    ccBtn.frame = rect;
    ccBtn.center = point;
    ccBtn.tag = 105;
    [ccBtn setBackgroundImage:[m_AppDelegate formartForName:@"sysmain_kqcc"] forState:UIControlStateNormal];
    [ccBtn setBackgroundImage:[m_AppDelegate formartForName:@"sysmain_kqcc_h"] forState:UIControlStateHighlighted];
    [ccBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ccBtn];
}
- (void)btnPressed:(id)sender
{
    if (m_AppDelegate.login_ID && [m_AppDelegate.login_ID length]>0) {
        UIButton *tempBtn = (UIButton *)sender;
        NSInteger i = tempBtn.tag - 100;
        switch (i) {
            case 0:
            {
                //攻略园
                GuoLueYuanViewController *gonglueVC = [[GuoLueYuanViewController alloc]init];
                MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:gonglueVC];
                [self presentViewController:nav animated:YES completion:nil];
                hub.hidden = YES;
            }
                break;
            case 1:
            {
                //真题考场
                ShowViewCotroller  *showVC = [[ShowViewCotroller alloc]initWittitle:@"真题考场"];
                UINavigationController  *navgationShowVC = [[UINavigationController alloc]initWithRootViewController:showVC];
                
                [self presentViewController:navgationShowVC animated:YES completion:nil];
                
                
            }
                break;
            case 2:
            {
                //核心速记
                YunBiJiViewController  *showVC = [[YunBiJiViewController alloc]initWittitle:@"复习笔记"];
                UINavigationController  *navgationShowVC = [[UINavigationController alloc]initWithRootViewController:showVC];
                
                [self presentViewController:navgationShowVC animated:YES completion:nil];
                
            }
                break;
            case 3:
            {
                //章节练习
                 ZhangjieViewController *showVC = [[ZhangjieViewController alloc]initWittitle:@"章节练习"];
                UINavigationController  *navgationShowVC = [[UINavigationController alloc]initWithRootViewController:showVC];
                
                [self presentViewController:navgationShowVC animated:YES completion:nil];
             
            }
                break;
            case 4:
            {
                //智能组卷
                ZhiNengZJViewController *zhiVC = [[ZhiNengZJViewController alloc]initWittitle:@"智能组卷"];
                UINavigationController *navFav = [[UINavigationController alloc]initWithRootViewController:zhiVC];
                
                [self presentViewController:navFav animated:YES completion:nil];

            }
                break;
            case 5:
            {
                //考前冲刺
                [self showMBProgressHUDByString:@"暂没开发"];
            }
                break;
            case 6:
            {
                //收藏
                CollectViewController *colectVC = [[CollectViewController alloc]initWithtitle:@"收藏夹"];
                UINavigationController *navFav = [[UINavigationController alloc]initWithRootViewController:colectVC];
                
                [self presentViewController:navFav animated:YES completion:nil];
            }
                break;
            case 7:
            {
                
                MemberViewController *mbVC = [[MemberViewController alloc]initWithtitle:@"信息中心"];
                UINavigationController *NavmbVC = [[UINavigationController alloc]initWithRootViewController:mbVC];
                [self presentViewController:NavmbVC animated:YES completion:nil];
                
            }
                break;
            case 8:
            {

                ShoppingCartViewController  *ShoppingCartVC = [[ShoppingCartViewController alloc]initWithNibName:nil bundle:nil];
                UINavigationController *NaVCPay = [[UINavigationController alloc]initWithRootViewController:ShoppingCartVC];
                [self presentViewController:NaVCPay animated:YES completion:nil];
                            
            }
                break;
            default:
                break;
        }
    }
    else{
        [self showMBProgressHUDByString:@"请先登陆"];
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSMutableArray*)zuzhuangArray:(NSArray*)iArray
{
    if (!mainArrayData) {
        mainArrayData = [[NSMutableArray alloc]init];
    }
    for (int i = 0; i<[iArray count]; i++) {
        NSDictionary *tempDic = [iArray objectAtIndex:i];
        GongLueModel *tempGongLue = [[GongLueModel alloc]init];
        if (tempDic) {
            tempGongLue.GL_ID = [tempDic objectForKey:@"PS_ID"];
            tempGongLue.GL_BT = [tempDic objectForKey:@"PS_BT"];
            tempGongLue.GL_NR = [tempDic objectForKey:@"PS_ZW"];
            tempGongLue.GL_UPDATE_TIME = [tempDic objectForKey:@"PS_createTime"];
            tempGongLue.GL_READ_COUNT = [tempDic objectForKey:@"PS_revertCount"];
            tempGongLue.GL_AUTHOR = [tempDic objectForKey:@"PS_author"];
            tempGongLue.SC_ID = [tempDic objectForKey:@"storStrategyId"];
            tempGongLue.GL_cover = [NSString stringWithFormat:@"http://%@:%d%@",HOST,PROT,[tempDic objectForKey:@"PS_cover"]];
        }
        [mainArrayData addObject:tempGongLue];
    }
    return mainArrayData;
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
