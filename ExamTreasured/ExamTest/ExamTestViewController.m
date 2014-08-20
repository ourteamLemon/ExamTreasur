//
//  ExamTestViewController.m
//  ExamTreasured
//
//  Created by mac on 14-5-27.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "ExamTestViewController.h"
#import "AnswerCardViewController.h"

#import "ExamTestVC.h"
#import "CCAnswerCard.h"
#import "BlockAlertView.h"
@interface ExamTestViewController ()
@end
@implementation ExamTestViewController
@synthesize datadic;
@synthesize iScrollview;
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
    [super viewDidLoad];

    [self initScrollView];
    [self setNavgation];
    [self setNavtitle];
    [self addNaviRightBtn];

    [self getZTdata];
    [self inittabbarView];
    [self setlabel];
    [self initNSnotification];
    
}

- (void)initNSnotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(uploadtopic:) name:UPLOADTOPIC object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(recevieDicdata:) name:ADDARRAYOBJECT object:nil];
}

/********
 字典中存放着 key == answerstate   三种状态分别是 none(未答题)  right(已经答题并且正确)  wrong(答题错误);
***********/
-(void)initanswerArray :(int)count
{
    if (!answercardArray) {
        answercardArray = [[NSMutableArray alloc]init];
        for (int start = 0; start < count; start++)
        {
            NSDictionary  *dic = [[NSDictionary alloc]initWithObjectsAndKeys:@"none",@"answerstate",nil];
            [answercardArray addObject:dic];
        }
    }
}



- (void)tabbarBtnPressed:(id)sender
{
    UIButton  *btn = (UIButton*)sender;
    int tag = btn.tag;
    NSLog(@"%d",tag);
}

-(void)btnPressed:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    int tag =  btn.tag;
    
    switch (tag) {
        case 206:
            {
//                [self ]
            }
            break;
         case 207:
            {
                AnswerCardViewController *answerVC = [[AnswerCardViewController alloc]initWithNibName:nil bundle:nil Nsarray:answercardArray downindex:(startAnswer+10)];
              UINavigationController  *navCard = [[UINavigationController alloc]initWithRootViewController:answerVC];
              [answerVC setTager:self andAction:@selector(btnPressed1:)];
              [self presentViewController:navCard animated:YES completion:nil];
            }
            break;
          case 208:
            {
                ExamTestVC *examVC = [ArraywithTV objectAtIndex:currentPageNumber];
                [examVC changeSectionView ];
                [self.view setNeedsDisplay];
                
            }
            break;
        case 209:
            {
                BlockAlertView *_alert = [BlockAlertView alertWithTitle:@"提醒" message:@"确定退出当前答题？"];
                [_alert setCancelButtonWithTitle:@"否" block:nil];
                [_alert setDestructiveButtonWithTitle:@"是"  block:^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                }];
                [_alert show];
                
            }
            break;
        default:
            break;
    }
    
}

-(void )initTabbarBtn:(CGRect)rect
                  tag:(int)tag
          centerPoint:(CGPoint)point
                title:(NSString*)title
              imgname:(NSString*)imgname
        imgnameselect:(NSString*)imgnameselect
{
    

    UIButton *fav   = [UIButton buttonWithType:UIButtonTypeCustom];
    fav.frame       = rect;
    fav.center      = point;
    fav.tag         = tag;
    [fav setBackgroundImage:[UIImage imageNamed:imgname] forState:UIControlStateNormal];
    [fav setBackgroundImage:[UIImage imageNamed:imgnameselect] forState:UIControlStateSelected];
    [fav addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    rect = CGRectMake(0, 0, 40, 20);
    UILabel *favLabel           = [[UILabel alloc]init];
    favLabel.frame              = rect;
    CGPoint   tempPoint = CGPointMake(point.x, point.y+17);
    favLabel.center             = tempPoint;
    favLabel.text               = title;
    favLabel.font               = [UIFont systemFontOfSize:10];
    favLabel.textAlignment      = NSTextAlignmentCenter;
    favLabel.textColor          = [UIColor grayColor];
    favLabel.backgroundColor    = [UIColor clearColor];
    [self.tabbarView addSubview:favLabel];
    [self.tabbarView addSubview:fav];
}



#pragma  mark 初始化tabbar
- (void)inittabbarView
{
    self.tabbarView = [[UIView alloc]initWithFrame:CGRectMake(0, MAINSCREENRECT.size.height-20-44-44, 320, 44)];
    self.tabbarView.backgroundColor = [UIColor blueColor];
    
    [self initTabbarBtn:CGRectMake(0, 0, 20, 20)
                    tag:206
            centerPoint:CGPointMake(80/2, 15)
                  title:@"收藏夹"
                imgname:@"sysmain_fav.png"
          imgnameselect:@"sysmain_fav_h.png"];
    
    
    [self initTabbarBtn:CGRectMake(0, 0, 20, 20)
                    tag:207
            centerPoint:CGPointMake(80/2+80, 15)
                  title:@"答题卡"
                imgname:@"answer.png"
          imgnameselect:@"answer@2x.png"];
    
    [self initTabbarBtn:CGRectMake(0, 0,20,20)
                    tag:208
            centerPoint:CGPointMake(80/2+160,15)
                  title:@"解析"
                imgname:@"analysis.png"
          imgnameselect:@"analysisselect.png"];
    
    [self initTabbarBtn:CGRectMake(0, 0, 20, 20)
                    tag:209
            centerPoint:CGPointMake(80/2+240, 15)
                  title:@"交卷"
                imgname:@"upexam.png"
          imgnameselect:@"upexamselect.png" ];

    self.tabbarView.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    [self.view addSubview:self.tabbarView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark 初始化方法
- (id)initWithDictionary:(NSDictionary *)dic index:(int) index
{
    datadic = [[NSDictionary alloc]initWithDictionary:dic];
    gindex = index;
    dataArray = [[NSMutableArray alloc]init];
    ArraywithTV = [[NSMutableArray alloc]init];
    isNeedLoading = YES;
    startAnswer  = 0;
    lastTimesPage = 0;
    self = [super initWithNibName:nil  bundle:nil];
    if (self) {
        currentPageNumber = 0;
    }
    return self;
}

- (void)initScrollView
{
    CGRect  frameRect = CGRectMake(0, self.view.frame.origin.y-20, 320, self.view.frame.size.height-44-44);
    iScrollview = [[UIScrollView alloc]initWithFrame:frameRect];
    iScrollview.pagingEnabled = YES;
    iScrollview.delegate  = self;
    iScrollview.showsVerticalScrollIndicator = NO;
    iScrollview.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:iScrollview];
}

- (void)setScrollviewContentSize
{
    iScrollview.contentSize = CGSizeMake(self.view.frame.size.width*dataArray.count, self.view.frame.size.height-44-20);
}
- (void)setNavtitle
{
    NSString *str = [datadic objectForKey:@"ZTDY_MC"];
    [self setNaviTitle:str];
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
#pragma mark 获取数据
//key:
//ztdy_id
//login_id
//zy_id
//yh_id
//start
//end
- (void)getZTdata
{
    NSString *str = [datadic objectForKey:@"ZTDY_ID"];
    MBProgressHUD  *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSLog(@"%@",str);
    NSString  *startStr  = [NSString stringWithFormat:@"%d",startAnswer];
    NSString  *endStr = [NSString stringWithFormat:@"%d",startAnswer+10];
    NSDictionary  *pardic = [[NSDictionary alloc]initWithObjectsAndKeys:[datadic objectForKey:@"ZTDY_ID"],@"ztdy_id",m_AppDelegate.login_ID,@"login_id",m_AppDelegate.zy_ID,@"zy_id",m_AppDelegate.yh_ID,@"yh_id",startStr ,@"start",endStr,@"end",nil];
    MKNetworkOperation  *op = [m_AppDelegate.networkEngineinstace getdata:pardic path:OVERYEARS_GETTOPICDETAIL httpMethod:POST];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         hub.hidden = YES;
         NSMutableDictionary  *dic = [completedOperation responseJSON];
         NSLog(@"%@",dic);
         int    answerCount = [[dic objectForKey:@"topiccount"]intValue];
         
         if (answerCount <= (startAnswer+10))
         {
             isNeedLoading = NO;
         }
         
         [self initanswerArray:answerCount];
         
         bigarray = [dic objectForKey:@"topiclist"];
         NSArray  *seconTreeArray = [[bigarray objectAtIndex:0]objectForKey:@"list"];
//         [seconTreeArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
//         {
//             [dataArray addObject:obj];
//         }];
//         
         for (int sectionIdex = 0; sectionIdex<seconTreeArray.count ; sectionIdex++)
         {
             [dataArray addObject:seconTreeArray[sectionIdex]];
         }
         
         if (dataArray.count)
         {
             [self setScrollviewContentSize];
             [self initExaminationQuestions];
         }
     }errorHandler:^(MKNetworkOperation *completedOperation, NSError *error)
     {
         hub.hidden = YES;
     }];
}

#pragma mark  initA1类型
-(void)createA1 :(int) index
{
    int arrarycount = [[[bigarray objectAtIndex:index]objectForKey:@"list"] count];
    NSArray  *dataArray1 = [[bigarray objectAtIndex:index]objectForKey:@"list"];
    for (int i = 0 ; i < arrarycount; i++)
    {
        int tag = startAnswer + i;
        ExamTestVC *examTestVC = [[ExamTestVC alloc]initWithStyle:UITableViewStyleGrouped Dictinary:[dataArray1 objectAtIndex:i]  index:tag];
        
        if (IOS7)
        {
            examTestVC.view.center = CGPointMake(320*tag+160, MAINSCREENHEIGHT/2 + 15);
        }
        else
        {
            examTestVC.view.center = CGPointMake(320*tag+160, MAINSCREENHEIGHT/2-10);
        }
        [self.iScrollview addSubview:examTestVC.view];
        [ArraywithTV addObject:examTestVC];
    }
}
#pragma mark  B1类型
-(void)createB1:(int )index
{
    
}

-(void)createA3A4:(int )index
{
    
}


-(void)createA2 :(int) index
{
    NSLog(@"createA2");
    
    int arrarycount = [[[bigarray objectAtIndex:index]objectForKey:@"list"] count];
    NSArray  *dataArray1 = [[bigarray objectAtIndex:index]objectForKey:@"list"];
    for (int i = 0 ; i < arrarycount; i++)
    {
        ExamTestVC *examTestVC = [[ExamTestVC alloc]initWithStyle:UITableViewStyleGrouped Dictinary:[dataArray1 objectAtIndex:i]  index:i];
        if (IOS7)
        {
            examTestVC.view.center = CGPointMake(320*i+160, MAINSCREENHEIGHT/2 + 15);
        }
        else
        {
            examTestVC.view.center = CGPointMake(320*i+160, MAINSCREENHEIGHT/2-10);
        }
        [self.iScrollview addSubview:examTestVC.view];
        [ArraywithTV addObject:examTestVC];
    }

}

#pragma mark 初始化tableview
- (void)initExaminationQuestions
{
    for (int big = 0;big <bigarray.count ; big++)
    {
        if ([[[bigarray objectAtIndex:big] objectForKey:@"topictype"]  isEqualToString:@"A1"])
        {
            [self createA1:big];
        }
        else if([[[bigarray objectAtIndex:big]objectForKey:@"topictype"]isEqualToString:@"B1"])
        {
            [self createB1:big];
        }
        else if([[[bigarray objectAtIndex:big]objectForKey:@"topictype"]isEqualToString:@"A3/A4"])
        {
            [self createA3A4:big];
        }
        else if([[[bigarray objectAtIndex:big]objectForKey:@"topictype"]isEqualToString:@"A2"])
        {
            [self createA2:big];
        }
    }
}



-(void)uploadtopic:(NSNotification *)info
{
//    if(currentPageNumber+1  == ArraywithTV.count-2 && isNeedLoading == YES)
//    {
//        startAnswer = startAnswer +10;
//        [self getZTdata];
//    }
//    else
        if (currentPageNumber+1 < ArraywithTV.count)
    {
        currentPageNumber = currentPageNumber + 1;
        [self.iScrollview setContentOffset:CGPointMake(currentPageNumber*320, 0) animated:YES];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
      currentPageNumber = scrollView.contentOffset.x/320;
      NSLog(@"%d",currentPageNumber = scrollView.contentOffset.x/320);
}

//lys
  
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%d",currentPageNumber = scrollView.contentOffset.x/320);
  
    if (lastTimesPage == currentPageNumber)
    {
        return;
    }
    else
    {
        lastTimesPage = currentPageNumber;
    }
    
    
    if(currentPageNumber+1  == ArraywithTV.count-2 && isNeedLoading == YES)
    {
        startAnswer = startAnswer +10;
        [self getZTdata];
    }
}

//倒计时
-(void)setlabel
{
    _timerExample = [[MZTimerLabel alloc] initWithTimerType:MZTimerLabelTypeTimer];
    [self.view addSubview:_timerExample];
    _timerExample.frame = CGRectMake(0, 0, 80, 40);
    _timerExample.timeLabel.backgroundColor = [UIColor clearColor];
    _timerExample.timeLabel.font = [UIFont systemFontOfSize:14];
    _timerExample.timeLabel.textColor = [UIColor brownColor];
    [_timerExample setCountDownTime:2*60*60];
    _timerExample.timeLabel.textAlignment = NSTextAlignmentCenter; //UITextAlignmentCenter is deprecated in iOS 7.0
    [_timerExample start];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_timerExample];
    _timerExample.delegate = self;
}


-(void)timerLabel:(MZTimerLabel*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    
    NSLog(@"time over");
}

-(void)recevieDicdata:(NSNotification*)info
{
    NSArray *array = [info object];
    int   index = [[array lastObject]intValue];
    [answercardArray  replaceObjectAtIndex:index withObject:[array firstObject]];
}

- (void)btnPressed1:(NSNumber*)cNumber
{
    self.iScrollview.contentOffset = CGPointMake(320*([cNumber intValue]-1),0);
    currentPageNumber  = [cNumber intValue] -1 ;
}

#pragma  mark 收藏按钮按下
//-(void)collectBtnPressed
//{
//    MBProgressHUD  *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
////    storageOverTopic.OVERTOPICGROUP_I D
////    storageOverTopic.YH_ID
////    storageOverTopic.ZY_IDbigarray
//    NSDictionary  *dic = [NSDictionary alloc]initWithObjectsAndKeys:@"" ,@"", nil];
//    
//    
//    MKNetworkOperation  *op = [m_AppDelegate.networkEngineinstace getdata:pardic path:STORAGE_ADDOVERTOPIC httpMethod:POST];
//    
//    
//    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
//     {
//         hub.hidden = YES;
//         NSMutableDictionary  *dic = [completedOperation responseJSON];
//         NSLog(@"%@",dic);
//         int    answerCount = [[dic objectForKey:@"count"]intValue];
//         [self initanswerArray:answerCount];
//         bigarray = [dic objectForKey:@"topiclist"];
//         NSArray  *seconTreeArray = [[bigarray objectAtIndex:0]objectForKey:@"list"];
//         [seconTreeArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
//          {
//              [dataArray addObject:obj];
//          }];
//         if (dataArray.count)
//         {
//             [self setScrollviewContentSize];
//             [self initExaminationQuestions];
//         }
//     }errorHandler:^(MKNetworkOperation *completedOperation, NSError *error)
//     {
//         hub.hidden = YES;
//     }];
//
//}
@end
