//
//  SmallWaitTime.m
//  BusyBooth
//
//  Created by Hunter Lightman on 3/9/16.
//  Copyright © 2016 Krishna Bharathala. All rights reserved.
//

#import "SmallWaitTime.h"

@implementation SmallWaitTime

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier time:(int)time wait:(int)wait {
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier time:time wait:wait];
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
        
        self.descriptionLabel.text = [NSString stringWithFormat:@"%@", [self timeString]];
        self.timeLabel.text = [NSString stringWithFormat:@"%d", [self wait]];
    }
    
    return self;
}

@end
