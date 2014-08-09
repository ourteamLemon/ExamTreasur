//
//  AboutViewController.m
//  ExamTreasured
//
//  Created by yuan on 14-5-21.
//  Copyright (c) 2014年 yuan. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

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

    [self addNaviLeftBtnWithImageName:@"back" andFrame:CGRectMake(0, 2,30,30) target:self action:@selector(backController)];
    [self setNaviTitle:@"关于"];
    UIImage *nav_background = [UIImage imageNamed:@"navgation"];
    [self setNaviBackGroundWithImage:nav_background];

    [self initializationUI];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    
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

- (void)initializationUI
{
    CGRect rect;
    CGPoint point;
    rect = CGRectMake(0, 0, 80, 80);
    point = CGPointMake(160, 60);
    UIView *logoView = [[UIView alloc]initWithFrame:rect];
    logoView.layer.cornerRadius = 40.0f;
    logoView.center = point;
    logoView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Icons-（80x80）"]];
    [self.view addSubview:logoView];
    
    //版本号
    rect = CGRectMake(0, 0, 320, 30);
    point = CGPointMake(160, 115);
    UILabel *logoLabel = [[UILabel alloc]initWithFrame:rect];
    logoLabel.center = point;
    logoLabel.text = @"柳叶征图 0.2";
    logoLabel.backgroundColor = [UIColor clearColor];
    logoLabel.textColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1];
    logoLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:logoLabel];
    
    //简介
    rect = CGRectMake(0, 0, 280, 300);
    point = CGPointMake(160, 265);
    UILabel *aboutLabel = [[UILabel alloc]initWithFrame:rect];
    aboutLabel.center = point;
    aboutLabel.textColor = [UIColor blackColor];
    aboutLabel.backgroundColor = [UIColor clearColor];
    aboutLabel.lineBreakMode = NSLineBreakByWordWrapping;
    aboutLabel.numberOfLines = 0;
    aboutLabel.font = [UIFont systemFontOfSize:14.0f];
    aboutLabel.text = @"医考宝典\n\t\t医考宝典；包括医考宝典网以及医考宝典移动应用客户端，是由中华医学会相关专家进行协调组织，中国医师协会培训部、中国人民解放军第四军医大学、北京大学医学部、上海交通大学医学院等机构院校的名师教授倾力协助，并联合互联网精英共同打造的一款，针对医学教育培训所设计的专业学习助手软件。\n\t\t医考宝典，针对医师考试紧迫性强、专业性强等问题，在历时一年的时间里通过专业人员反复的征询测试，依托于医学考试专家组多年来对医考命题规律的透彻分析及对命题趋势的精准判断，以帮助考生实现海量知识的快速理解和高效复习。";
    [self.view addSubview:aboutLabel];
    
    //版本号
    rect = CGRectMake(0, 0, 320, 20);
    point = CGPointMake(160, IOS7?self.view.frame.size.height-10-44-20:self.view.frame.size.height-20-44);
    UILabel *copyright = [[UILabel alloc]initWithFrame:rect];
    copyright.center = point;
    copyright.text = @"©2014南京风尚信息科技有限公司.版权所有.";
    copyright.backgroundColor = [UIColor clearColor];
    copyright.font = [UIFont systemFontOfSize:11.0f];
    copyright.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1];
    copyright.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:copyright];

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

@end
