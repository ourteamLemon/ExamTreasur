//
//  AnswerCardViewController.m
//  ExamTreasured
//
//  Created by mac on 14-7-9.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "AnswerCardViewController.h"

@interface AnswerCardViewController ()
@end
@implementation AnswerCardViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil Nsarray:(NSArray*)answercardArray
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        receiveArray = answercardArray;
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
        [self dismissViewControllerAnimated:YES completion:nil ];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    answerCard = [[CCAnswerCard alloc]initWithFrame:self.view.frame Nsarray:receiveArray];
    [self.view addSubview:answerCard.view];
    [answerCard setTager:self andAction:@selector(btnPressed:)];
    [self setNavgation];
}

- (void)btnPressed:(NSNumber*)cNumber
{
    if (obTager && obAction)
    {
        [obTager performSelector:obAction withObject:cNumber afterDelay:0];
    }
    [self backController];
}


- (void)setTager:(id)aTager andAction:(SEL)aAction
{
    obTager = aTager;
    obAction = aAction;
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
