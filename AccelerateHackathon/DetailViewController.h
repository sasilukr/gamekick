//
//  DetailViewController.h
//  AccelerateHackathon
//
//  Created by Sasiluk Ruangrongsorakai on 2/7/15.
//  Copyright (c) 2015 acceleratesf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import <Parse/Parse.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Event *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (strong, nonatomic) IBOutlet UIImageView *eventImage;
@property (strong, nonatomic) IBOutlet UILabel *eventDate;



@property (strong, nonatomic) IBOutlet UIButton *yesButton;
@property (strong, nonatomic) IBOutlet UIButton *noButton;

- (IBAction)joinEvent:(id)sender;

@end

