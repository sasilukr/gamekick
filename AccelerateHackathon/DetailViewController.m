//
//  DetailViewController.m
//  AccelerateHackathon
//
//  Created by Sasiluk Ruangrongsorakai on 2/7/15.
//  Copyright (c) 2015 acceleratesf. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController () {
    PFUser *currentUser;
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
        
        PFUser *user = [PFUser currentUser];
//        PFQuery *eventUserQuery = [PFQuery queryWithClassName:@"Event"];
//        [eventUserQuery whereKey:@"users" equalTo:user];
//        [eventUserQuery includeKey:@"users"];
        
        NSLog(@"configureView players %@", self.detailItem.players);
        
        [_yesButton setHidden:[self.detailItem.players containsObject:user]];
        [_noButton setHidden:![self.detailItem.players containsObject:user]];
        
//        if ([self.detailItem.players containsObject:user]) {
//
//        } else {
//            [_yesButton setHidden:NO];
//            [_noButton setHidden:YES];
//        }
        
//        PFQuery *eventQuery = [PFQuery queryWithClassName:@"Event"];
//        [eventUserQuery whereKey:@"objectId" equalTo:self.detailItem.eventId];

        
//        PFQuery *query = [PFQuery orQueryWithSubqueries:@[eventUserQuery,eventQuery]];
        
//        [eventUserQuery getObjectInBackgroundWithId:self.detailItem.eventId block:^(PFObject *eventResult, NSError *error) {
       
        
//        [eventUserQuery findObjectsInBackgroundWithBlock:^(NSArray *events, NSError *error) {
        
//            NSLog(@"DetailViewController configureView currentUser %@ for event %@", user, events);
//            NSLog(@"DetailViewController configureView  currentUser %@ for event %@", user, eventResult);

//            if ( events.count > 0 ) {
                // user has already joined the event
//                [_yesButton setHidden:YES];
//            } else {
                // user hasn't joined the event
                // TODO keep track of when user rejects event so don't ask user to response again
//                [_noButton setHidden:YES];
//            }
        
//        }];
        
    }
}

- (void)viewDidLoad {
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *userId = [defaults objectForKey:@"userId"];
//    NSString *userName = [defaults objectForKey:@"userName"];
//    NSString *groupName = [defaults objectForKey:@"groupName"];
//    
//    userProfile.userId = userId;
//    userProfile.userName = userName;
//    userProfile.groupName = groupName;
    
    currentUser = [PFUser currentUser];
    
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
    
//    PFUser *pfUser = [PFUser currentUser];
    
    PFObject *pfEvent = [PFObject objectWithClassName:@"Event"];
    pfEvent.objectId = self.detailItem.eventId;
    [pfEvent addObject:currentUser forKey:@"users"];
    
    
    pfEvent[@"total_people"] = @(self.detailItem.totalPeople+1);
    if ( self.detailItem.totalPeople+1 == self.detailItem.minPeople ) {
        // TODO send alert to all group members
        pfEvent[@"isActive"] = @YES;
    }
    
    [pfEvent saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {

            [pfEvent fetch];
            Event *event = [[Event alloc] init];
            event.eventId = pfEvent.objectId;
            event.eventName = pfEvent[@"name"];
            event.eventDate = pfEvent[@"eventDate"];
            event.eventImageUrl = pfEvent[@"image_url"];
            event.totalPeople = [pfEvent[@"total_people"] integerValue];
            event.minPeople = [pfEvent[@"min_people"] integerValue];
            event.players = pfEvent[@"users"];
            event.isActive = [pfEvent[@"isActive"] boolValue];
    

            self.detailItem = event;
            NSLog(@"Success leaveEvent %@", self.detailItem);

            [self configureView];

        } else {
            NSLog(@"Error joinEvent");
        }
    }];
    
    // update view after save
    
//    [_yesButton setHidden:YES];
//    [_noButton setHidden:NO];
    
    // TODO update eventlist member and count
    
    NSLog(@"Success: userId %@ joinEvent eventId %@", currentUser.objectId, self.detailItem.eventId);
    
    
}

- (IBAction)leaveEvent:(id)sender
{
//    PFUser *pfUser = [PFUser currentUser];
    
    PFObject *pfEvent = [PFObject objectWithClassName:@"Event"];
    pfEvent.objectId = self.detailItem.eventId;
    [pfEvent removeObject:currentUser forKey:@"users"];

    pfEvent[@"total_people"] = @(self.detailItem.totalPeople-1);
    if ( self.detailItem.totalPeople-1 < self.detailItem.minPeople ) {
        // TODO send alert to all group members
        pfEvent[@"isActive"] = @NO;
    }
    
    [pfEvent saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [pfEvent fetch];

            
            Event *event = [[Event alloc] init];
            event.eventId = pfEvent.objectId;
            event.eventName = pfEvent[@"name"];
            event.eventDate = pfEvent[@"eventDate"];
            event.eventImageUrl = pfEvent[@"image_url"];
            event.totalPeople = [pfEvent[@"total_people"] integerValue];
            event.minPeople = [pfEvent[@"min_people"] integerValue];
            event.players = pfEvent[@"users"];
            event.isActive = [pfEvent[@"isActive"] boolValue];
            
            self.detailItem = event;
            NSLog(@"Success leaveEvent %@", self.detailItem);

            [self configureView];
            
        } else {
            NSLog(@"Error leaveEvent");
        }
    }];
    
//    [_yesButton setHidden:NO];
//    [_noButton setHidden:YES];

    NSLog(@"Success: userId %@ leaveEvent eventId %@", currentUser.objectId, self.detailItem.eventId);
}
@end
