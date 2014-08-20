//
//  AnswerCardViewController.h
//  ExamTreasured
//
//  Created by mac on 14-7-9.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCAnswerCard.h"
@interface AnswerCardViewController : UIViewController
{
    CCAnswerCard  *answerCard;
    //接收到含有三个字段的值
    NSArray     *receiveArray;

    
    //已经下载了多少个
    int       downloadIndex;
    id obTager;
    SEL obAction;
}
/*!
 *
 *
 *  @param nibNameOrNil    nil
 *  @param nibBundleOrNil  nil
 *  @param answercardArray 有多少个
 *  @param index           已经下载到多少?
 *
 *  @return AnswerCardViewController
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil Nsarray:(NSArray*)answercardArray  downindex:(int)index;
- (void)setTager:(id)aTager andAction:(SEL)aAction;
@end
