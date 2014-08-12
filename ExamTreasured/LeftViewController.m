//
//  LeftViewController.m
//  ExamTreasured
//
//  Created by mac on 14-5-11.
//  Copyright (c) 2014年 mac. All rights reserved.
//


#import "LeftViewController.h"
@interface LeftViewController ()
@end
@implementation LeftViewController

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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"slidingmenu_bg.png"]];
    zyBtnArray = [[NSMutableArray alloc]init];
    [self initController];
    [self getAllProfession];
    
    
}
//init controll
-(void)initController
{
    NSLog(@"%f",self.view.frame.size.width);
    CGRect rect;
    CGRect rect1;
    if (IOS7) {
        rect1 = CGRectMake(0, 20, 320, 85);
        
        UIView *state = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        state.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:state];
    }
    else{
        rect1 = CGRectMake(0, 0, 320, 85);
    }
    //背景图
    UIView  *logView = [[UIView alloc]initWithFrame:rect1];
    logView.backgroundColor = [UIColor colorWithRed: 93/255.0 green:93/255.0 blue:93/255.0 alpha:1];
    [self.view addSubview:logView];
    
    //登陆按钮
    loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.backgroundColor = [UIColor blackColor];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.textColor = [UIColor whiteColor];
    loginBtn.frame = CGRectMake(20, 4, 200, 50);
    [loginBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.tag = 0;
    [logView addSubview:loginBtn];

    if (m_AppDelegate.login_ID && [m_AppDelegate.login_ID length]>0) {
        UILabel *namelabel = [[UILabel alloc]init];
        namelabel.text = m_AppDelegate.username;
        namelabel.textColor = [UIColor whiteColor];
        namelabel.backgroundColor = [UIColor clearColor];
        namelabel.frame = CGRectMake(10, 4, 100, 50);
        [logView addSubview:namelabel];
        
        [loginBtn setTitle:@"注销" forState:UIControlStateNormal];
        [loginBtn removeTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [loginBtn addTarget:self action:@selector(logoutBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        loginBtn.frame = CGRectMake(170, 4, 60, 50);
        
    }
    else{
        [loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
        [loginBtn removeTarget:self action:@selector(logoutBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [loginBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        loginBtn.frame = CGRectMake(20, 4, 200, 50);

    }
    
    //划线
    rect = CGRectMake(0, 58, 320, 2);
    UIView *line = [[UIView alloc]initWithFrame:rect];
    line.backgroundColor = [UIColor colorWithRed:135/255.0 green:135/255.0 blue:135/255.0 alpha:1.0f];
    [logView addSubview:line];
    
    //选择职业label
    rect = CGRectMake(0, 60, 240, 25);
    UILabel *selectJobLabel = [[UILabel alloc]initWithFrame:rect];
    selectJobLabel.text = @"请选择职业";
    selectJobLabel.backgroundColor = [UIColor clearColor];
    selectJobLabel.textAlignment = NSTextAlignmentCenter;
    selectJobLabel.textColor = [UIColor whiteColor];
    [logView addSubview:selectJobLabel];
    
    //主view
    rect1 = CGRectMake(0, rect1.origin.y+rect1.size.height, 320, MAINSCREENRECT.size.height-rect1.origin.y-rect1.size.height);
    mainView = [[UIView alloc]initWithFrame:rect1];
    mainView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:mainView];
    
}
- (void)getAllProfession
{
    NSDictionary  *partdic = [[NSDictionary alloc]initWithObjectsAndKeys:@"type",@"临床执业", nil];
    MKNetworkOperation  *op = [m_AppDelegate.networkEngineinstace getdata:partdic path:PROFESSION_GETALL httpMethod:POST];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         NSArray  *arr = [completedOperation responseJSON];
         NSLog(@"%@",arr);
         if (arr && [arr count]>0) {
             m_AppDelegate.allProfession = arr;
             [self addProfessionBtn:arr];
         }
     }errorHandler:^(MKNetworkOperation *completedOperation, NSError *error)
     {
         
     }];
}
- (void)addProfessionBtn:(NSArray*)iArray
{
    for (int i = 0; i < [iArray count]; i++) {
        CGRect rect;
        //选择职业按钮和label
        rect = CGRectMake(0, i*31, 240, 30);
        UILabel *selectJobLabel1 = [[UILabel alloc]initWithFrame:rect];
        selectJobLabel1.text = [[iArray objectAtIndex:i] objectForKey:@"ZY_MC"];
        selectJobLabel1.backgroundColor = [UIColor clearColor];
        selectJobLabel1.textAlignment = NSTextAlignmentRight;
        selectJobLabel1.textColor = [UIColor whiteColor];
        [mainView addSubview:selectJobLabel1];
        
        UIButton   *selectJob1 = [UIButton buttonWithType:UIButtonTypeCustom];
        selectJob1.backgroundColor = [UIColor clearColor];
        selectJob1.frame = rect;
        [selectJob1 addTarget:self action:@selector(zyBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        selectJob1.tag = [[[iArray objectAtIndex:i] objectForKey:@"ZY_ID"]integerValue];
        [mainView addSubview:selectJob1];
        [zyBtnArray addObject:selectJob1];
        
        //划线
        rect = CGRectMake(0, (i+1)*30, 320, 1);
        UIView *line1 = [[UIView alloc]initWithFrame:rect];
        line1.backgroundColor = [UIColor colorWithRed:135/255.0 green:135/255.0 blue:135/255.0 alpha:0.3f];
        [mainView addSubview:line1];
        
        
#pragma  mark  Crash
        if ([m_AppDelegate.zy_ID isEqualToString:[[iArray objectAtIndex:i] objectForKey:@"ZY_ID"]]) {
            [selectJob1 setBackgroundColor:[UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:0.3f]];
        }

    }
    [m_AppDelegate.middleVC setNaviName:[[iArray objectAtIndex:[m_AppDelegate.zy_ID intValue]-1] objectForKey:@"ZY_MC"]];
}
- (void)zyBtnPressed:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    m_AppDelegate.zy_ID = [NSString stringWithFormat:@"%ld",(long)btn.tag];
    
    NSDictionary  *dic = [[NSDictionary alloc]initWithObjectsAndKeys:m_AppDelegate.zy_ID,@"zy_id",nil];
    ReadAndWrite  *readWrite = [[ReadAndWrite alloc]init];
    [readWrite writePlistFile:dic];
    [btn setBackgroundColor:[UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:0.3f]];
    if (m_AppDelegate.allProfession && [m_AppDelegate.allProfession count]>0) {
        for (int i = 0; i < [m_AppDelegate.allProfession count]; i++) {
            if (btn.tag == i+1) {
                continue;
            }
            UIButton *tempBtn = (UIButton*)[zyBtnArray objectAtIndex:i];
            [tempBtn setBackgroundColor:[UIColor clearColor]];
        }
    }
    [m_AppDelegate.middleVC setNaviName:[[m_AppDelegate.allProfession objectAtIndex:btn.tag-1] objectForKey:@"ZY_MC"]];
    
    
}
- (void)btnPressed:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    switch (btn.tag) {
        case 0:
        {
            [m_AppDelegate enterLoginView];
        }
        break;
        default:
            break;
    }
}
- (void)logoutBtnPressed:(id)sender
{
    m_AppDelegate.login_ID = @"";
    m_AppDelegate.yh_ID = @"";
    m_AppDelegate.username = @"";
    m_AppDelegate.isLog = NO;
    [self initController];
    ReadAndWrite  *rdwr = [[ReadAndWrite alloc]init];
    if ([rdwr deleteDocument])
    {
        NSLog(@"删除本地账号成功");
    }
    
    [m_AppDelegate assignmentAppvalue];
    [self.view.layer setNeedsDisplay];
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

@end
