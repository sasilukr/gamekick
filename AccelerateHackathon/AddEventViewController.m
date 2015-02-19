//
//  AddEventViewController.m
//  AccelerateHackathon
//
//  Created by Sasiluk Ruangrongsorakai on 2/11/15.
//  Copyright (c) 2015 acceleratesf. All rights reserved.
//

#import "AddEventViewController.h"
#import "DetailViewController.h"

@interface AddEventViewController ()

@end

@implementation AddEventViewController



- (void)viewDidLoad {
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    
//    NSString *userId = [defaults objectForKey:@"userId"];
//    NSString *userName = [defaults objectForKey:@"userName"];
//    NSString *groupName = [defaults objectForKey:@"groupName"];
//    
//    userProfile = [[UserProfile alloc] init];
//    userProfile.userId = userId;
//    userProfile.userName = userName;
//    userProfile.groupName = groupName;
//    
    
    _currentEvent = [[Event alloc] init];
    
    [super viewDidLoad];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)createEvent:(id)sender {
    
    _currentEvent.eventName = self.eventNameTextField.text;
    _currentEvent.eventDate = [NSDateFormatter localizedStringFromDate:[self.eventDateTimePicker date]
                                   dateStyle:NSDateFormatterShortStyle
                                   timeStyle:NSDateFormatterMediumStyle];
    
    _currentEvent.eventDescription = self.descriptionTextField.text;
    _currentEvent.minPeople = [self.minPeopleTextField.text integerValue];
    
    _currentEvent.totalPeople = 1;
    _currentEvent.isActive = NO;
    
    
    PFObject *pEvent = [PFObject objectWithClassName:@"Event"];
    pEvent[@"name"] = _currentEvent.eventName;
    pEvent[@"eventDate"] = _currentEvent.eventDate;
    pEvent[@"description"] = _currentEvent.eventDescription;
    pEvent[@"min_people"] = @(_currentEvent.minPeople);
    pEvent[@"total_people"] = @(_currentEvent.totalPeople);
    
    NSLog(@"createEvent %@", _currentEvent);
    
    PFUser *currentUser = [PFUser currentUser];
    pEvent[@"creator"] = currentUser.username; // TODO change to user object
    pEvent[@"groupName"] = currentUser[@"groupName"];


    [pEvent addObject:currentUser forKey:@"users"];     // add current user to event users array
    
    
    [pEvent saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Event created!!!!");
            [self performSegueWithIdentifier:@"ShowAddedEventSeque" sender:self];
        } else {
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"Parse createEvent error %@", errorString);
        }
    }];
    
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowAddedEventSeque"]) {

//        [[segue destinationViewController] setDetailItem:_currentEvent];

    }
}

@end
