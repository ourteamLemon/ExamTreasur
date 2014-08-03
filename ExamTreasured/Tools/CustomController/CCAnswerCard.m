//
//  CCAnswerCard.m
//  ExamTreasured
//
//  Created by yuan on 14-5-21.
//  Copyright (c) 2014年 yuan. All rights reserved.
///********
//字典中存放着 key == answerstate   三种状态分别是 none(未答题)  right(已经答题并且正确)  wrong(答题错误);
//***********/

#import "CCAnswerCard.h"
#define TAGCOUNT 1000
@interface CCAnswerCard ()

@end

@implementation CCAnswerCard

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithFrame:(CGRect)cRect count:(NSNumber*)cNumber
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.view.frame = cRect;
        iCount = [cNumber integerValue];
        [self initializationUI];
    }
    return self;
    
}

- (id)initWithFrame:(CGRect)cRect Nsarray:(NSArray*)arrayAnswer
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.view.frame = cRect;
//        self.title = @"答题卡";
        _arrayAnswer = [[NSArray alloc]initWithArray:arrayAnswer];
        [self initializationUIArray];
    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self setNavgation];
}

//- (void)setNavgation
//{
//    [self addNaviLeftBtnWithImageName:@"back" andFrame:CGRectMake(0, 2,30,30) target:self action:@selector(back:)];
//    UIImage *nav_background = [UIImage imageNamed:@"navgation"];
//    [self setNaviBackGroundWithImage:nav_background];
//}


//-(void)back:(id)sender
//{
//    if ([self.navigationController.childViewControllers objectAtIndex:0] == self)
//    {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
//    else
//    {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//}

- (void)initializationUI
{
    UIScrollView *iScrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    iScrollView.scrollEnabled = YES;
    iScrollView.backgroundColor = [UIColor clearColor];
    iScrollView.showsHorizontalScrollIndicator = YES;
    iScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:iScrollView];
    
    float width = (self.view.frame.size.width - 7) / 6.0;
    int row = (int)ceilf(iCount / 6.0) ;
    int list;
    
    [iScrollView setContentSize:CGSizeMake(self.view.frame.size.width, 1+row*(width+1))];
    
    CGRect rect = CGRectMake(0, 0, width, width);
    CGPoint point;
    for (int i = 0; i < row; i++) {
        BOOL bcount = (i+1) * 6 > iCount;
        list = bcount? iCount % 6 : 6;
        for (int j = 0; j < list; j++) {
            UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            tempBtn.frame = rect;
            point = CGPointMake(width/2.0+1+j*(width+1), width/2.0+1+i*(width+1));
            tempBtn.center = point;
            tempBtn.tag = TAGCOUNT + i*6+1+j;
            [tempBtn setTitle:[NSString stringWithFormat:@"%d",i*6+1+j] forState:UIControlStateNormal];
            [iScrollView addSubview:tempBtn];
            [tempBtn setBackgroundColor:[UIColor grayColor]];
            [tempBtn addTarget:self action:@selector(btnPressedSelect:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}

- (void)btnPressedSelect:(id)sender
{
    UIButton *tempBtn = (UIButton*)sender;
    int tempTag = (int)tempBtn.tag - TAGCOUNT;
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    // Configure for text only and offset down
//    hud.mode = MBProgressHUDModeText;
//    hud.labelText = [NSString stringWithFormat:@"您点击了第%d个",tempTag];
//    hud.margin = 5.f;
//    hud.yOffset = MAINSCREENHEIGHT/2.0f - 65;
//    hud.removeFromSuperViewOnHide = YES;
//    [hud hide:YES afterDelay:3];
//    [m_AppDelegate.window addSubview:hud];
//    [self back:nil];
    NSNumber *ctag = [NSNumber numberWithInt:tempTag];
    if (obTager && obAction)
    {
        [obTager performSelector:obAction withObject:ctag afterDelay:0];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)initializationUIArray
{
    UIScrollView *iScrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    iScrollView.scrollEnabled = YES;
    iScrollView.backgroundColor = [UIColor clearColor];
    iScrollView.showsHorizontalScrollIndicator = YES;
    iScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:iScrollView];
    
    float width = (self.view.frame.size.width - 7) / 6.0;
    int row = (int)ceilf(_arrayAnswer.count / 6.0) ;
    int list;
    
    [iScrollView setContentSize:CGSizeMake(self.view.frame.size.width, 1+row*(width+1))];
    
    CGRect rect = CGRectMake(0, 0, width, width);
    CGPoint point;
    for (int i = 0; i < row; i++) {
        BOOL bcount = (i+1) * 6 > _arrayAnswer.count;
        list = bcount? _arrayAnswer.count % 6 : 6;
        for (int j = 0; j < list; j++) {
            UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            tempBtn.frame = rect;
            point = CGPointMake(width/2.0+1+j*(width+1), width/2.0+1+i*(width+1));
            tempBtn.center = point;
            tempBtn.tag = TAGCOUNT + i*6+1+j;
            NSDictionary  *dic = [_arrayAnswer objectAtIndex: tempBtn.tag - TAGCOUNT-1];
            if ([[dic objectForKey:@"answerstate"]isEqualToString:@"none"])
            {
                [tempBtn setBackgroundColor:[UIColor grayColor]];
                
            }else if([[dic objectForKey:@"answerstate"]isEqualToString:@"right"])
            {
                [tempBtn setBackgroundColor:[UIColor greenColor]];
            }
            else
            {
                [tempBtn setBackgroundColor:[UIColor redColor]];
                
            }
            [tempBtn setTitle:[NSString stringWithFormat:@"%d",i*6+1+j] forState:UIControlStateNormal];
            [iScrollView addSubview:tempBtn];
            [tempBtn addTarget:self action:@selector(btnPressedSelect:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}
- (void)setTager:(id)aTager andAction:(SEL)aAction
{
    obTager = aTager;
    obAction = aAction;
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