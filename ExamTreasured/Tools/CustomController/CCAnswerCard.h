//
//  CCAnswerCard.h
//  ExamTreasured
//
//  Created by yuan on 14-5-21.
//  Copyright (c) 2014年 yuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCAnswerCard : UIViewController
{
    NSInteger iCount;//总个数
    
    NSArray  *_arrayAnswer;
    
    id obTager;
    SEL obAction;
}

//初始化
- (id)initWithFrame:(CGRect)cRect count:(NSNumber*)cNumber;
- (void)initbtnColor:(NSMutableArray *)array;
- (id)initWithFrame:(CGRect)cRect Nsarray:(NSArray*)arrayAnswer   downloadIndex:(int )index;

- (void)setTager:(id)aTager andAction:(SEL)aAction;
@end
