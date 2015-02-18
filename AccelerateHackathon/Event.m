//
//  Event.m
//  AccelerateHackathon
//
//  Created by Sasiluk Ruangrongsorakai on 2/7/15.
//  Copyright (c) 2015 acceleratesf. All rights reserved.
//

#import "Event.h"

@implementation Event

- (NSString *)description {
    return [NSString stringWithFormat: @"Event: \n\t\tName=%@ \n\t\tDate=%@ \n\t\tMin People=%d \n\t\tCreator=%@", _eventName, _eventDate, _minPeople, _creator];
}

@end
