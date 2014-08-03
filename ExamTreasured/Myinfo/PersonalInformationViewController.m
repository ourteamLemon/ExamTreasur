//
//  PersonalInformationViewController.m
//  ExamTreasured
//
//  Created by mac on 14-5-28.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "PersonalInformationViewController.h"
#import "ReadAndWrite.h"
@interface PersonalInformationViewController ()
@end
@implementation PersonalInformationViewController

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
    self.view.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    [self addNaviRightBtn];

    [self setNavgation];
    // Do any additional setup after loading the view.
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
- (void)setNavgation
{
    [self addNaviLeftBtnWithImageName:@"back" andFrame:CGRectMake(0, 2,30,30) target:self action:@selector(backController)];
    
    [self setNaviTitle:@"个人信息"];
    
    UIImage *nav_background = [UIImage imageNamed:@"navgation"];
    [self setNaviBackGroundWithImage:nav_background];
    
    ReadAndWrite  *rw = [[ReadAndWrite alloc]init];
    NSDictionary  *readdic = [rw  readPlistFile];
    [self initController:readdic];
    
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


- (void)initController :(NSDictionary*)dic
{
    int  height = 0;
    
    if (IOS7)
    {
        height = 64;
    }
    else
    {
        height = 0;
    }
    
    UIView *infoview = [[UIView alloc]initWithFrame:CGRectMake(10, height, 300, 250)];
    infoview.backgroundColor = [UIColor clearColor];
    
    UILabel *namelabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 200, 25)];
    NSString  *nameStr = [[NSString alloc]initWithFormat:@"账号：%@",[dic objectForKey:@"" ]];
    namelabel.text = nameStr;
    [infoview addSubview:namelabel];
    
    UILabel *nerolabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 30, 200, 25)];
    NSString  *nerolabelstr = [[NSString alloc]initWithFormat:@"昵称：%@",[dic objectForKey:@"" ]];
    nerolabel.text = nerolabelstr;
    [infoview addSubview:nerolabel];
    
    UILabel *phonenumb = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, 200, 25)];
    NSString  *phonenumbstr = [[NSString alloc]initWithFormat:@"手机账号：%@",[dic objectForKey:@"" ]];
    phonenumb.text = phonenumbstr;
    [infoview addSubview:phonenumb];
    
    UILabel *emaillabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 80, 200, 25)];
    NSString  *emaillabelstr = [[NSString alloc]initWithFormat:@"常用邮箱：%@",[dic objectForKey:@"" ]];
    emaillabel.text = emaillabelstr;
    [infoview addSubview:emaillabel];

    infoview.layer.shadowColor = [[UIColor grayColor]CGColor];
    infoview.layer.borderWidth = 2;
    infoview.layer.borderColor = [[UIColor grayColor]CGColor];
    [self.view addSubview:infoview];
    
}
@end
