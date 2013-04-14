//
//  EventHandler.h
//  SIMINOV-ORM
//
//  Created by Anupam on 13/04/13.
//  Copyright (c) 2013 Siminov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISiminovEvents.h"
#import "IDatabaseEvents.h"
#import "Resources.h"

@interface EventHandler : NSObject

/* Get instance of EventHandler class */
+ (EventHandler*) getInstance;

/* Get core event handler registered by application. */
- (ISiminovEvents*) getSiminovEventHandler;

/* Get database event handler registered by application. */
- (IDatabaseEvents*) getDatabaseEventHandler;

@end
