//
//  EventModel.h
//  AccelerateHackathon
//
//  Created by Sasiluk Ruangrongsorakai on 2/7/15.
//  Copyright (c) 2015 acceleratesf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventList : NSMutableArray

@property NSMutableArray *events;


+ (EventList*) sharedInstance;
- (UIImage*) imageForIndex: (NSInteger) index;

- (NSString*) eventNameForIndex: (NSInteger) index;
- (NSString*) eventDateForIndex: (NSInteger) index;

- (NSInteger) count;


@end
