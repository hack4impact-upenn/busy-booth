//
//  WaitTimeTableViewCell.h
//  BusyBooth
//
//  Created by Krishna Bharathala on 2/21/16.
//  Copyright © 2016 Krishna Bharathala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaitTimeTableViewCell : UITableViewCell

@property (nonatomic) int time;
@property (nonatomic) int wait;
@property (nonatomic, strong) NSString *timeString;

@property (nonatomic, strong) UIColor *foregroundColor;

@property (nonatomic, strong) UIImage *gaugeImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier time:(int)time wait:(int) wait;

@end
