//
//  ISiminovEvents.h
//  SIMINOV-ORM
//
//  Created by Anupam on 13/04/13.
//  Copyright (c) 2013 Siminov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISiminovEvents : NSObject

/**
 * This event gets fired when SIMINOV is initialize for first time.
 */
- (void) firstTimeSiminovInitialized;


/**
 * This event gets fired when SIMINOV is initialize.
 */
- (void) siminovInitialized;


/**
 * This event gets fired when SIMINOV is stopped.
 */
- (void) siminovStopped;


@end
