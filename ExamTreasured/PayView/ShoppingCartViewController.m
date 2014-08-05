//
//  ShoppingCartViewController.m
//  ExamTreasured
//
//  Created by LYS on 14-8-6.
//  Copyright (c) 2014年 LYS. All rights reserved.
//

#import "ShoppingCartViewController.h"

@interface ShoppingCartViewController ()

@end

@implementation ShoppingCartViewController

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
    // Do any additional setup after loading the view.
}
-(void)inittableView
{
    self.iTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 200) style:UITableViewStylePlain];
    self.iTableView.dataSource = self;
    self.iTableView.delegate = self;
    [self.view addSubview:self.iTableView];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}

@end
