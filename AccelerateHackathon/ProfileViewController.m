//
//  ProfileViewController.m
//  AccelerateHackathon
//
//  Created by Sasiluk Ruangrongsorakai on 2/11/15.
//  Copyright (c) 2015 acceleratesf. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    PFUser *user = [PFUser user];
    user.username = self.nameTextField.text;
    user.password = self.nameTextField.text;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
            NSLog(@"Saved Parse User!!!!");
            //    [self goToMasterView];
            [self performSegueWithIdentifier:@"SaveProfileSeque" sender:self];

        } else {
            NSString *errorString = [error userInfo][@"error"];
            
            // Show the errorString somewhere and let the user try again.
            NSLog(@"Save Parse User error %@", errorString);
        }
    }];
}


- (void) goToMasterView
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *controller;
    
    controller = [storyboard instantiateViewControllerWithIdentifier: @"MasterViewController"];
    
    [self presentViewController:controller animated:YES completion:nil];
}

@end
