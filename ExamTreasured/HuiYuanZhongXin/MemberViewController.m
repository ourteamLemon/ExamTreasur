//
//  MemberViewController.m
//  ExamTreasured
//
//  Created by yuan on 14-5-21.
//  Copyright (c) 2014年 yuan. All rights reserved.
//

#import "MemberViewController.h"
#import "AboutViewController.h"
#import "MemberInfoViewController.h"
#import "PersonalInformationViewController.h"
#import "HelpCenterViewController.h"
@interface MemberViewController ()

@end

@implementation MemberViewController
@synthesize iTableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavgation];
    [self initiTableView];
    [self addNaviRightBtn];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithtitle :(NSString*)titleString
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        [self setNaviTitle:titleString];
        
    }
    return self;
}


- (void)initiTableView
{
    
    iTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 350) style:UITableViewStyleGrouped];
    iTableView.delegate = self;
    iTableView.dataSource = self;
    iTableView.scrollEnabled = NO;
    iTableView.layer.cornerRadius = 5;
    
    UIView  *itableViewBack = [[UIView alloc]initWithFrame:iTableView.frame];
    itableViewBack.backgroundColor = [UIColor clearColor];
    iTableView.backgroundView = itableViewBack;
    
    [self.view addSubview:self.iTableView];
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
        return 3;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1)
    {
        UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,40)];
        
        headview.backgroundColor = [UIColor clearColor];
        UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake( 20, 0, 280, 40)];
        [titlelabel setNumberOfLines:0];
        titlelabel.text = @"在这里您可以浏览您的个人账户信息以及会员相关信息";
        titlelabel.font = [UIFont systemFontOfSize:14];
        titlelabel.textColor = [UIColor colorWithRed:42/255.0 green:42/255.0 blue:42/255.0 alpha:1];
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
    
    UITableViewCell*  cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.backgroundView.backgroundColor = [UIColor clearColor];
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
                 cell.textLabel.text = @"账户信息";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
            }break;
            case 1:
            {
                cell.textLabel.text = @"会员信息";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
            }
                break;
        }
    }
    else
    {
        
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text =  @"当前版本";
            }
                break;
            case 1:
            {
                cell.textLabel.text = @"帮助中心";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
            }
                break;
            case 2:
            {
                cell.textLabel.text = @"关于";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            }
                break;
            default:
                break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        switch (indexPath.row) {
            case 0:
                {
                    PersonalInformationViewController  *personVC = [[PersonalInformationViewController alloc]initWithNibName:nil bundle:nil];
                    [self.navigationController pushViewController:personVC animated:YES];
                }
                break;
            case 1:
            {
                MemberInfoViewController *memBerVC = [[MemberInfoViewController alloc]initWithNibName:nil bundle:nil];
                [self.navigationController pushViewController:memBerVC animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
    else
    {
        
        switch (indexPath.row) {
            case 0:
                {
                    
                }
                break;
            case 1:
            {
                HelpCenterViewController *helpVC = [[HelpCenterViewController alloc]initWithNibName:nil bundle:nil];
                [self.navigationController pushViewController:helpVC animated:YES];
            }
                break;
            case 2:
            {
                AboutViewController *aboutVC = [[AboutViewController alloc]init];
            UINavigationController *abNav = [[UINavigationController alloc]initWithRootViewController:aboutVC];
            [self presentViewController:abNav animated:YES completion:nil];
            }
                break;
                
            default:
                break;
        }
    }
}

@end
