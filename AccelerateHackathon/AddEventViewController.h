//
//  AddEventViewController.h
//  AccelerateHackathon
//
//  Created by Sasiluk Ruangrongsorakai on 2/11/15.
//  Copyright (c) 2015 acceleratesf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Event.h"
#import "UserProfile.h"

@interface AddEventViewController : UIViewController

@property (strong, nonatomic) Event *currentEvent;
@property (strong, nonatomic) IBOutlet UITextField *eventNameTextField;
@property (strong, nonatomic) IBOutlet UIDatePicker *eventDateTimePicker;
@property (strong, nonatomic) IBOutlet UITextField *minPeopleTextField;
@property (strong, nonatomic) IBOutlet UITextField *descriptionTextField;
- (IBAction)createEvent:(id)sender;

@end
