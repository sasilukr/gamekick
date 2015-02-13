//
//  UserProfile.m
//  AccelerateHackathon
//
//  Created by Sasiluk Ruangrongsorakai on 2/11/15.
//  Copyright (c) 2015 acceleratesf. All rights reserved.
//

#import "UserProfile.h"

@implementation UserProfile

- (NSString *)description {
    return [NSString stringWithFormat: @"UserProfile: userId=%@ userName=%@ groupName=%@", _userId, _userName, _groupName];
}

@end
