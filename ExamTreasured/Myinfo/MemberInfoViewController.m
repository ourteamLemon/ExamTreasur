//
//  MemberInfoViewController.m
//  ExamTreasured
//
//  Created by mac on 14-5-28.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "MemberInfoViewController.h"

@interface MemberInfoViewController ()

@end

@implementation MemberInfoViewController

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
    [self initcontroller];
    [self setNavgation];
    [self getDataSource];
    [self addNaviRightBtn];

    
}
- (void)setNavgation
{
    self.view.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    [self addNaviLeftBtnWithImageName:@"back" andFrame:CGRectMake(0, 2,30,30) target:self action:@selector(backController)];
    
    
    [self setNaviTitle:@"会员中心"];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getDataSource
{
    NSDictionary  *dic = [[NSDictionary alloc]initWithObjectsAndKeys:m_AppDelegate.zy_ID,@"zy_id",nil];
    MKNetworkOperation  *op = [m_AppDelegate.networkEngineinstace getdata:dic path:MEMBER_GETMEMBERLIST httpMethod:POST];
    MBProgressHUD  *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         NSArray  *dic = [completedOperation responseJSON];
         NSLog(@"%@",dic);
         hub.hidden = YES;
     }errorHandler:^(MKNetworkOperation *completedOperation, NSError *error)
     {
         hub.hidden = YES;
     }];
}

- (void)initcontroller
{
    int height;
    if (IOS7)
    {
        height = 74;
        
    }
    else
    {
        height = 10;
    }
    
    UILabel  *titleone = [[UILabel alloc]initWithFrame:CGRectMake(10, height, 200, 20)];
    titleone.text = @"您当前的积分：";
    [self.view addSubview:titleone];
    
    UIView  *lineview =[[UIView alloc]initWithFrame:CGRectMake(0, 0, titleone.frame.origin.y+titleone.frame.size.height + 20, 2)];
    lineview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:lineview];
    
    UILabel  *yongyou = [[UILabel alloc]initWithFrame:CGRectMake(10, lineview.frame.origin.y+20, 200, 20)];
    yongyou.text = @"您所拥有的权限:";
    [self.view addSubview:titleone];
    
    UIView   *contentView = [[UIView alloc]initWithFrame:CGRectMake(10, yongyou.frame.origin.y+yongyou.frame.size.height+10, 300, 100)];
    contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
    
    
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
