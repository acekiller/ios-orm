/**
 * [SIMINOV FRAMEWORK]
 * Copyright [2013] [Siminov Software Solution|support@siminov.com]
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

#import <Foundation/Foundation.h>
#import "DatabaseDescriptor.h"

@interface ApplicationDescriptor : NSObject

/* Get name of Application Descriptor */
-(NSString*) getName;

/* Set Application Descriptor Name */
- (void) setName :(NSString*) name;

/* Get Description of application. */
-(NSString*) getDescription;

/* Set Description of application. */
- (void) setDescription : (NSString*) description;

/* Get version of application */
-(double) getVersion;

/* Set version of application */
- (void) setVersion : (double) version;

/* Check whether database needed by application or not */
- (BOOL) isDatabaseNeeded;

/* Check whether database descriptor exists in Resources or not */
- (BOOL) containsDatabaseDescriptor : (const DatabaseDescriptor*) databaseDescriptor;

/* Check whether database descriptor exists in Resources or not, based on database descriptor path */
- (BOOL) containsDatabaseDescriptorBasedOnPath : (const NSString*) databaseDescriptorPath;

/* Check whether database descriptor exists in Resources or not, based on Database Descriptor name */
- (BOOL) containsDatabaseDescriptorBasedOnName : (const NSString*) databaseDescriptorName;

/* Get Database Descriptor based on Database Descriptor Name */
- (DatabaseDescriptor*) getDatabaseDescriptorBasedOnName : (const NSString*) databaseDescriptorName;

/* Get Database Descriptor based on Database Descriptor Path */
- (DatabaseDescriptor*) getDatabaseDescriptorBasedOnPath : (NSString*) databaseDescriptorPath;

/* Get all database descriptor paths */
- (NSArray*) getDatabaseDescriptorPaths;

/* Get all database descriptor names */
- (NSArray*) getDatabaseDescriptorNames;

/* Add Database Descriptor path */
- (void) addDatabaseDescriptorPath : (NSString*) databaseDescriptorPath;

/* Get all database descriptor objects */
- (NSArray*) getDatabaseDescriptors;

/* Add Database Descriptor object in respect to database descriptor path */
- (void) addDatabaseDescriptor : (NSString*) databaseDescriptorPath forDatabaseDescriptor : (DatabaseDescriptor*) databaseDescriptor;

/* Remove Database Descriptor from Resources based on database path provided */
- (void) removeDatabaseDescriptorBasedOnPath : (NSString*) databaseDescriptorPath;

/* Remove Database Descriptor from Resources based on database name provided */
- (void) removeDatabaseDescriptorBasedOnName : (NSString*) databaseDescriptorName;

/* Remove DatabaseDescriptor object from Resources */
- (void) removeDatabaseDescriptor : (DatabaseDescriptor*) databaseDescriptor;

/* It defines the behaviour of CORE. (Should core load all database mapping at initialization or on demand) */
- (BOOL) doLoadInitially;

/* Set load initially to true or false */
- (void) setLoadInitially : (BOOL) initialLoad;

/* Get all event handlers */
- (NSArray*) getEvents;

/* Add event */
- (void) addEvent : (NSString*) event;

@end
