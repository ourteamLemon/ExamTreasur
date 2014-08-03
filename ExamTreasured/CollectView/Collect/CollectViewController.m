//
//  CollectViewController.m
//  ExamTreasured
//
//  Created by mac on 14-5-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CollectViewController.h"
#import "GongLueModel.h"
#import "MainScrollViewController.h"
#import "ShowBiJiViewController.h"
#define PICHEIGHT 30
#define TABHEIGHT 50


@interface CollectViewController ()

@end

@implementation CollectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithtitle:(NSString *)titleString
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
       [self setNaviTitle:titleString];
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavgation];
    [self addNaviRightBtn];

    [self crateTabView];
    [self crateMainView];
    [self stBtnPressed:nil];
}
- (void)crateMainView
{
    CGRect rect = CGRectMake(0, 0, 320, 416+(isIPhone5?88:0)-TABHEIGHT);
    //我的试题
    stView = [[UIView alloc]init];
    stView.frame = rect;
    stView.hidden = NO;
    [self.view addSubview:stView];
    aTable = [[UITableView alloc]initWithFrame:stView.frame style:UITableViewStylePlain];
    aTable.delegate = self;
    aTable.dataSource = self;
    [stView addSubview:aTable];
    
    
    
    //我的笔记
    bjView = [[UIView alloc]init];
    bjView.frame = rect;
    bjView.hidden = YES;
    [self.view addSubview:bjView];
    bjDataSource = [[NSDictionary alloc]init];
    
    
    //我的攻略
    glView = [[UIView alloc]init];
    glView.frame = rect;
    glView.hidden = YES;
    [self.view addSubview:glView];
    [glView addSubview:aTable];

    
    
    //错题集
    ctView = [[UIView alloc]init];
    ctView.frame = rect;
    ctView.hidden = YES;
    [self.view addSubview:ctView];

}
- (void)crateTabView
{
    CGRect rect;
    CGPoint point;
    //tabview
    rect = CGRectMake(0, 0, 320, TABHEIGHT);
    point = CGPointMake(160, IOS7?self.view.frame.size.height-20-44-20:self.view.frame.size.height-20-44);
    UIView *tabView = [[UIView alloc]initWithFrame:rect];
    tabView.center = point;
    tabView.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    [self.view addSubview:tabView];
    
    //tab Item 我的试题
    rect = CGRectMake(0, 0, PICHEIGHT, PICHEIGHT);
    point = CGPointMake(40, 15);
    UIButton *shiti   = [UIButton buttonWithType:UIButtonTypeCustom];
    shiti.frame       = rect;
    shiti.center      = point;
    shiti.tag         = 106;
    [shiti setBackgroundImage:[UIImage imageNamed:@"sc_st"] forState:UIControlStateNormal];
    [shiti setBackgroundImage:[UIImage imageNamed:@"sc_st_h"] forState:UIControlStateHighlighted];
    [shiti addTarget:self action:@selector(stBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    rect = CGRectMake(0, 0, 40, 20);
    point = CGPointMake(40, 37);
    UILabel *shitiLabel           = [[UILabel alloc]init];
    shitiLabel.frame              = rect;
    shitiLabel.center             = point;
    shitiLabel.text               = @"我的试题";
    shitiLabel.font               = [UIFont systemFontOfSize:10];
    shitiLabel.textAlignment      = NSTextAlignmentCenter;
    shitiLabel.textColor          = [UIColor grayColor];
    shitiLabel.backgroundColor    = [UIColor clearColor];
    [tabView addSubview:shitiLabel];
    [tabView addSubview:shiti];
    
    //tab Item 我的笔记
    rect = CGRectMake(0, 0, PICHEIGHT, PICHEIGHT);
    point = CGPointMake(120, 15);
    UIButton *biji   = [UIButton buttonWithType:UIButtonTypeCustom];
    biji.frame       = rect;
    biji.center      = point;
    biji.tag         = 107;
    [biji setBackgroundImage:[UIImage imageNamed:@"sc_bj"] forState:UIControlStateNormal];
    [biji setBackgroundImage:[UIImage imageNamed:@"sc_bj_h"] forState:UIControlStateHighlighted];
    [biji addTarget:self action:@selector(bjBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    rect = CGRectMake(0, 0, 40, 20);
    point = CGPointMake(120, 37);
    UILabel *bijiLabel           = [[UILabel alloc]init];
    bijiLabel.frame              = rect;
    bijiLabel.center             = point;
    bijiLabel.text               = @"我的笔记";
    bijiLabel.font               = [UIFont systemFontOfSize:10];
    bijiLabel.textAlignment      = NSTextAlignmentCenter;
    bijiLabel.textColor          = [UIColor grayColor];
    bijiLabel.backgroundColor    = [UIColor clearColor];
    [tabView addSubview:bijiLabel];
    [tabView addSubview:biji];
    
    //tab Item 我的攻略
    rect = CGRectMake(0, 0, PICHEIGHT, PICHEIGHT);
    point = CGPointMake(200, 15);
    UIButton *gl   = [UIButton buttonWithType:UIButtonTypeCustom];
    gl.frame       = rect;
    gl.center      = point;
    gl.tag         = 108;
    [gl setBackgroundImage:[UIImage imageNamed:@"sc_gl"] forState:UIControlStateNormal];
    [gl setBackgroundImage:[UIImage imageNamed:@"sc_gl_h"] forState:UIControlStateHighlighted];
    [gl addTarget:self action:@selector(glBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    rect = CGRectMake(0, 0, 40, 20);
    point = CGPointMake(200, 37);
    UILabel *glLabel           = [[UILabel alloc]init];
    glLabel.frame              = rect;
    glLabel.center             = point;
    glLabel.text               = @"我的攻略";
    glLabel.font               = [UIFont systemFontOfSize:10];
    glLabel.textAlignment      = NSTextAlignmentCenter;
    glLabel.textColor          = [UIColor grayColor];
    glLabel.backgroundColor    = [UIColor clearColor];
    [tabView addSubview:glLabel];
    [tabView addSubview:gl];
    
    //tab Item 错题集
    rect = CGRectMake(0, 0, PICHEIGHT, PICHEIGHT);
    point = CGPointMake(280, 15);
    UIButton *cuoti   = [UIButton buttonWithType:UIButtonTypeCustom];
    cuoti.frame       = rect;
    cuoti.center      = point;
    cuoti.tag         = 108;
    [cuoti setBackgroundImage:[UIImage imageNamed:@"sc_ct"] forState:UIControlStateNormal];
    [cuoti setBackgroundImage:[UIImage imageNamed:@"sc_ct_h"] forState:UIControlStateHighlighted];
    [cuoti addTarget:self action:@selector(ctBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    rect = CGRectMake(0, 0, 40, 20);
    point = CGPointMake(280, 37);
    UILabel *cuotiLabel           = [[UILabel alloc]init];
    cuotiLabel.frame              = rect;
    cuotiLabel.center             = point;
    cuotiLabel.text               = @"错题集";
    cuotiLabel.font               = [UIFont systemFontOfSize:10];
    cuotiLabel.textAlignment      = NSTextAlignmentCenter;
    cuotiLabel.textColor          = [UIColor grayColor];
    cuotiLabel.backgroundColor    = [UIColor clearColor];
    [tabView addSubview:cuotiLabel];
    [tabView addSubview:cuoti];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
- (void)setNavgation
{
    [self addNaviLeftBtnWithImageName:@"back" andFrame:CGRectMake(0, 2,30,30) target:self action:@selector(backController)];
    
    UIImage *nav_background = [UIImage imageNamed:@"navgation"];
    [self setNaviBackGroundWithImage:nav_background];
}
#pragma Mark- 我的试题
- (void)stBtnPressed:(id)sender
{
    stView.hidden = NO;
    bjView.hidden = YES;
    glView.hidden = YES;
    ctView.hidden = YES;
    [stView addSubview:aTable];
    if (stDataSource && [stDataSource count]>1) {
        return;
    }
    MBProgressHUD  *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary  *dic = [[NSDictionary alloc]initWithObjectsAndKeys:m_AppDelegate.yh_ID,@"yh_id",m_AppDelegate.zy_ID,@"zy_id",nil];
    MKNetworkOperation  *op = [m_AppDelegate.networkEngineinstace getdata:dic path:STORAGE_GETALLSTORAGE httpMethod:POST];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         
         NSDictionary  *tempArray = [completedOperation responseJSON];
         stDataSource = tempArray;
         [aTable reloadData];
         hub.hidden = YES;
     }errorHandler:^(MKNetworkOperation *completedOperation, NSError *error)
     {
         hub.hidden = YES;
     }];
}
#pragma Mark- 我的笔记
//bj
- (void)bjBtnPressed:(id)sender
{
    stView.hidden = YES;
    bjView.hidden = NO;
    glView.hidden = YES;
    ctView.hidden = YES;
    [bjView addSubview:aTable];
    if (bjDataSource && [bjDataSource count]>1) {
        return;
    }
    MBProgressHUD  *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary  *dic = [[NSDictionary alloc]initWithObjectsAndKeys:m_AppDelegate.yh_ID,@"yh_id",m_AppDelegate.zy_ID,@"zy_id",nil];
    MKNetworkOperation  *op = [m_AppDelegate.networkEngineinstace getdata:dic path:STORAGE_GETALLSTORAGENOTEINFO httpMethod:POST];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         
         NSDictionary  *tempArray = [completedOperation responseJSON];
         bjDataSource = tempArray;
         [aTable reloadData];
         hub.hidden = YES;
     }errorHandler:^(MKNetworkOperation *completedOperation, NSError *error)
     {
         hub.hidden = YES;
     }];
}
#pragma Mark- 我的攻略
- (void)glBtnPressed:(id)sender
{
    stView.hidden = YES;
    bjView.hidden = YES;
    glView.hidden = NO;
    ctView.hidden = YES;
    [glView addSubview:aTable];
    if (glDataSource && [glDataSource count]>1) {
        return;
    }
    MBProgressHUD  *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary  *dic = [[NSDictionary alloc]initWithObjectsAndKeys:m_AppDelegate.yh_ID,@"yh_id",m_AppDelegate.zy_ID,@"zy_id",nil];
    MKNetworkOperation  *op = [m_AppDelegate.networkEngineinstace getdata:dic path:STORAGE_GETALLSTORAGESTRATEGYINFO httpMethod:POST];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         
         NSDictionary  *tempArray = [completedOperation responseJSON];
         glDataSource = tempArray;
         [aTable reloadData];
         hub.hidden = YES;
     }errorHandler:^(MKNetworkOperation *completedOperation, NSError *error)
     {
         hub.hidden = YES;
     }];
}
- (GongLueModel*)zuzhuangDic:(NSDictionary*)tempDic
{
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
    return tempGongLue;
}

#pragma Mark- 我的错题
- (void)ctBtnPressed:(id)sender
{
    stView.hidden = YES;
    bjView.hidden = YES;
    glView.hidden = YES;
    ctView.hidden = NO;
    [ctView addSubview:aTable];
    if (ctDataSource && [ctDataSource count]>1) {
        return;
    }
    MBProgressHUD  *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary  *dic = [[NSDictionary alloc]initWithObjectsAndKeys:m_AppDelegate.yh_ID,@"yh_id",m_AppDelegate.zy_ID,@"zy_id",nil];
    MKNetworkOperation  *op = [m_AppDelegate.networkEngineinstace getdata:dic path:STORAGE_GETALLSTORAGEERRORTOPICINFOBYYH httpMethod:POST];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         
         NSDictionary  *tempArray = [completedOperation responseJSON];
         ctDataSource = tempArray;
         [aTable reloadData];
         hub.hidden = YES;
     }errorHandler:^(MKNetworkOperation *completedOperation, NSError *error)
     {
         hub.hidden = YES;
     }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!stView.hidden && stDataSource && [stDataSource count]>0) {
        return [[stDataSource objectForKey:@"topiclist"] count];
    }
    if (!bjView.hidden && bjDataSource && [bjDataSource count]>0) {
        return [[bjDataSource objectForKey:@"note"]count];
    }
    if (!glView.hidden && glDataSource && [glDataSource count]>0) {
        return [[glDataSource objectForKey:@"strategy"] count];
    }
    if (!ctView.hidden && ctDataSource && [ctDataSource count]>0) {
        return [[ctDataSource objectForKey:@"topiclist"]count];
    }

    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier1 = @"identifier1";
    
    UITableViewCell*  cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
    cell.backgroundView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!stView.hidden) {
        cell.textLabel.text = [[[stDataSource objectForKey:@"topiclist"]objectAtIndex:indexPath.row]objectForKey:@"name"];
    }
    if (!bjView.hidden) {
        cell.textLabel.text = [[[bjDataSource objectForKey:@"note"]objectAtIndex:indexPath.row]objectForKey:@"name"];
    }

    if (!glView.hidden) {
        cell.textLabel.text = [[[glDataSource objectForKey:@"strategy"]objectAtIndex:indexPath.row]objectForKey:@"PS_BT"];
    }
    if (!ctView.hidden) {
        cell.textLabel.text = [[[ctDataSource objectForKey:@"strategy"]objectAtIndex:indexPath.row]objectForKey:@"PS_BT"];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!stView.hidden) {
    }
    if (!bjView.hidden) {
        NSDictionary *dic = [[[[bjDataSource objectForKey:@"note"]objectAtIndex:indexPath.row]objectForKey:@"notelist"]objectAtIndex:0];
        ShowBiJiViewController *next = [[ShowBiJiViewController alloc]initWithDictionary:dic];
        [self.navigationController pushViewController:next animated:YES];
        [next shoucangToBiji:dic];
    }
    if (!glView.hidden) {
        NSDictionary *dic = [[glDataSource objectForKey:@"strategy"]objectAtIndex:indexPath.row];
        GongLueModel *tempModel = [self zuzhuangDic:dic];
        MainScrollViewController *nest = [[MainScrollViewController alloc]init];
        [self.navigationController pushViewController:nest animated:YES];
        [nest setGlModel:tempModel];

    }
    if (!ctView.hidden) {
    }
}


@end
