//
//  GongLueModel.h
//  ExamTreasured
//
//  Created by yuan on 14-5-23.
//  Copyright (c) 2014年 yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GongLueModel : NSObject
{
    NSString *GL_ID;	//攻略ID
	NSString *ZY_ID;	//所属职业
	NSString *GL_BT;	//攻略标题
	NSString *GL_NR;	//攻略内容
	NSString *GL_UPDATE_TIME;	//创建时间
	NSString *GL_READ_COUNT;	//查看次数
	NSString *GL_AUTHOR;
	NSString *ORDER;	//排序
	NSString *GL_cover; //图片地址
	NSString *SC_ID;	//收藏ID
    NSString *GL_CLICKCOUNT; //点击次数
    NSString *GL_LASTREVERT; //最后回复
    NSString *GL_LASTREVERTTIME;//最后回复时间
}
@property (strong ,nonatomic) NSString *GL_ID;	//攻略ID
@property (strong ,nonatomic) NSString *ZY_ID;	//所属职业
@property (strong ,nonatomic) NSString *GL_BT;	//攻略标题
@property (strong ,nonatomic) NSString *GL_NR;	//攻略内容
@property (strong ,nonatomic) NSString *GL_UPDATE_TIME;	//最后更新时间
@property (strong ,nonatomic) NSString *GL_READ_COUNT;	//查看次数
@property (strong ,nonatomic) NSString *GL_AUTHOR;
@property (strong ,nonatomic) NSString *ORDER;	//排序
@property (strong ,nonatomic) NSString *GL_cover; //图片地址
@property (strong ,nonatomic) NSString *SC_ID;	//收藏ID
@property (strong ,nonatomic) NSString *GL_CLICKCOUNT;
@property (strong ,nonatomic) NSString *GL_LASTREVERT;
@property (strong ,nonatomic) NSString *GL_LASTREVERTTIME; 

@end