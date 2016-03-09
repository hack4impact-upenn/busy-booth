//
//  LargeWaitTime.m
//  BusyBooth
//
//  Created by Hunter Lightman on 3/9/16.
//  Copyright © 2016 Krishna Bharathala. All rights reserved.
//

#import "LargeWaitTime.h"

@implementation LargeWaitTime

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier time:(int)time wait:(int)wait {
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier time:time wait:wait];
    
    if (self) {
        // configure control(s)
        self.textLabel.frame = CGRectMake(0, self.textLabel.frame.origin.y, 10000, self.textLabel.frame.size.height);
        self.detailTextLabel.frame = CGRectMake(0, self.detailTextLabel.frame.origin.y, self.frame.size.width, self.detailTextLabel.frame.size.height);
        
        self.textLabel.font = [UIFont fontWithName:@"Arial" size:60.0f];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        
        self.detailTextLabel.font = [UIFont fontWithName:@"Arial" size:11.0f];
        self.detailTextLabel.textAlignment = NSTextAlignmentCenter;
        self.detailTextLabel.numberOfLines = 2;
        self.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        self.textLabel.text = [NSString stringWithFormat:@"%d", self.wait];
        self.detailTextLabel.text = [NSString stringWithFormat:@"Minutes\nLast Updated: %@", self.timeString];
    }
    
    return self;
}

@end
