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
#import "DatabaseMappingDescriptor.h"

@interface LibraryDescriptor : NSObject

/* Get library name */
- (NSString*) name;

/* Set library name as per defined in LibraryDescriptor.core.xm */
- (void) setName: (const NSString*) name;

/* Get descriptor as per defined in LibraryDescriptor.core.xml */
- (NSString*) getDescriptor;

/* Set description as per defined in LibraryDescritor.core.xm */
- (void) setDescriptor : (NSString*) descriptor;

/* Check whether database mapping object exists or not, based on table name */
- (BOOL) containsDatabaseMappingBasedOnTableName : (NSString*) tableName;

/* Check whether database mapping object exists or not, based on POJO class name */
- (BOOL) containsDatabaseMappingBasedOnClassName : (NSString*) className;

/* Get all database mapping paths as per defined in DatabaseDescriptor.core.xml file */
- (NSArray*) getDatabaseMappingPaths;

/* Add database mapping path as per defined in DatabaseDescriptor.core.xml file. */
- (void) addDatabaseMappingPath : (NSString*) databaseMappingPath;


/* Get all database mapping objects contained */
- (NSArray*) getDatabseMappings;

/* Get database mapping object based on table name.*/
- (DatabaseMappingDescriptor*) getDatabseMappingBasedOnTableName : (NSString*) tableName;

/* Get database mapping object based on POJO class name */
- (DatabaseMappingDescriptor*) getDatabseMappingBasedOnClassName : (NSString*) className;

/* Get database mapping object based on path */
- (DatabaseMappingDescriptor*) getDatabseMappingBasedOnPath : (NSString*) libraryDatabaseMappingPath;

/* Add database mapping object in respect to database mapping path */
- (void) addDatabaseMapping : (NSString*) libraryDatabaseMappingPath forDatabaseMapping : (DatabaseMappingDescriptor*) databaseMapping;

/* Remove database mapping object based on database mapping path */
- (void) removeDatabaseMappingBasedOnPath : (NSString*) databaseMappingPath;

/* Remove database mappping object based on POJO class name */
- (void) removeDatabaseMappingBasedOnClassName : (NSString*) className;

/* Remove database mapping object based on table name */
- (void) removeDatabaseMappingBasedOnTableName : (NSString*) tableName;

/* Remove database mapping object based on database mapping object */
- (void) removeDatabaseMapping : (DatabaseMappingDescriptor*) databaseMapping;

/* Get all database mapping objects in sorted order. The order will be as per defined in DatabaseDescriptor.core.xml file */
- (NSArray*) orderedDatabaseMappings;

@end
