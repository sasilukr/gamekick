//
//  AppDelegate.m
//  AccelerateHackathon
//
//  Created by Sasiluk Ruangrongsorakai on 2/7/15.
//  Copyright (c) 2015 acceleratesf. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // [Optional] Power your app with Local Datastore. For more info, go to
    // https://parse.com/docs/ios_guide#localdatastore/iOS
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"AB0Qf6cNVcIu4BkL2FyveNvOoB4pTFY4Wu5EVyU5"
                  clientKey:@"VOdcvTCTjeaRGLZG2M5HYcaOmuspKoJXsIulGzZo"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    PFUser *currentUser = [PFUser currentUser];
//    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *userId = [defaults objectForKey:@"userId"];
//    NSString *userName = [defaults objectForKey:@"userName"];
//    NSString *groupName = [defaults objectForKey:@"groupName"];
    
    
    
//    if ( !([userId length] > 0) ) {
    if ( !currentUser ) {
        // Redirect to login controller
        NSLog(@"Redirecting to ProfileViewController from AppDelegate");
        ProfileViewController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProfileViewController"];
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];  self.window.rootViewController=navController;
    }

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
