//
//  SiminovCriticalException.h
//  SIMINOV-ORM
//
//  Created by Anupam on 31/03/13.
//  Copyright (c) 2013 Siminov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SiminovCriticalException : NSException

- (id) initWithClassName:(NSString*)className methodName:(NSString*)methodName message:(NSString*)message;
- (NSString*) className;
- (void) setClassName : (NSString*) className;

@end
