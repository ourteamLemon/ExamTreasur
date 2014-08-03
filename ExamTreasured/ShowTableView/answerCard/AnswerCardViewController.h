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
    NSArray     *receiveArray;

    
    id obTager;
    SEL obAction;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil Nsarray:(NSArray*)answercardArray;
- (void)setTager:(id)aTager andAction:(SEL)aAction;
@end
