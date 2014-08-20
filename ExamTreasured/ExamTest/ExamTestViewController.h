//
//  ExamTestViewController.h
//  ExamTreasured
//
//  Created by mac on 14-5-27.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZTimerLabel.h"
@interface ExamTestViewController : UIViewController<UIScrollViewDelegate,MZTimerLabelDelegate>
{
 
    MZTimerLabel    *_timerExample;
    
    NSMutableArray  *dataArray;
    
    //存放tableview Controller的东西
    NSMutableArray  *ArraywithTV;
    //计时器
    NSTimer         *timer;
    //最大的数组
    NSMutableArray  *bigarray;
    //保存着的数据
    NSMutableArray  *answercardArray;
    
    int   gindex;
    int   startpage;
    int   currentPageNumber;
    
    //开始题目
    int  startAnswer;
    
    //是否需要加载
    BOOL  isNeedLoading;
    //记录下
    int lastTimesPage;
}

@property (nonatomic,strong) NSDictionary *datadic;
@property (nonatomic,strong) UIScrollView *iScrollview;
@property (nonatomic,strong) UIView  *tabbarView;

- (id)initWithDictionary:(NSDictionary *)dic index:(int)index;
- (void)initScrollView;
- (void)setNavgation;
- (void)setNavtitle;
- (void)getZTdata;
- (void)inittabbarView;
- (void)setlabel;
- (void)initNSnotification;
- (void)backController;
- (void)initA1 :(int) index;
- (void)initExaminationQuestions;
- (void)uploadtopic:(NSNotification *)info;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
- (void)setScrollviewContentSize;
- (void)initanswerArray :(int)count;
@end
