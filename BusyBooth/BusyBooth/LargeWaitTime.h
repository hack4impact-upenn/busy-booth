//
//  LargeWaitTime.h
//  BusyBooth
//
//  Created by Hunter Lightman on 3/9/16.
//  Copyright © 2016 Krishna Bharathala. All rights reserved.
//

#import "WaitTimeTableViewCell.h"

@interface LargeWaitTime : WaitTimeTableViewCell

@property (nonatomic, strong) UILabel *subtitleTextLabel;
@property (nonatomic, strong) UILabel *mainTextLabel;
@property (nonatomic, strong) UILabel *minutesTextLabel;
@property (nonatomic, strong) CAShapeLayer *triangleLayer;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier time:(int)time wait:(int)wait;

@end
