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
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier time:time wait:wait];
    
    if (self) {
        // configure control(s)
        float mainSize = 70.0f;
        float subSize = 11.0f;
        float padding = 0.0f;
        
        float height = 200.0f;
        
        float mainPosition = (height - (mainSize + subSize * 3))/2.0f;
        
        self.mainTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, mainPosition, self.frame.size.width, mainSize)];
        self.mainTextLabel.font = [UIFont fontWithName:@"Arial" size:mainSize];
        self.mainTextLabel.textAlignment = NSTextAlignmentCenter;
        self.mainTextLabel.textColor = [self foregroundColor];
        [self addSubview:self.mainTextLabel];
        
        self.subtitleTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, mainPosition + mainSize + padding, self.frame.size.width, subSize * 3)];
        self.subtitleTextLabel.font = [UIFont fontWithName:@"Arial" size:subSize];
        self.subtitleTextLabel.textAlignment = NSTextAlignmentCenter;
        self.subtitleTextLabel.numberOfLines = 2;
        self.subtitleTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.subtitleTextLabel.textColor = [self foregroundColor];
        [self addSubview:self.subtitleTextLabel];
        
        self.mainTextLabel.text = [NSString stringWithFormat:@"%d", self.wait];
        self.subtitleTextLabel.text = [NSString stringWithFormat:@"Minutes\nLast Updated: %@", self.timeString];
    }
    
    return self;
}

@end
