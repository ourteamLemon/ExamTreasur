//
//  ChapterA1ViewController.m
//  ExamTreasured
//
//  Created by mac on 14-7-21.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "ChapterA1ViewController.h"
@interface ChapterA1ViewController ()
@end

@implementation ChapterA1ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {

    }
    return self;
}

- (void)viewDidLoad
{
    [self  initTableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.sectionView = [[UIView alloc]init];
    
    // 显示字体的高度
    NSString  *needCountHeightStr = [[[self.dataDict objectForKey:@"topics"]objectAtIndex:0]objectForKey:@"TM_JX"];
    CGFloat  sectionHeight =  [self calculateSectionHeight:needCountHeightStr];
    UILabel  *analysislabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, sectionHeight+10)];
    analysislabel.text = needCountHeightStr;
    analysislabel.numberOfLines = 0;
    analysislabel.textColor = [UIColor blueColor];
    analysislabel.font = [UIFont systemFontOfSize:15];
    analysislabel.backgroundColor = [UIColor clearColor];
    
    self.sectionView.frame= CGRectMake(0,0,320,sectiononeHeight+25);
    [self.sectionView addSubview:analysislabel];
    self.sectionView.hidden = YES;
    // Do any additional setup after loading the view.
    
    NSLog(@"lijingmingTEST");
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
