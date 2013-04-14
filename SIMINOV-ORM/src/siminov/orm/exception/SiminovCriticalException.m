//
//  SiminovCriticalException.m
//  SIMINOV-ORM
//
//  Created by Anupam on 31/03/13.
//  Copyright (c) 2013 Siminov. All rights reserved.
//

#import "SiminovCriticalException.h"

@interface SiminovCriticalException()

@property (nonatomic, strong) NSString* className;
@property (nonatomic, strong) NSString* methodName;
@property (nonatomic, strong) NSString* message;

@end

@implementation SiminovCriticalException

- (id) initWithClassName:(NSString*)className methodName:(NSString*)methodName message:(NSString*)message {
    
    if(self)
    {
        self.className = className;
        self.methodName = methodName;
        self.message = message;
    }
    
    return self;
}

/**
 * Get POJO class name.
 * @return POJO Class Name.
 */
- (NSString*) getClassName {
    return self.className;
}

/**
 * Set POJO class name.
 * @param className POJO Class Name.
 */
- (void) setClassName : (NSString*) className {
    self.className = className;
}

/**
 * Get method Name.
 * @return Name Of Method.
 */
- (NSString*) getMethodName {
    return self.methodName;
}

/**
 * Set method Name.
 * @param methodName Name Of Method.
 */
- (void) setMethodName : (NSString*) methodName {
    self.methodName = methodName;
}

/**
 * Get message.
 * @return Message.
 */
- (NSString*) getMessage {
    return self.message;
}

/**
 * Set message.
 * @param message Message.
 */
- (void) setMessage : (NSString*) message {
    self.message = message;
}


@end
