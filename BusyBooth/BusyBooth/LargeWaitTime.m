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
        float mainSize = 105.0f;
        float subSize = 11.0f;
        float padding = 15.0f;
        
        float height = 200.0f;
        
        float mainPosition = (height - (mainSize + subSize * 3))/2.0f;
        
        self.mainTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, mainPosition, self.frame.size.width, mainSize)];
        self.mainTextLabel.font = [UIFont fontWithName:@"Arial" size:mainSize];
        self.mainTextLabel.textAlignment = NSTextAlignmentCenter;
        self.mainTextLabel.textColor = [self foregroundColor];
        [self addSubview:self.mainTextLabel];
        
        self.minutesTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, mainPosition + mainSize + -14.0f, self.frame.size.width, subSize * 3)];
        self.minutesTextLabel.font = [UIFont fontWithName:@"Arial" size:14.0f];
        self.minutesTextLabel.textAlignment = NSTextAlignmentCenter;
        self.minutesTextLabel.textColor = [self foregroundColor];
        self.minutesTextLabel.text = @"Minutes";
        [self addSubview:self.minutesTextLabel];
        
        self.subtitleTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, mainPosition + mainSize + padding, self.frame.size.width, subSize * 3)];
        self.subtitleTextLabel.font = [UIFont fontWithName:@"Arial" size:subSize];
        self.subtitleTextLabel.textAlignment = NSTextAlignmentCenter;
        self.subtitleTextLabel.textColor = [self foregroundColor];
        [self addSubview:self.subtitleTextLabel];
        
        CGFloat center = self.frame.size.width / 2;
        CGFloat triangleWidth = 34.0;
        CGFloat triangleHeight = 17;
        self.triangleLayer = [[CAShapeLayer alloc] init];
        self.triangleLayer.frame = self.layer.bounds;
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, nil, center - triangleWidth / 2, 0);
        CGPathAddLineToPoint(path, nil, center + triangleWidth / 2, 0);
        CGPathAddLineToPoint(path, nil, center, triangleHeight);
        CGPathAddLineToPoint(path, nil, center - triangleWidth / 2, 0);
        self.triangleLayer.path = path;
        self.triangleLayer.fillColor = [UIColor colorWithRed:229.0/255.0 green:22.0/255.0 blue:47.0/255.0 alpha:1.0].CGColor;
        [self.layer addSublayer:self.triangleLayer];
        
        self.mainTextLabel.text = [NSString stringWithFormat:@"%d", self.wait];
        self.subtitleTextLabel.text = [NSString stringWithFormat:@"Last Updated: %@", self.timeString];
    }
    
    return self;
}

@end
