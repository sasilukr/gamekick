//
//  DetailViewController.m
//  AccelerateHackathon
//
//  Created by Sasiluk Ruangrongsorakai on 2/7/15.
//  Copyright (c) 2015 acceleratesf. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

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
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)joinEvent:(id)sender
{
    
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:self.detailItem.eventId block:^(PFObject *result, NSError *error) {
        
         NSLog(@"Success joinEvent for eventId %@", self.detailItem.eventId);
        
        // Now let's update it with some new data. In this case, only cheatMode and score
        // will get sent to the cloud. playerName hasn't changed.
//        result[@"creator"] = @"iOS App";
        result[@"total_people"] = @(self.detailItem.totalPeople+1);
        if ( self.detailItem.totalPeople+1 == self.detailItem.minPeople ) {
            // TODO send alert to all group members
            result[@"isActive"] = @YES;
        }
        [result saveInBackground];
        
    }];
    
}
@end
