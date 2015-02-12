//
//  EventModel.m
//  AccelerateHackathon
//
//  Created by Sasiluk Ruangrongsorakai on 2/7/15.
//  Copyright (c) 2015 acceleratesf. All rights reserved.
//

#import "EventList.h"

@implementation EventList

- (id) init {
    self = [super init];
    
//    if (!self) {
//        events = [[NSMutableArray alloc] init];
//    }
    
    return self;
}

+ (EventList*) sharedInstance {
    static EventList* shared;
    
    if (!shared) {
        shared = [[EventList alloc] init];
    }
    
    return shared;
}


- (UIImage*) imageForIndex: (NSInteger) index {
    NSString *imageName = [NSString stringWithFormat: @"%@.png", [events objectAtIndex: index]];
    
    
    return [UIImage imageNamed: imageName];
}

- (NSString*) eventNameForIndex: (NSInteger) index {
    Event *event = [events objectAtIndex: index];
    NSString *lowerCaseName = event.eventName;
    return [lowerCaseName capitalizedString];
}
- (NSString*) eventDateForIndex: (NSInteger) index {
    Event *event = [events objectAtIndex: index];
    return event.eventDate;
}

- (NSInteger) count {
    return events.count;
}

@end

