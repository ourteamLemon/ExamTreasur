//
//  ShoppingCartViewController.m
//  ExamTreasured
//
//  Created by LYS on 14-8-6.
//  Copyright (c) 2014年 LYS. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ShopCartTableViewCell.h"

@implementation chargeList
@synthesize giveIntegral,monthCount,price,professionID,rechargeListID;
@end

@interface ShoppingCartViewController ()
@end

@implementation ShoppingCartViewController
static NSString  *cellIdenfiter = @"cell";
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        rechargeArray = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initScrollView];
    [self setNavgation];
    [self setNavtitle];
    [self addNaviRightBtn];
    [self initTableTitle];
    [self inittableView];
    [self getRechargeData];

}
// init tableTitle
-(void)initTableTitle
{
    UILabel *tabletitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 300, 45)];
    tabletitle.numberOfLines = 0;
    tabletitle.text = @"欢迎您加入医考宝典，高效复习，无忧通关！";
    tabletitle.backgroundColor = [UIColor clearColor];
    [self.iScrollView addSubview:tabletitle];
    
    NSMutableString *showRechargeString =  [[NSMutableString alloc]initWithString:@"充值科目:"];
    for (NSDictionary *ProfessionDic  in m_AppDelegate.allProfession) {
        
        if ([[[ProfessionDic objectForKey:@"ZY_ID"]stringValue] isEqualToString:m_AppDelegate.zy_ID])
        {
           [showRechargeString appendString:[ProfessionDic objectForKey:@"ZY_MC"]];
            
            break;
        }
    }


    UILabel  *rechargeLabble = [[UILabel alloc]initWithFrame:CGRectMake(5, tabletitle.frame.origin.y+tabletitle.frame.size.height+10, tabletitle.frame.size.width, 25)];
    rechargeLabble.text = showRechargeString;
    rechargeLabble.backgroundColor = [UIColor clearColor];
    [self.iScrollView addSubview:rechargeLabble];
    
    
    tableViewYheight = tabletitle.frame.origin.y + tabletitle.frame.size.height +rechargeLabble.frame.origin.y+rechargeLabble.frame.size.height;
}

//  set NaviRightBtn
- (void)addNaviRightBtn
{
    UIButton *_backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(0, 2,130,30);
    [_backBtn setTitle:@"www.doctorvbook.com" forState:UIControlStateNormal];
    _backBtn.titleLabel.font = [UIFont systemFontOfSize:8.0];
    _backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.iScrollView.contentSize = CGSizeMake(320, 600);
}
// init  UIScrollerView
- (void)initScrollView
{
    self.iScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, MAINSCREENHEIGHT)];
    [self.view addSubview:self.iScrollView];
}

- (void)setNavgation
{
    [self addNaviLeftBtnWithImageName:@"back" andFrame:CGRectMake(0, 2,30,30) target:self action:@selector(backController)];
    UIImage *nav_background = [UIImage imageNamed:@"navgation"];
    [self setNaviBackGroundWithImage:nav_background];
}

- (void)setNavtitle
{
    NSString *str = @"会员中心";
    [self setNaviTitle:str];
}

- (void)backController
{
    if ([self.navigationController.childViewControllers objectAtIndex:0] == self)
    {
        [m_AppDelegate enterMianViewController];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }

}

-(void)inittableView
{
    self.iTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, tableViewYheight -20, 320, 70*5) style:UITableViewStylePlain];
    self.iTableView.dataSource = self;
    self.iTableView.delegate = self;
    self.iTableView.scrollEnabled = NO;
    [self.iTableView registerNib:[UINib nibWithNibName:@"ShopCartTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdenfiter];
    [self.iScrollView addSubview:self.iTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Get recharge data
- (void)getRechargeData
{
    //key
    //zyid
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary  *parmDic = [[NSDictionary alloc]initWithObjectsAndKeys:m_AppDelegate.zy_ID ,@"zyid" ,nil];
    MKNetworkOperation   *op  = [m_AppDelegate.networkEngineinstace getdata:parmDic path:RechargeListByZYID httpMethod:POST];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSDictionary  *redic = [completedOperation responseJSON];
        NSLog(@"ss");
        if (redic && ![redic isKindOfClass:[NSNull class]])
        {
            NSArray *tempArray = [redic objectForKey:@"rechargeList"];
            [self processData:tempArray];
        }
        else
        {
            [hud hide:YES];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
    }];
}


-(void)processData:(NSArray*)array
{
    for (NSDictionary *dic in array)
    {
        chargeList  *chargeist = [[chargeList alloc]init];
        NSArray *keyArray = [dic allKeys];
        
        for (int dicindex = 0; dicindex<keyArray.count; dicindex++)
        {
            NSString *coverString;
            if ([[dic objectForKey:keyArray[dicindex]] isKindOfClass: [NSNumber class]])
            {
                coverString = [[dic objectForKey:keyArray[dicindex]]stringValue];
            }
           [chargeist setValue:coverString forKey:keyArray[dicindex]];
        }
        [rechargeArray addObject:chargeist];
    }
    [self.iTableView reloadData];
    [hud hide:YES];
}

#pragma mark tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [rechargeArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0f;
}

// Returns the table cell at the specified index path.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    chargeList *listCharge = rechargeArray[indexPath.row];
    ShopCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdenfiter];
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    if (!cell)
    {
        cell = [[ShopCartTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdenfiter];
    }
     cell.countLable.textColor = [UIColor blueColor];
     cell.PriceLable.textColor = [UIColor orangeColor];
     cell.PriceLable.font = [UIFont boldSystemFontOfSize:17];
     cell.countLable.textColor = [UIColor blueColor];
     cell.countLable.font = [UIFont boldSystemFontOfSize:20];
    NSString  *priceString = [NSString stringWithFormat:@"¥ %@",listCharge.price];
    
    if (indexPath.row == [rechargeArray count]-1)
    {
        cell.countLable.text = @"永久会员";
        cell.monthLabel.hidden = YES;
        cell.PriceLable.text = priceString;
        return cell;
    }
    
    if (indexPath.row == 3)
    {
        cell.monthLabel.frame = CGRectMake(cell.monthLabel.frame.origin.x+11, cell.monthLabel.frame.origin.y, cell.monthLabel.frame.size.width, cell.monthLabel.frame.size.height);
    }
    cell.PriceLable.text = priceString;
    cell.countLable.text = listCharge.monthCount;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)createDetailView
{
    UIView  *detailview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 300, 280)];
    detailview.backgroundColor  = [UIColor whiteColor];
    //画行
    for (int rowindex = 0; rowindex < 7; rowindex++)
    {
        UIImageView  *imgview = [[UIImageView alloc]initWithFrame:CGRectMake(10, (rowindex+1)*40, 300, 2)];
        imgview.tintColor = [UIColor grayColor];
        [detailview addSubview:imgview];
    }
    
    //画列
    for (int columnindex = 0 ; columnindex < 2; columnindex++)
    {
        UIImageView  *imgview = [[UIImageView alloc]initWithFrame:CGRectMake((columnindex+1)*100, 0, 2, 280)];
        imgview.tintColor = [UIColor grayColor];
        [detailview addSubview:imgview];
    }
    
    

    
    
    
}

@end
