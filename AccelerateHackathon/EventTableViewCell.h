//
//  EventTableViewCell.h
//  AccelerateHackathon
//
//  Created by Sasiluk Ruangrongsorakai on 2/7/15.
//  Copyright (c) 2015 acceleratesf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *eventNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *eventDateLabel;

@end
