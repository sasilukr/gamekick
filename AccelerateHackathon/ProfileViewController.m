//
//  ProfileViewController.m
//  AccelerateHackathon
//
//  Created by Sasiluk Ruangrongsorakai on 2/11/15.
//  Copyright (c) 2015 acceleratesf. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController () {
    
}
@end

@implementation ProfileViewController

- (void)viewDidLoad {
//    if ( !_userProfile ) {
//        _userProfile = [[UserProfile alloc] init];
//    }
//
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    //    NSString *userId = [defaults objectForKey:@"userId"];
//    NSString *userName = [defaults objectForKey:@"userName"];
//    NSString *groupName = [defaults objectForKey:@"groupName"];
//    self.nameTextField.text = userName;
//    self.groupNameTextField.text = groupName;
//    _userProfile.userName = userName;
//    _userProfile.groupName = groupName;
    
    PFUser *currentUser = [PFUser currentUser];
    if ( currentUser ) {
        self.nameTextField.text = currentUser.username;
        self.groupNameTextField.text = currentUser[@"groupName"];
    }
//    _userProfile.userName = currentUser.username;
//    _userProfile.groupName = currentUser[@"groupName"];
    
    
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

- (IBAction)saveProfile:(id)sender {
//    
//    _userProfile.userName = self.nameTextField.text;
//    _userProfile.groupName = self.groupNameTextField.text;

    PFUser *currentUser = [PFUser currentUser];
    BOOL newuser = NO;
    if ( !currentUser ) {
        // login/signup
        // TODO handle login - currently only allow signup
        currentUser = [[PFUser alloc] init];
        newuser = YES;
    }
    currentUser.username = self.nameTextField.text;
    currentUser.password = self.nameTextField.text;
    currentUser[@"groupName"] = self.groupNameTextField.text;
    NSLog(@"saveProfile %@ ", currentUser);

    if ( !newuser ) {
        NSLog(@"saveProfile not newuser");

        [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if ( !error ) {
                NSLog(@"saveProfile updated user");
                [self saveProfileCallback:currentUser];
            } else {
                NSString *errorString = [error userInfo][@"error"];
                NSLog(@"Parse saveProfile error update user %@", errorString);
            }
        }];
    } else {
        NSLog(@"saveProfile newuser");

        [currentUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                NSLog(@"saveProfile signedup user");
                [self saveProfileCallback:currentUser];
            } else {
                NSString *errorString = [error userInfo][@"error"];
                NSLog(@"Parse saveProfile error signup user %@", errorString);
            }
        }];

    }
}

- (void)saveProfileCallback:(PFUser*)user
{
    NSLog(@"Saved Parse User!!!! %@ ", user);

//    
//    // Store the data
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setObject:_userProfile.userId forKey:@"userId"];
//    [defaults setObject:_userProfile.userName forKey:@"userName"];
//    [defaults setObject:_userProfile.groupName forKey:@"groupName"];
//    
//    [defaults synchronize];
    
    [self performSegueWithIdentifier:@"SaveProfileSeque" sender:self];

}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"SaveProfileSeque"]) {
        
//        [[segue destinationViewController] setUserProfile: nil];
    }
}

@end
