//
//  ChapterQAViewController.m
//  ExamTreasured
//
//  Created by mac on 14-7-21.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "ChapterQAViewController.h"
#import "ChapterA1ViewController.h"
@interface ChapterQAViewController ()

@end

@implementation ChapterQAViewController

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
//    [super viewDidLoad];
    
    [self initScrollView];
    [self setNavgation];
    [self setNavtitle];
    [self getZTdata];
    [self inittabbarView];
}

-(void)initA1 :(int) index
{
    int arrarycount = [[[bigarray objectAtIndex:index]objectForKey:@"list"] count];
    NSArray  *dataArray1 = [[bigarray objectAtIndex:index]objectForKey:@"list"];
    for (int i = 0 ; i < arrarycount; i++)
    {
        ChapterA1ViewController *examTestVC = [[ChapterA1ViewController alloc]initWithStyle:UITableViewStyleGrouped Dictinary:[dataArray1 objectAtIndex:i]  index:i];
        [ArraywithTV addObject:examTestVC];
        if (IOS7)
        {
            examTestVC.view.center = CGPointMake(320*i+160, MAINSCREENHEIGHT/2);
        }
        else
        {
            examTestVC.view.center = CGPointMake(320*i+160, MAINSCREENHEIGHT/2-10);
        }
        [self.iScrollview addSubview:examTestVC.view];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
