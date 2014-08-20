#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define  LYS_FONT_ExamTestVC   [UIFont systemFontOfSize:17.0f]
#import "ExamTestVC.h"
#import "ExamTableViewCell.h"
NSString *cellidentifier = @"cell";
@interface ExamTestVC ()
@end
@implementation ExamTestVC
@synthesize dataDict,sectionView;
@synthesize gindex,tableView;
- (id)initWithStyle:(UITableViewStyle)style  Dictinary:(NSDictionary*)dataDictory index:(int)index
{
    self = [super init];
    if (self)
    {
        gindex = index;
        [self disposeDictionary:dataDictory];
    }
    return self;
}

-(void)disposeDictionary:(NSDictionary *)dataDictory
{
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    NSMutableDictionary  *tempdic = [[NSMutableDictionary alloc]initWithDictionary: dataDictory];
    NSMutableArray  *array = [[NSMutableArray alloc]initWithArray:[[[tempdic objectForKey:@"topics"]objectAtIndex:0]objectForKey:@"optionsList"]];
    
    for (int i = 0; i < array.count; i++)
    {
        NSMutableDictionary  *dic = [[NSMutableDictionary alloc]initWithDictionary:[array objectAtIndex:i]];
        [dic setObject:@"NO" forKey:@"choose"];
        [tempArray addObject:dic];
    }
    
    NSMutableDictionary   *secondeDic = [[NSMutableDictionary alloc]initWithDictionary:[[tempdic objectForKey:@"topics"]objectAtIndex:0]];
    [secondeDic setObject:tempArray forKey:@"optionsList"];
    
    NSMutableArray *waichengarray = [[NSMutableArray alloc]initWithObjects:secondeDic, nil];
    [tempdic setObject:waichengarray forKey:@"topics"];
    dataDict = tempdic;
}
//检查如果有是YES的
-(BOOL)checkChangeValue
{
    NSMutableDictionary  *tempdic = [[NSMutableDictionary alloc]initWithDictionary: dataDict];
    NSMutableArray  *array = [[NSMutableArray alloc]initWithArray:[[[tempdic objectForKey:@"topics"]objectAtIndex:0]objectForKey:@"optionsList"]];
    for (int i = 0; i < array.count; i++)
    {
        NSMutableDictionary  *dic = [[NSMutableDictionary alloc]initWithDictionary:[array objectAtIndex:i]];
        if ([[dic objectForKey:@"choose"]isEqualToString:@"YES"])
        {
            return YES;
        }
    }
    return NO;
}


-(void)disposeDictionarychange:(int )index
{
    if ([self checkChangeValue])
    {
        return ;
    }
    
    NSMutableDictionary  *tempdic = [[NSMutableDictionary alloc]initWithDictionary: dataDict];
    NSMutableArray  *array = [[NSMutableArray alloc]initWithArray:
                              [[[tempdic objectForKey:@"topics"]
                                objectAtIndex:0]objectForKey:@"optionsList"]];
    
    NSMutableDictionary  *dic = [[NSMutableDictionary alloc]initWithDictionary:
                                 [array objectAtIndex:index]];
    if ([[dic objectForKey:@"choose"]isEqualToString:@"NO"])
    {
        [dic setObject:@"YES" forKey:@"choose"];
    }
    else
    {
        [dic setObject:@"NO" forKey:@"choose"];
    }
    [array  replaceObjectAtIndex:index withObject:dic];
    
    NSMutableDictionary  *secondeDic = [[NSMutableDictionary alloc]
                                        initWithDictionary:[[tempdic objectForKey:@"topics"]objectAtIndex:0]];
    [secondeDic setObject:array forKey:@"optionsList"];
    NSMutableArray *waichengarray = [[NSMutableArray alloc]initWithObjects:secondeDic, nil];
    [tempdic setObject:waichengarray forKey:@"topics"];
    dataDict = tempdic;
}

-(void)initTableView
{
    
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320,MAINSCREENHEIGHT - 88) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.sectionView = [[UIView alloc]init];
    
    
    // 显示字体的高度
    NSString  *needCountHeightStr = [[[dataDict objectForKey:@"topics"]objectAtIndex:0]objectForKey:@"TM_JX"];
    CGFloat  sectionHeight = [self calculateHeadHeight:needCountHeightStr font:LYS_FONT_ExamTestVC];
    UILabel  *analysislabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, sectionHeight+10)];
    analysislabel.text = needCountHeightStr;
    analysislabel.numberOfLines = 0;
    analysislabel.textColor = [UIColor blueColor];
    analysislabel.font = LYS_FONT_ExamTestVC;
    analysislabel.backgroundColor = [UIColor clearColor];
    //analysislabel.center = CGPointMake(self.view.center.x , self.sectionView.center.y);
    self.sectionView.frame= CGRectMake(0,0,320,sectiononeHeight+25);
    [self.sectionView addSubview:analysislabel];
    self.sectionView.hidden = YES;


}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self  addNaviRightBtn];
    [self  initTableView];
    [self  tableHeadView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0)
    {
        NSArray  *array =  [[[dataDict objectForKey:@"topics"]objectAtIndex:0]objectForKey:@"optionsList"];
        return array.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray  *array =  [[[dataDict objectForKey:@"topics"]objectAtIndex:0]objectForKey:@"optionsList"];
    NSDictionary *dic =  [array objectAtIndex:indexPath.row];
    ExamTableViewCell   *cell;
    if ([[dic objectForKey:@"choose"]isEqualToString:@"NO"])
    {
        cell = [[ExamTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier tag:indexPath.row flatStr:@"NO"];
    }
    else
    {
        cell = [[ExamTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"unslect" tag:indexPath.row flatStr:@"YES"];
    }
    
    cell.answerlabel.frame = CGRectMake(30, 5, 290, [self calculateRowHeight:indexPath]);
    NSDictionary  *everyDic = [array objectAtIndex:indexPath.row];
    NSMutableString  *str = [[NSMutableString alloc]init];
    [str appendString:[everyDic objectForKey:@"ZTXX_BZ"]];
    [str appendString:@": "];
    [str appendString:[everyDic objectForKey:@"ZTXX_NR"]];
    cell.answerlabel.text = str;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   [self calculateRowHeight:indexPath];
}

#pragma mark 计算每一行cell的高度
-(CGFloat)calculateRowHeight:(NSIndexPath*)indexPath
{
    NSArray  *array =  [[[dataDict objectForKey:@"topics"]objectAtIndex:0]objectForKey:@"optionsList"];
    NSDictionary  *everyDic = [array objectAtIndex:indexPath.row];
    NSMutableString  *str = [[NSMutableString alloc]init];
    [str appendString:[everyDic objectForKey:@"ZTXX_BZ"]];
    [str appendString:@": "];
    [str appendString:[everyDic objectForKey:@"ZTXX_NR"]];
    
    return  [self calculateHeadHeight:str font:LYS_FONT_ExamTestVC];;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //    如果不为0
    if (section == 0)
    {
        return nil;
    }
    else
    {
        if (sectionView.hidden == YES)
        {
            return nil;
        }
        return  sectionView;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if( section== 0)
    {
        return 0;
    }
    else
    {
        if (sectionView.hidden == YES )
        {
            return 0;
        }
        
        NSString  *needCountHeightStr = [[[dataDict objectForKey:@"topics"]objectAtIndex:0]objectForKey:@"TM_JX"];
        int  sectionHeight =  [self calculateHeadHeight:needCountHeightStr font:LYS_FONT_ExamTestVC];
        
        return sectionHeight+15;
    }
}

-(void)tableHeadView
{
    
    NSDictionary *dic = [[dataDict objectForKey:@"topics"]objectAtIndex:0];
    UIView  *sectionOne = [[UIView alloc]init];
    UILabel  *titlelabel = [[UILabel alloc]init];
    titlelabel.numberOfLines = 0;
    titlelabel.font = LYS_FONT_ExamTestVC;
    titlelabel.text = [dic objectForKey:@"TM_TG"];
    titlelabel.backgroundColor = [UIColor clearColor];
    [sectionOne addSubview:titlelabel];
    CGSize  labelSize;
    if (IOS7)
    {
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:titlelabel.font,NSFontAttributeName,nil];
        labelSize = [[dic objectForKey:@"TM_TG"] boundingRectWithSize:CGSizeMake(300, MAXFLOAT)  options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
        
    } else {
        
        UIFont *nameFont=LYS_FONT_ExamTestVC;
        labelSize = [[dic objectForKey:@"TM_TG"] sizeWithFont:nameFont constrainedToSize:CGSizeMake(237, 200) lineBreakMode:NSLineBreakByCharWrapping];
    }
    
    sectionOne.frame = CGRectMake(0, 0, 320, labelSize.height+10);
    titlelabel.frame = CGRectMake(15, 5, 290, labelSize.height+10);
    
    self.tableView.tableHeaderView = sectionOne;
}


- (BOOL)showSectionView
{
    sectionView.hidden = NO;
    return sectionView.hidden;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self disposeDictionarychange:indexPath.row ];
    [self QuestionUptoServer:indexPath.row];
    [self.tableView reloadData];
    if ([self checkChangeValue])
    {
        [self saveData:indexPath.row];
    } ;
    [[NSNotificationCenter defaultCenter]postNotificationName: UPLOADTOPIC object:nil userInfo:nil];
    
}

-(void)saveData :(int )index
{
    NSDictionary  *dic =  [[dataDict objectForKey:@"topics"]objectAtIndex:0];
    NSDictionary *optiondic = [[dic objectForKey:@"optionsList"]objectAtIndex:index];
    NSString  *examid = [dic objectForKey:@"exam_id"];
    NSString  *tmid = [dic objectForKey:@"TM_ID"];
    
    NSString  *rightStr = [dic objectForKey:@"TM_RIGHT_XXID"];
    NSString  *ztxxidStr = [optiondic objectForKey:@"ZTXX_ID"];
    NSString  *answerState;
    if ([rightStr intValue] == [ztxxidStr intValue])
    {
        answerState = @"right";
    }
    else
    {
        answerState = @"wrong";
    }
    
    
    NSDictionary *resultdic = [[NSDictionary alloc]initWithObjectsAndKeys:answerState,@"answerstate",rightStr,@"rightid", examid,@"examid", tmid,@"tmid",ztxxidStr,@"chooseid",nil];
    
    NSString  *indexStr = [NSString stringWithFormat:@"%d",gindex];
    NSArray  *resutlarray = @[resultdic,indexStr];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:ADDARRAYOBJECT object:resutlarray userInfo:nil];
}

//每做完一套题都向服务器上传
-(void)QuestionUptoServer:(int)index
{
    NSDictionary  *dic =  [[dataDict objectForKey:@"topics"]objectAtIndex:0];
    NSString  *examid = [dic objectForKey:@"exam_id"];
    NSString  *tmid = [dic objectForKey:@"TM_ID"];
    NSDictionary *optiondic = [[dic objectForKey:@"optionsList"]objectAtIndex:index];
    NSString  *optionid = [optiondic objectForKey:@"ZTXX_ID"];
    NSDictionary *pardic = [[NSDictionary alloc]initWithObjectsAndKeys:examid,@"examid",tmid,@"tm_id",optionid,@"option_id", nil];
    MKNetworkOperation *op = [m_AppDelegate.networkEngineinstace  getdata:pardic path:PAPER_UPDATESELECTOPTION httpMethod:GET];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSDictionary *updatedic   = [[NSDictionary alloc]initWithDictionary:[completedOperation responseJSON]];
        if ([updatedic objectForKey:@""])
        {
            
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        NSLog(@"");
    }];
}


- (void)changeSectionView
{
    sectionView.hidden = NO;
    [self.tableView reloadData];
}
//收藏
- (void)collectExercises
{
    
}

-(CGFloat)calculateHeadHeight:(NSString*)str font:(UIFont*)FontSize
{
    CGSize  labelSize;
    if (IOS7)
    {
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:FontSize,NSFontAttributeName,nil];
        labelSize = [str boundingRectWithSize:CGSizeMake(300, MAXFLOAT)  options:NSStringDrawingUsesLineFragmentOrigin attributes:tdic context:nil].size;
        labelSize.height = labelSize.height + 15;
    }
    else
    {
        CGSize constraintSize = CGSizeMake(300.0f, MAXFLOAT);
        labelSize = [str  sizeWithFont:FontSize constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
        labelSize.height = labelSize.height + 15;
    }
    return labelSize.height;

}
@end
