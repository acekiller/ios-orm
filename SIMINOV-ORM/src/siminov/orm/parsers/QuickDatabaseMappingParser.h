//
//  QuickDatabaseMappingParser.h
//  SIMINOV-ORM
//
//  Created by Anupam on 06/04/13.
//  Copyright (c) 2013 Siminov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseMappingDescriptor.h"

@interface QuickDatabaseMappingParser : NSObject

- (id) initWithClassName : (NSString*)classname;
- (BOOL) processWithError:(NSError**)error;
- (DatabaseMappingDescriptor*) getDatabaseMapping;

@end
