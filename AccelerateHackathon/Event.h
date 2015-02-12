//
//  Event.h
//  AccelerateHackathon
//
//  Created by Sasiluk Ruangrongsorakai on 2/7/15.
//  Copyright (c) 2015 acceleratesf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property NSString *eventId;
@property NSString *eventName;
@property NSString *eventDate;
@property NSString *eventDescription;
@property NSString *creator;
@property NSInteger minPeople;
@property NSInteger totalPeople;
@property BOOL isActive;


@property NSString *eventImageUrl;


@end
