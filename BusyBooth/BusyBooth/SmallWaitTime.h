//
//  SmallWaitTime.h
//  BusyBooth
//
//  Created by Hunter Lightman on 3/9/16.
//  Copyright © 2016 Krishna Bharathala. All rights reserved.
//

#import "WaitTimeTableViewCell.h"

@interface SmallWaitTime : WaitTimeTableViewCell

@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *minutesLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *gaugeView;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier time:(int)time wait:(int)wait;

@end
