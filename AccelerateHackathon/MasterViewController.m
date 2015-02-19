//
//  MasterViewController.m
//  AccelerateHackathon
//
//  Created by Sasiluk Ruangrongsorakai on 2/7/15.
//  Copyright (c) 2015 acceleratesf. All rights reserved.
//

#import "MasterViewController.h"
#import "EventTableViewCell.h"
#import "DetailViewController.h"
#import <Parse/Parse.h>

@interface MasterViewController () {
    NSMutableArray *eventlist;
    PFUser *currentUser;
}

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    currentUser = [PFUser currentUser];
    
    eventlist = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
//    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *profileButton = [[UIBarButtonItem alloc] initWithTitle:@"\u2699" style:UIBarButtonItemStylePlain target:self action:@selector(showProfile)];
    
    UIFont *customFont = [UIFont fontWithName:@"Helvetica" size:24.0];
    NSDictionary *fontDictionary = @{UITextAttributeFont : customFont};
    [profileButton setTitleTextAttributes:fontDictionary forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = profileButton;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showAddEvent)];
    self.navigationItem.rightBarButtonItem = addButton;
    [self getEvents];


}

- (void) getEvents
{
    
    //  Read all events from Parse
    
    PFQuery *query = [PFQuery queryWithClassName:@"Event"];
    [query whereKey:@"groupName" equalTo:currentUser[@"groupName"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d events.", results.count);

            
            // Do something with the found objects
            for (PFObject *result in results) {
                Event *event = [[Event alloc] init];
                event.eventId = result.objectId;
                event.eventName = result[@"name"];
                event.eventDate = result[@"eventDate"];
                event.eventImageUrl = result[@"image_url"];
                event.totalPeople = [result[@"total_people"] integerValue];
                event.minPeople = [result[@"min_people"] integerValue];
                [eventlist addObject:event];
            }
            [self.tableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}



//- (void)setUserProfile:(UserProfile *)newUserProfile
//{
//    
//    if (_userProfile != newUserProfile) {
//        _userProfile = newUserProfile;
//        
//         NSLog(@"MasterViewController userName %@", _userProfile.userName);
//
//        // TODO update list view
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showProfile
{
    NSLog(@"MasterViewController show profile view controller");
  
    [self performSegueWithIdentifier:@"ShowProfileSeque" sender:self];
    
}

- (void)showAddEvent
{
    
    NSLog(@"MasterViewController show add event view controller");
    
    [self performSegueWithIdentifier:@"ShowAddEventSeque" sender:self];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        Event *event = [eventlist objectAtIndex: indexPath.row];
        
        [[segue destinationViewController] setDetailItem:event];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [eventlist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Event *event = [eventlist objectAtIndex:indexPath.row];
    cell.eventNameLabel.text =  event.eventName;
    cell.eventDateLabel.text = event.eventDate;
    cell.eventMemberCountLabel.text = [NSString stringWithFormat:@"%d/%d", event.totalPeople, event.minPeople];
    
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [eventlist removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
