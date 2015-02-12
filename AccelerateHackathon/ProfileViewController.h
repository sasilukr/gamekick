//
//  ProfileViewController.h
//  AccelerateHackathon
//
//  Created by Sasiluk Ruangrongsorakai on 2/11/15.
//  Copyright (c) 2015 acceleratesf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "UserProfile.h"

@interface ProfileViewController : UIViewController

@property (strong, nonatomic) UserProfile *userProfile;


@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *groupNameTextField;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;

- (IBAction)saveProfile:(id)sender;

@end
