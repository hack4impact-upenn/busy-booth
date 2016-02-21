//
//  WaitTimeTableViewCell.m
//  BusyBooth
//
//  Created by Krishna Bharathala on 2/21/16.
//  Copyright © 2016 Krishna Bharathala. All rights reserved.
//

#import "WaitTimeTableViewCell.h"

@implementation WaitTimeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 300, 30)];
        self.descriptionLabel.center = CGPointMake(self.center.x, self.center.y);
        self.descriptionLabel.textColor = [UIColor blackColor];
        self.descriptionLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
        [self addSubview:self.descriptionLabel];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 55, 0, 50, 30)];
        self.timeLabel.textColor = [UIColor blackColor];
        self.timeLabel.font = [UIFont fontWithName:@"Arial" size:30.0f];
        [self addSubview:self.timeLabel];
        
        self.minutesLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 60, 20, 50, 30)];
        self.minutesLabel.text = @"Minutes";
        self.minutesLabel.textColor = [UIColor blackColor];
        self.minutesLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        [self addSubview:self.minutesLabel];
    
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
