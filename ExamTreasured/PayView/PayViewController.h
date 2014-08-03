//
//  PayViewController.h
//  ExamTreasured
//
//  Created by mac on 14-5-19.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlixLibService.h"

@interface Product : NSObject{
@private
	float _price;
	NSString *_subject;
	NSString *_body;
	NSString *_orderId;
}
@property (nonatomic, assign) float price;
@property (nonatomic, retain) NSString *subject;
@property (nonatomic, retain) NSString *body;
@property (nonatomic, retain) NSString *orderId;

@end
@interface PayViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_products;
    SEL _result;
    UITableView *iTable;
}
@property (nonatomic,assign) SEL result;//这里声明为属性方便在于外部传入。
-(void)paymentResult:(NSString *)result;

- (id)initWithtitle:(NSString *)titleString;
@end
