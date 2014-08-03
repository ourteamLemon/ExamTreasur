//
//  SmartViewController.m
//  ExamTreasured
//
//  Created by mac on 14-5-28.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "SmartViewController.h"

@interface SmartViewController ()

@end

@implementation SmartViewController
@synthesize itableview;
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
    [self initSetTableView];
    [self addNaviRightBtn];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)initSetTableView
{
    itableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    itableview.delegate = self;
    itableview.dataSource = self;
    [self.view addSubview:itableview];
    
    
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sss"];
    
    
    
    return cell;
}



@end
