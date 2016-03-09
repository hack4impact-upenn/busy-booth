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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier time:(int)time wait:(int) wait {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.time = time;
        self.wait = wait;
        
        int minutes = time % 60;
        int hours = time / 60;
        
        NSString *minuteString = @"00";
        if(minutes > 0 && minutes < 10) {
            minuteString = [NSString stringWithFormat:@"0%d", minutes];
        } else if(minutes >= 10) {
            minuteString = [NSString stringWithFormat:@"%d", minutes];
        }
        
        if(hours > 12) {
            hours -= 12;
            self.timeString = [[NSString alloc] initWithFormat:@"%d:%@pm", hours, minuteString];
        } else if(hours == 12) {
            self.timeString = [[NSString alloc] initWithFormat:@"%d:%@pm", hours, minuteString];
        } else if(hours == 0) {
            hours = 12;
            self.timeString = [[NSString alloc] initWithFormat:@"%d:%@am", hours, minuteString];
        } else {
            self.timeString = [[NSString alloc] initWithFormat:@"%d:%@am", hours, minuteString];
        }
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
