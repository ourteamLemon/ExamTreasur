//
//  GuoLueYuanViewController.m
//  ExamTreasured
//
//  Created by shagua on 14-5-20.
//  Copyright (c) 2014年 shagua. All rights reserved.
//

#import "GuoLueYuanViewController.h"
#import "GongLueModel.h"
#import "UIButton+UIButtonImageWithLable.h"
#import "UIImageView+WebCache.h"
#import "GongLueViewController.h"
#import "MBProgressHUD.h"
@interface GuoLueYuanViewController ()

@end

@implementation GuoLueYuanViewController

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
    dataArray = [[NSMutableArray alloc]init];
    midIndexArr = [[NSMutableArray alloc]init];
    maxIndexArr = [[NSMutableArray alloc]init];
    
    [self getSourData];
    [self addNaviRightBtn];
    [self addNaviLeftBtnWithImageName:@"back" andFrame:CGRectMake(0, 2,30,30) target:self action:@selector(backController)];
    [self setNaviTitle:@"攻略园"];
    
    UIImage *nav_background = [UIImage imageNamed:@"navgation"];
    [self setNaviBackGroundWithImage:nav_background];
}
- (void)backController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getSourData
{
    
    NSLog(@"%@",m_AppDelegate.zy_ID);
    NSLog(@"%@", m_AppDelegate.yh_ID);
    NSDictionary  *dic = [[NSDictionary alloc]initWithObjectsAndKeys:m_AppDelegate.zy_ID,@"zy_id",
                          m_AppDelegate.yh_ID,@"yh_id",nil];
    
    MKNetworkOperation *op =   [m_AppDelegate.networkEngineinstace  getdata:dic path:STRATEGY_GETALLSTRATE httpMethod:POST];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         NSDictionary *dic = [completedOperation responseJSON];
         
         if (((NSArray *)[dic objectForKey:@"strategyInfos"]).count)
         {
             NSArray *arr = [dic objectForKey:@"strategyInfos"];
             [self zuzhuangArray:arr];
             [self sortDataArray];
             NSString *returnStr = [[arr objectAtIndex:0] objectForKey:@"PS_ZW"];
             NSLog(@"%@",returnStr);
             NSInteger page = (int)ceilf([dataArray count] / 6.0) ;
             UIScrollView *iScrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
             iScrollV.contentSize = CGSizeMake(page*320, self.view.frame.size.height);
             iScrollV.pagingEnabled = YES;
             for (int i = 0; i < page; i++) {
                 NSNumber *max = [NSNumber numberWithInteger:([[maxIndexArr objectAtIndex:i]integerValue]-i*6)];
                 NSNumber *mid = [NSNumber numberWithInteger:([[midIndexArr objectAtIndex:i]integerValue]-i*6)];

                 UIView *iview = [self buttonMaxNumber:max midNumber:mid x:i*320 andPage:i];
                 if (iview == nil) {
                     break;
                 }
                 [iScrollV addSubview:iview];
             }
             [self.view addSubview:iScrollV];
         }
         
     } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
         
     }];
}


- (UIView*)buttonMaxNumber:(NSNumber*)maxNumber midNumber:(NSNumber*)midNumber x:(NSInteger)x andPage:(int)aPage
{
    
    NSInteger maxCount = [maxNumber integerValue];
    NSInteger midCount = [midNumber integerValue];
    
    UIView *retView = [[UIView alloc]initWithFrame:CGRectMake(x, 0, 320, self.view.frame.size.height)];
    int ip5 = IOS7?20:0;
    float mainHeight = (MAINSCREENHEIGHT-44-ip5)*(1-0.618);
    float allHeight = (MAINSCREENHEIGHT-44-ip5)*0.618/3;
    int list = 2;
    int current = 0;
    for (int i = 0; i<4; i++) {//行
        if (current==midCount || current==maxCount) {
            list = 1;
        }
        else{
            list = 2;
        }
        for (int j = 0; j<list; j++) {//列
            if (!dataArray || current+aPage*6 >= [dataArray count]) {
                return retView;
            }

            UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [tempBtn setHighlighted:NO];
            [retView addSubview:tempBtn];
            NSLog(@"%d",current+aPage*6);
            GongLueModel *tempModel = (GongLueModel*)[dataArray objectAtIndex:current+aPage*6];
            tempBtn.tag = current+aPage*6;
            [tempBtn addTarget:self action:@selector(gonglueBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
            NSString *urlStr = tempModel.GL_cover;
            
//            UIImageView *imageV = [[UIImageView alloc]init];
//            [imageV setImageWithURL:[NSURL URLWithString:urlStr]];
//            imageV.frame = tempBtn.frame;
            
            CGRect rect;
            if (current == maxCount) {
                rect = CGRectMake(j*160, i*allHeight, 320/list, mainHeight);
                [tempBtn setBackgroundColor:[UIColor colorWithPatternImage:[AppDelegate clipImage:[m_AppDelegate loadWebImage:urlStr] clipSize:rect.size]]];
                [tempBtn setImage:nil withTitle:tempModel.GL_BT forState:UIControlStateNormal];
                [tempBtn setTintColor:[UIColor whiteColor]];
            }
            else if(current < maxCount){
                rect = CGRectMake(j*160, i*allHeight, 320/list, allHeight);
                [retView addSubview:[self creatUIButtonTitle:tempModel withRect:rect]];
            }
            else if(current > maxCount){
                rect = CGRectMake(j*160, (i-1)*allHeight+mainHeight, 320/list, allHeight);
                [retView addSubview:[self creatUIButtonTitle:tempModel withRect:rect]];
            }
            
            tempBtn.frame = rect;
            
            current++;
        }
    }
    return retView;
}
- (UIView *)creatUIButtonTitle:(GongLueModel*)aModel withRect:(CGRect)aRect
{
    UIView *btnBackGround = [[UIView alloc]init];
    btnBackGround.frame = aRect;
    btnBackGround.backgroundColor = [UIColor clearColor];
    btnBackGround.layer.borderWidth = 1;
    btnBackGround.layer.borderColor = [[UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1] CGColor];
    btnBackGround.userInteractionEnabled = NO;


    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = [NSString stringWithFormat:@"%@\n——%@",aModel.GL_BT,aModel.GL_AUTHOR];
    //自动折行设置
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.numberOfLines = 0;
    UIFont *font;
    if (isIPhone5) {
        font = [UIFont fontWithName:@"Arial" size:14.0];
    }
    else{
        font = [UIFont fontWithName:@"Arial" size:11.0];
    }
    titleLabel.font = font;
    CGSize size = CGSizeMake(aRect.size.width-20,CGFLOAT_MAX);//LableWight标签宽度，固定的
    CGSize labelsize = [titleLabel.text sizeWithFont:font constrainedToSize:size lineBreakMode:titleLabel.lineBreakMode];
    titleLabel.frame = CGRectMake(10,10, labelsize.width, labelsize.height);
    [btnBackGround addSubview:titleLabel];


    return btnBackGround;
}
- (void)zuzhuangArray:(NSArray*)iArray
{
    for (int i = 0; i<[iArray count]; i++) {
        NSDictionary *tempDic = [iArray objectAtIndex:i];
        GongLueModel *tempGongLue = [[GongLueModel alloc]init];
        if (tempDic) {
            tempGongLue.GL_ID = [tempDic objectForKey:@"PS_ID"];
            tempGongLue.GL_BT = [tempDic objectForKey:@"PS_BT"];
            tempGongLue.GL_UPDATE_TIME = [tempDic objectForKey:@"PS_createTime"];
            tempGongLue.GL_READ_COUNT = [tempDic objectForKey:@"PS_revertCount"];
            tempGongLue.GL_AUTHOR = [tempDic objectForKey:@"PS_author"];
            tempGongLue.SC_ID = [tempDic objectForKey:@"storStrategyId"];
            tempGongLue.GL_cover = [NSString stringWithFormat:@"http://%@:%d%@",HOST,PROT,[tempDic objectForKey:@"PS_cover"]];
            tempGongLue.ZY_ID = [tempDic objectForKey:@"ZY_ID"];
            tempGongLue.GL_LASTREVERTTIME = [tempDic objectForKey:@"PS_lastRevertTime"];
            tempGongLue.GL_LASTREVERT = [tempDic objectForKey:@"PS_lastRevert"];
            tempGongLue.GL_CLICKCOUNT = [tempDic objectForKey:@"PS_clickCount"];
        }
        [dataArray addObject:tempGongLue];
    }
}

- (void)sortDataArray
{
    if (dataArray) {
        NSInteger page = (int)ceilf([dataArray count] / 6.0) ;
        NSInteger countOfPage;
        for (int i = 0; i < page; i++) {
            BOOL bcount = (i+1) * 6 > [dataArray count];
            countOfPage = bcount? [dataArray count] % 6 : 6;
            NSInteger maxRever = 0;//每夜最大回复数
            NSInteger maxIndex = i*6;//最大回复的索引
            
            NSInteger midRever = 0;//每夜第二大回复数
            NSInteger midIndex = i*6;//第二大回复的索引
            
            for (int j = 0; j<countOfPage; j++) {
                NSInteger k = i*6+j;
                NSInteger currentRever = [((GongLueModel*)[dataArray objectAtIndex:k]).GL_READ_COUNT  integerValue];
                if (maxRever < currentRever) {
                    maxRever = currentRever;
                    maxIndex = k;
                }
            }
            [maxIndexArr addObject:[NSNumber numberWithInteger:maxIndex]];
            
            for (int j = 0; j<countOfPage; j++) {
                NSInteger k = i*6+j;
                NSInteger currentRever = [((GongLueModel*)[dataArray objectAtIndex:k]).GL_READ_COUNT  integerValue];
                if (midRever < maxRever && midRever < currentRever && currentRever < maxRever) {
                    midRever = currentRever;
                    midIndex = k;
                }
                else{
                    if ((maxIndex+1) % 2 == 0) {
                        midIndex = maxIndex-1;
                    }
                    else
                        midIndex = maxIndex+1;
                }
            }
            [midIndexArr addObject:[NSNumber numberWithInteger:midIndex]];
            
            if (midIndex < maxIndex) {
                if ((midIndex+1) % 2 == 0) {
                    [self changeArr:midIndex];
                }
                if ((maxIndex+1) % 2 == 1) {
                    [self changeArr:maxIndex];
                }
            }else{
                if ((maxIndex+1) % 2 == 0) {
                    [self changeArr:maxIndex];
                }
                if ((midIndex+1) % 2 == 1) {
                    [self changeArr:midIndex];
                }
            }
            
        }
    }
    NSLog(@"%@\n%@",maxIndexArr,midIndexArr);
}
- (void)changeArr:(NSInteger)iIndex
{
    NSDictionary *tempDic = [dataArray objectAtIndex:iIndex];
    [dataArray insertObject:[dataArray objectAtIndex:(iIndex-1)] atIndex:iIndex];
    [dataArray insertObject:tempDic atIndex:(iIndex-1)];
}
//
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)gonglueBtnPressed:(id)sender
{
    UIButton *tempBtn = (UIButton*)sender;
    if (dataArray && [dataArray count]>tempBtn.tag) {
        GongLueModel *tempModel = [dataArray objectAtIndex:tempBtn.tag];
        GongLueViewController *nest = [[GongLueViewController alloc]init];
        [self.navigationController pushViewController:nest animated:YES];
        [nest setGlModel:tempModel];
    }
}
@end
