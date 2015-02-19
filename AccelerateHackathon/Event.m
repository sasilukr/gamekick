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
    return [NSString stringWithFormat: @"Event: \r\t\tName=%@ \r\t\tDate=%@ \r\t\tMin People=%d \r\t\tCreator=%@ \r\t\tPlayers=%@", _eventName, _eventDate, _minPeople, _creator, _players];
}

@end
