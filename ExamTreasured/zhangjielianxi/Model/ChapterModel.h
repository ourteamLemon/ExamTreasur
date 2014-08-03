//
//  ChapterModel.h
//  ExamTreasured
//
//  Created by LYS on 14-8-3.
//  Copyright (c) 2014年 LYS. All rights reserved.
//


//章节练习数据结构

#import "RADataObject.h"


@interface ChapterDatestartNode : NSObject
@property (nonatomic, strong)NSString  *KM_ID;
@property (nonatomic, strong)NSString  *KM_MC;
@property (nonatomic, strong)NSString  *ORDER;
@property (nonatomic, strong)NSString  *IS_KP;
@end

@interface ChapterDateZJ : NSObject
@property (nonatomic, strong)NSString  *KM_ID;
@property (nonatomic, strong)NSString  *ZJ_MC;
@property (nonatomic, strong)NSString  *ZJ_MS;
@property (nonatomic, strong)NSString  *ORDER;
@property (nonatomic, strong)NSString  *ZJ_ID;
@property (nonatomic, strong)NSString  *IS_KP;
@end


@interface ChapterDatemMinutia : NSObject
@property (nonatomic ,strong)NSString  *XJ_ID;
@property (nonatomic ,strong)NSString  *ZJ_ID;
@property (nonatomic ,strong)NSString  *XJ_MC;
@property (nonatomic ,strong)NSString  *XJ_MS;
@property (nonatomic ,strong)NSString  *ORDER;
@property (nonatomic ,strong)NSString  *IS_KP;
@end

@interface ChapterModel : RADataObject
@property (nonatomic ,strong)ChapterDatestartNode   *startNode;
@property (nonatomic ,strong)ChapterDateZJ          *chapterDateZJ;
@property (nonatomic ,strong)ChapterDatemMinutia    *chapterDateMinutia;
@end

