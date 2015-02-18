//
//  DetailViewController.m
//  AccelerateHackathon
//
//  Created by Sasiluk Ruangrongsorakai on 2/7/15.
//  Copyright (c) 2015 acceleratesf. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () {
    UserProfile *userProfile;
}

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = self.detailItem.eventName;
        self.eventDate.text = self.detailItem.eventDate;
        self.eventMemberCountLabel.text = [NSString stringWithFormat:@"%d/%d", self.detailItem.totalPeople, self.detailItem.minPeople];
        
        PFUser *currentUser = [PFUser currentUser];
        PFQuery *eventQuery = [PFQuery queryWithClassName:@"Event"];
        [eventQuery whereKey:@"users" equalTo:currentUser];
        [eventQuery includeKey:@"users"];
        
        
        
//        [eventQuery getObjectInBackgroundWithId:self.detailItem.eventId block:^(PFObject *eventResult, NSError *error) {
        [eventQuery findObjectsInBackgroundWithBlock:^(NSArray *events, NSError *error) {
            
            NSLog(@"DetailViewController configureView currentUser %@ for event %@", currentUser, events);

            if ( events.count > 0 ) {
                // user has already joined the event
                [_yesButton setHidden:YES];
            } else {
                // user hasn't joined the event
                // TODO keep track of when user rejects event so don't ask user to response again
                [_noButton setHidden:YES];
            }
            
        }];
        
    }
}

- (void)viewDidLoad {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [defaults objectForKey:@"userId"];
    NSString *userName = [defaults objectForKey:@"userName"];
    NSString *groupName = [defaults objectForKey:@"groupName"];
    
    userProfile.userId = userId;
    userProfile.userName = userName;
    userProfile.groupName = groupName;
    
    [super viewDidLoad];
    [self configureView];
    
//    UIBarButtonItem *viewAllButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showEventList)];
//    self.navigationItem.leftBarButtonItem = viewAllButton;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)showEventList
{
    NSLog(@"DetailViewController show master view controller");
    
    [self performSegueWithIdentifier:@"ShowProfileSeque" sender:self];
    
}


- (IBAction)joinEvent:(id)sender
{
    
    PFUser *pfUser = [PFUser currentUser];
    
    PFObject *pfEvent = [PFObject objectWithClassName:@"Event"];
    pfEvent.objectId = self.detailItem.eventId;
    [pfEvent addObject:pfUser forKey:@"users"];
    
    
    pfEvent[@"total_people"] = @(self.detailItem.totalPeople+1);
    if ( self.detailItem.totalPeople+1 == self.detailItem.minPeople ) {
        // TODO send alert to all group members
        pfEvent[@"isActive"] = @YES;
    }
    
    [pfEvent saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {

            self.detailItem.totalPeople = [pfEvent[@"total_people"] intValue];
            [self configureView];

        } else {
            NSLog(@"Error joinEvent");
        }
    }];
    
    // update view after save
    
    [_yesButton setHidden:YES];
    [_noButton setHidden:NO];
    
    NSLog(@"Success: userId %@ joinEvent eventId %@", pfUser.objectId, self.detailItem.eventId);
    
    
}

- (IBAction)leaveEvent:(id)sender
{
    PFUser *pfUser = [PFUser currentUser];
    
    PFObject *pfEvent = [PFObject objectWithClassName:@"Event"];
    pfEvent.objectId = self.detailItem.eventId;
    [pfEvent removeObject:pfUser forKey:@"users"];

    pfEvent[@"total_people"] = @(self.detailItem.totalPeople-1);
    if ( self.detailItem.totalPeople-1 < self.detailItem.minPeople ) {
        // TODO send alert to all group members
        pfEvent[@"isActive"] = @NO;
    }
    
    [pfEvent saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            
            self.detailItem.totalPeople = [pfEvent[@"total_people"] intValue];
            [self configureView];
            
        } else {
            NSLog(@"Error leaveEvent");
        }
    }];
    
    [_yesButton setHidden:NO];
    [_noButton setHidden:YES];

    NSLog(@"Success: userId %@ leaveEvent eventId %@", pfUser.objectId, self.detailItem.eventId);
}
@end
