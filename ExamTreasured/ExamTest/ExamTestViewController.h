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
    int   gindex;
    int   startpage;
    
    NSMutableArray  *dataArray;
    NSMutableArray  *ArraywithTV;
    NSTimer         *timer;

    NSMutableArray  *bigarray;   //最大的数组
    int  currentPageNumber;
    MZTimerLabel *_timerExample;
    //保存着的数据
    NSMutableArray  *answercardArray;
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

-(void)initA1 :(int) index;
- (void)initExaminationQuestions;
-(void)uploadtopic:(NSNotification *)info;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
- (void)setScrollviewContentSize;
-(void)initanswerArray :(int)count;
- (void)setlabel;
@end
