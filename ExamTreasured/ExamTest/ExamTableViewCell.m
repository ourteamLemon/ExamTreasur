//
//  ExamTableViewCell.m
//  ExamTreasured
//
//  Created by mac on 14-6-3.
//  Copyright (c) 2014年 mac. All rights reserved.
//

#import "ExamTableViewCell.h"

@implementation ExamTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier tag:(long)tag flatStr:(NSString *)flatStr
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if ([flatStr isEqualToString:@"NO"]) {
             [self.selectbtn setImage:[UIImage imageNamed:@"radio_unseled.png"] forState:UIControlStateNormal];
        }
        else
        {
            [self.selectbtn setImage:[UIImage imageNamed:@"radio_seled.png"] forState:UIControlStateNormal];
        }
        self.selectbtn.tag = tag;
        [self.selectbtn setEnabled:YES];
        self.selectbtn.frame = CGRectMake(10, 15, 17, 17);
        self.answerlabel = [[UILabel alloc]init];
        self.answerlabel.numberOfLines = 0;
        self.answerlabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.selectbtn];
        [self addSubview:self.answerlabel];
    }
    return self;
}

- (void)awakeFromNib
{

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)selectbtnPressed:(id)sender
{
    
}
@end
