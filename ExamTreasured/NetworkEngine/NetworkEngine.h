//
//  NetworkEngine.h
//  ExamTreasured
//
//  Created by mac on 14-5-19.
//  Copyright (c) 2014年 mac. All rights reserved.

//10 代表

#define HOST  @"www.doctorvbook.com"
#define PROT  8080

#define GET  @"GET"
#define POST @"POST"

#pragma mark 登录系统
/**
 user.ACCOUNT       用户名称
 user.PASSWORD      用户密码
 
// return  Value
 account = 23456;
 email = "";
 "login_id" = 318C5848F0E3E0C2400615BE04EE3C13;
 message = "\U767b\U9646\U6210\U529f";
 "phone_num" = "";
 platform = "";
 success = 1;
 username = gg;
 "yh_id" = 273;
 
 */
//  10
#define LOGINACTION             @"/Exam_sys/user_login.action"

/**
 参数
 user.ACCOUNT
 user.PASSWORD
 user.USERNAME
 user.ENABLED       default is 1
 user.LOCKED        default is 1
 user.SEX           default is 1
 user.IMEI      可传可不传
 user.IMEIMD5   可传可不传
 user.MAC       可传可不传
 user.IMSI      可传可不传
 user.OSLX      可传可不传
 user.OSBB      可传可不传
 
 */
#pragma mark 用户注册    10
#define ADDUSER                 @"/Exam_sys/user_addUser.action"


/**
 user.PLATFORM_ID
 user.USERNAME
 user.PLATFORM
 user.IMEI    唯一号
 user.IMEIMD5 唯一号号码
 user.MAC     没有为空支字符串
 user.IMSI    可以不传
 user.OSLX    可以不传
 user.OSBB    可以不传
 */
#pragma mark 使用第三方登录系统   10
#define USER_LOGIN_FOR_THIRPARY @"/Exam_sys/user_loginForThirdParty.action"

/**
 参数
 zy_id=1
 yh_id=272  用户ID  登陆给返回
*/
//新添加的接口
#pragma mark  获取用户权限    登陆进来调用，和切换职业的时候使用   10
#define  UserHavePreWithProfession  @"/Exam_sys/user_isUserHavePreWithProfession.action"

// key   App_os  Value
#pragma mark 获取最新app版本   10
#define APP_GETLATEST           @"/Exam_sys/app_getLatestVersionInfo.action"



#pragma mark 根据用户ID获取会员权限列表,在个人中心的会员信息中用到   10
//key
//yhid
#define MEMBER_GETMEMBERLIST    @"/Exam_sys/member_getMemberListByYHID.action"



#pragma mark 根据用户ID和职业ID获取权限,无权限者在查看真题、笔记、试题时只允许查看前10题   10
//key
//zy_id
//yh_id
#define USER_ISUERHAVEPRE       @"/Exam_sys/user_isUserHavePreWithProfession.action"


#pragma mark获取当前系统中所有职业的列表        10
// key : type    Value: 临床执业  死数据
#define PROFESSION_GETALL       @"/Exam_sys/profession_getAllProfession.action"



#pragma mark获取 职业ID获取科目、章节、小节         10
/**
key: zy_id    默认为 ：1
 */
#define NOTE_GETCHAPTERMINUTIA  @"/Exam_sys/note_getNoteChapterMinutiaInfoByZyid.action"

#pragma mark 根据职业ID获取主页攻略  3个循环的    10  
/**
 *
 * key: zy_id    默认为 ：1
 *
 */
#define FORUM_GETMAINPOSTLIST   @"/Exam_sys/forum_getMainPostListByZy_id.action"

#pragma mark 根据职业ID获取攻略列表    10

/**
 key
     zy_id
     yh_id 用户
 */
#define STRATEGY_GETALLSTRATE   @"/Exam_sys/strategy_getAllStrategyInfoForProscenium.action"

#pragma mark 根据攻略ID获取攻略内容   10
// key gl_id
#define STRATEGY_GETSTRATEGY   @"/Exam_sys/strategy_getStrategyZwByStrategyId.action"


//废弃的接口
#pragma mark 根据攻略ID获取评论
#define FORUM_GETPOSTINFO       @"/Exam_sys/forum_getPostInfoAndAllComment.action"

 #pragma mark  根据攻略ID获取评论 新添加的接口
// key:  postid （也就是 gl_id）攻略id
#define CommentByPostid  @"/Exam_sys/forum_getAllCommentByPostid.action"



 #pragma mark  新添加的接口   根据题目ID获取题目组ID  就是所在的实际页数  B型类使用

//key
//topicIndex   题目的序号
//ztdy_id      真题单元
#define  getGroupIndexBy     @"/Exam_sys/overyears_getGroupIndexBy.action"


#pragma mark 提交用户评论    10
//  key  OK
//raidersCommentVO.cm_yhid
//raidersCommentVO.ps_id
//raidersCommentVO.cm_nr
#define FORUM_ADDCOMMENT        @"/Exam_sys/forum_addComment.action"

#pragma mark 收藏攻略       10
//key  OK
/**
 storageStrategy.STRATEGY_ID
 storageStrategy.YH_ID
 storageStrategy.ZY_ID
 */
#define STORAGE_ADDSTRATEGY     @"/Exam_sys/storage_addStrategy.action"

#pragma mark 取消收藏攻略     10
//key
//storageStrategy.ID
#define STORAGE_DELEGATESTRATEGY  @"/Exam_sys/storage_deleteStrategy.action"


#pragma mark 根据职业ID获取真题单元列表   10
//key
//zy_id
#define OVERYEARS_GETALLOVERYEAR @"/Exam_sys/overyears_getAllOveryearsByZyid.action"


#pragma mark 根据真题单元ID获取真题   10
//有变动   这边应该判断是否有权限
//key
//ztdy_id
//login_id
//zy_id
//yh_id
//start
//end
#define OVERYEARS_GETTOPICDETAIL @"/Exam_sys/overyears_getTopicDetailByZtdyId.action"


#pragma mark 收藏真题        10
//key  有变动
//storageOverTopic.OVERTOPICGROUP_ID
//storageOverTopic.YH_ID
//storageOverTopic.ZY_ID
#define STORAGE_ADDOVERTOPIC    @"/Exam_sys/storage_addOverTopic.action"

#pragma mark 取消收藏真题   10
//key
//storOverTopic_id
//yh_id
#define STORAGE_DELETEOVER      @"/Exam_sys/storage_deleteOverTopic.action"


#pragma mark 根据题目索引获取题目信息,在交卷界面中使用   10
//topicIndex  题目序号
//ztdy_id
#define OVERYEAR_GETOVERYEARTOP        @"/Exam_sys/overyears_getOveryearTopicByTopicIndex.action"



#pragma mark 收藏错题      在答题卡页面点击收藏错题把错题给记录下来        10
//key
//yh_id
//zy_id
//content 的格式  真题ID,小节ID,题目ID,选项ID@真题ID,小节ID,题目ID,选项ID  这里收藏了两道题目
#define OVERYEARS_ANDERROROVERYEAR     @"/Exam_sys/overyears_addErrorOveryearTopic.action"


#pragma mark 根据小节ID获取笔记列表   10
//key  有变动
//xj_id
//login_id
//zy_id
//start
//end
//yh_id
#define NOTE_GETNOTEBYTXJID             @"/Exam_sys/note_getNoteByXjid.action"

#pragma mark 收藏笔记      10
//key
//storageNote.CHAPTER_ID
//storageNote.MINUTIA_ID
//storageNote.NOTE_ID
//storageNote.YH_ID
//storageNote.ZY_ID
#define STORAGE_ADDNote             @"/Exam_sys/storage_addNote.action"


#pragma mark 取消收藏笔记      10
//key
//storNote_id
//yh_id
#define  STORAGE_DELETENOTE        @"/Exam_sys/storage_deleteNote.action"


//在此页面中会有一个交zdybj的参数为-1 则调用新增
#pragma mark 新增自定义笔记    10
//key
//noteCustom.bj_id
//noteCustom.yh_id
//noteCustom.zdybj_nr
#define   NOTE_ADDNOTECUSTOM        @"/Exam_sys/note_addNoteCustom.action"

#pragma mark 更新自定义笔记     10
//key
//noteCustom.zdybj_id
//noteCustom.zdybj_nr
#define  NOTE_UPDATENOTECUSTOM     @"/Exam_sys/note_updateNoteCustom.action"


#pragma mark 根据小节ID获取题目列表    10
//key
//xj_id
//login_id
//zy_id
//start
//end
//yh_id
#define  GETTOPICINFOBYJID      @"/Exam_sys/topic_getTopicInfoByXjid.action"


#pragma mark  收藏题目    10
//key
//storageTopic.CHAPTER_ID
//storageTopic.MINUTIA_ID
//storageTopic.TOPICGROUP_ID
//storageTopic.YH_ID
//storageTopic.ZY_ID
#define  STORAGE_ADDTOPIC      @"/Exam_sys/storage_addTopic.action"


#pragma mark  取消收藏题目   10
//key
//storTopic_id
//yh_id
#define  STORAGE_DELETOPIC     @"/Exam_sys/storage_deleteTopic.action"

#pragma mark 根据小节ID获取章节真题       10
//key
//xj_id
//yh_id
#define  OVERYEARS_GETOVERTOPIC  @"/Exam_sys/overyears_getOvertopicsByMinutiaid.action"


#pragma  mark 6 模拟考试    6.1 根据职业ID获取卷列表     10
//key
//zy_id
#define PAPER_GETALLJUANLIST  @"/Exam_sys/paper_getAllJuanList.action"


#pragma  mark 作用:获取模拟考试历史记录     10
//key
//zy_id
//yh_id
#define PAPER_GETHISTORYPAPERLIST @"/Exam_sys/paper_getHistoryPaperList.action"

#pragma  mark  作用:新建模拟考试    10
//点击使用模拟真题使用
//login_id
//zy_id
//yh_id
//juan_id
//start
//end
//exam_id   新建默认为-1，加载一部分之后，会返回给我，需要保存在数据库中。
#define PAPER_CREATE   @"/Exam_sys/paper_create.action"

#pragma  mark   提交模拟考试   10
//key
//exam_id
//content   格式：题目ID,选项ID@题目ID,选项ID
#define PAPER_COMPARE  @"/Exam_sys/paper_compare.action"



#pragma  mark 作用:获取历史考试题目    10
//key
//examid
//yh_id
//start
//end
#define PAPER_GETHISTORYPAPERDETAILIST @"/Exam_sys/paper_getHistoryPaperDetailList.action"

#pragma  mark  作用:用户每做一题就上传一题,以便在其他平台上共享数据   10
//key  模拟考试里面才有 ，真题考试没有
//examid
//tm_id
//option_id
#define PAPER_UPDATESELECTOPTION @"/Exam_sys/paper_updateSelectOption.action"

#pragma  mark  作用:收藏错题   10
//key:
//   yh_id
//   zy_id
//  content 格式 章节ID,小节ID,题目ID,选项ID@章节ID,小节ID,题目ID,选项ID
#define PAPER_STORERRORTOPICS @"/Exam_sys/paper_storErrorTopics.action"



#pragma  mark  根据题目ID获取题目组索引 ps： 新添加的接口  10
//key
//topicIndex
//paper_id  相当于 examid
#define  paper_getGroupIndexBy   @"/Exam_sys/paper_getGroupIndexBy.action"

#pragma  mark   根据题目ID获取题目组索引 PS：新添加的接口  根据 1
//key
//topicIndex
//paper_id 相当于 examid
#define  TopicIndex  @"/Exam_sys/paper_getTopicByTopicIndex.action"


// 获取帮助信息  PS  新添加的接口
//NOkey
#define   PHONEABOUT  @"/Exam_sys/phoneAbout.jsp"


#pragma MARK
//key
//yh_id
//zy_id
#define STORAGE_GETALLSTORAGE @"/Exam_sys/storage_getAllStorageTopicInfoByYh_id.action"

#pragma mark 作用:左下角搜藏夹我的笔记
//key
//yh_id
//zy_id
#define STORAGE_GETALLSTORAGENOTEINFO  @"/Exam_sys/storage_getAllStorageNoteInfoByYh_id.action"


#pragma mark 作用:获取收藏夹中的攻略   10
//key
//yh_id
//zy_id
#define STORAGE_GETALLSTORAGESTRATEGYINFO    @"/Exam_sys/storage_getAllStorageStrategyInfoByYh_id.action"


#pragma mark 作用:获取收藏夹中的错题   10
//key
//zy_id
//yh_id
#define  STORAGE_GETALLSTORAGEERRORTOPICINFOBYYH    @"/Exam_sys/storage_getAllStorageErrorTopicInfoByYh_id.action"


//会员充值  新增接口
#pragma mark 作用:根据职业ID获取充值列表   PS：新添加的接口
//key
//zyid
#define RechargeListByZYID  @"/Exam_sys/recharge_getRechargeListByZYID.action"


#pragma mark 作用:充值成功后提交数据
//key
//yh_id
//zy_id
//count  月份
//integral 积分
//amount  价格
#define  member_recharge   @"/Exam_sys/member_recharge.action"


#pragma mark 收藏夹，取消收藏真题 PS：新添加的接口
//key
//storErrorOverTopic_ids
#define  deleteErrorOverTopic @"/Exam_sys/storage_deleteErrorOverTopic.action"

#pragma mark 收藏夹，取消收藏练习题   PS：新添加的接口
//key
//storErrorTopic_ids
#define  deleteErrorTopic @"/Exam_sys/storage_deleteErrorTopic.action"

#import                         "MKNetworkEngine.h"
@interface NetworkEngine : MKNetworkEngine

- (MKNetworkOperation*)getdata:(NSDictionary*)params path:(NSString*)pathStr httpMethod:(NSString*)httpMethod;

@end
