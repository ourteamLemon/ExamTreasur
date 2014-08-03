//
//  CapionTableviewCell.m
//  ExamTreasured
//
//  Created by mac on 14-7-22.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "CapionTableviewCell.h"

@implementation CapionTableviewCell
@synthesize rightOrWrongBtn;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tag:(long)tag flatStr:(NSString *)flatStr
{
 
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier tag:tag flatStr:flatStr];
    
    
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
