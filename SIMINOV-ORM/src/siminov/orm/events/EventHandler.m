//
//  EventHandler.m
//  SIMINOV-ORM
//
//  Created by Anupam on 13/04/13.
//  Copyright (c) 2013 Siminov. All rights reserved.
//

#import "EventHandler.h"

static EventHandler* eventHandler = nil;

@interface EventHandler()

@property (nonatomic, strong) ISiminovEvents* coreEventHandler;
@property (nonatomic, strong) IDatabaseEvents* databaseEventHandler;

//private Resources resources = Resources.getInstance();

@end

@implementation EventHandler

/*
private EventHandler() {
    
    Iterator<String> events = resources.getApplicationDescriptor().getEvents();
    while(events.hasNext()) {
        String event = events.next();
        
        Object object = ClassUtils.createClassInstance(event);
        if(object instanceof ISiminovEvents) {
            coreEventHandler = (ISiminovEvents) object;
        } else if(object instanceof IDatabaseEvents) {
            databaseEventHandler = (IDatabaseEvents) object;
        }
    }
}
 */

+ (EventHandler*) getInstance {
    
    @synchronized([EventHandler class])
    {
        if(eventHandler == nil) {
            eventHandler = [[self alloc] init];
        }
        
        return eventHandler;
    }
    
    return nil;
}

/**
 * Get core event handler registered by application.
 * @return ISiminovEvents object implemented by application.
 */
- (ISiminovEvents*) getSiminovEventHandler {
    return [self coreEventHandler];
}

/**
 * Get database event handler registered by application.
 * @return IDatabaseEvents object implemented by application.
 */
- (IDatabaseEvents*) getDatabaseEventHandler {
    return [self databaseEventHandler];
}


@end
