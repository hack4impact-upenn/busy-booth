//
//  WaitTimeTableViewCell.m
//  BusyBooth
//
//  Created by Krishna Bharathala on 2/21/16.
//  Copyright © 2016 Krishna Bharathala. All rights reserved.
//

#import "WaitTimeTableViewCell.h"

@implementation WaitTimeTableViewCell

// minimum time for a yellow background
int const MEDIUM_WAIT_THRESHOLD = 30;

// minimum time for a red background
int const LONG_WAIT_THRESHOLD = 50;

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
        
        // finally, color self
        
        // the background colors
        UIColor   *GREEN_BACKGROUND = [UIColor colorWithRed:231.0/255.0 green:245.0/255.0 blue:237.0/255.0 alpha:1.0];
        UIColor     *RED_BACKGROUND = [UIColor colorWithRed:252.0/255.0 green:233.0/255.0 blue:234.0/255.0 alpha:1.0];
        UIColor  *YELLOW_BACKGROUND = [UIColor colorWithRed:253.0/255.0 green:250.0/255.0 blue:233.0/255.0 alpha:1.0];
        
        // the text colors
        UIColor   *GREEN_FOREGROUND = [UIColor colorWithRed:37.0/255.0 green:149.0/255.0 blue:69.0/255.0 alpha:1.0];
        UIColor     *RED_FOREGROUND = [UIColor colorWithRed:229.0/255.0 green:22.0/255.0 blue:47.0/255.0 alpha:1.0];
        UIColor  *YELLOW_FOREGROUND = [UIColor colorWithRed:239.0/255.0 green:214.0/255.0 blue:46.0/255.0 alpha:1.0];
        
        if(wait < MEDIUM_WAIT_THRESHOLD) {
            self.backgroundColor = GREEN_BACKGROUND;
            self.foregroundColor = GREEN_FOREGROUND;
            self.gaugeImage = [UIImage imageNamed:@"LowGauge.svg"];
        } else if(wait < LONG_WAIT_THRESHOLD) {
            self.backgroundColor = YELLOW_BACKGROUND;
            self.foregroundColor = YELLOW_FOREGROUND;
            self.gaugeImage = [UIImage imageNamed:@"MediumGauge.png"];

        } else {
            self.backgroundColor = RED_BACKGROUND;
            self.foregroundColor = RED_FOREGROUND;
            self.gaugeImage = [UIImage imageNamed:@"HighGauge.svg"];
        }
        
        [self.contentView.layer setBorderColor:[UIColor whiteColor].CGColor];
        [self.contentView.layer setBorderWidth:1.0f];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
