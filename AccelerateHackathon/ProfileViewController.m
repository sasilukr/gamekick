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

static BOOL didViewLoad;

- (void)viewWillAppear:(BOOL)animated
{

}
- (void)viewDidLoad {
    if ( !_userProfile ) {
        _userProfile = [[UserProfile alloc] init];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    NSString *userId = [defaults objectForKey:@"userId"];
    NSString *userName = [defaults objectForKey:@"userName"];
    NSString *groupName = [defaults objectForKey:@"groupName"];
    
    self.nameTextField.text = userName;
    self.groupNameTextField.text = groupName;
    _userProfile.userName = userName;
    _userProfile.groupName = groupName;
    NSLog(@"viewDidLoad %d", didViewLoad);
    
    
    
    if ( !didViewLoad && [userName length] != 0 ) {
        NSLog(@"FirstViewLoad");
        didViewLoad = TRUE;
        [self performSegueWithIdentifier:@"SaveProfileSeque" sender:self];
    } else {
        [super viewDidLoad];
    }


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
    
    _userProfile.userName = self.nameTextField.text;
    _userProfile.groupName = self.groupNameTextField.text;

    PFUser *user = [PFUser user];
    user.username = _userProfile.userName;
    user.password = _userProfile.userName;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"Saved Parse User!!!! %@ ", user);
            _userProfile.userId = user.objectId;

            // Store the data
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:_userProfile.userId forKey:@"userId"];
            [defaults setObject:_userProfile.userName forKey:@"userName"];
            [defaults setObject:_userProfile.groupName forKey:@"groupName"];

            [defaults synchronize];
            
            
            [self performSegueWithIdentifier:@"SaveProfileSeque" sender:self];

        } else {
            NSString *errorString = [error userInfo][@"error"];
            NSLog(@"Parse saveProfile error %@", errorString);
        }
    }];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"SaveProfileSeque"]) {
        
        [[segue destinationViewController] setUserProfile:_userProfile];
    }
}

@end
