//
//  ShowBiJiViewController.h
//  ExamTreasured
//
//  Created by yuan on 14-6-3.
//  Copyright (c) 2014年 yuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowBiJiViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView *iWebView;

}
@property (strong, nonatomic) NSDictionary *dataDic;
@property (strong, nonatomic) NSMutableDictionary *dataSourceDic;//笔记内容dic
@property (strong, nonatomic)  UIButton *scbtn;
@property (strong, nonatomic)   UILabel *scLabel;
@property (strong, nonatomic)  UILabel *bianjiLabel;
- (id)initWithDictionary:(NSDictionary *)dic;
- (void)creatWebView;
- (void)shoucangToBiji:(NSDictionary*)tempDic;

@end
