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
#import "LibraryDescriptor.h"

@interface DatabaseDescriptor : NSObject

/* Get database descriptor name as defined in DatabaseDescriptor.core.xml file */
- (NSString*) getDatabaseName;

/* Set database descriptor name as per defined in DatabaseDescriptor.core.xml file */
- (void) setDatabaseName : (NSString*) databaseName;

/*  * Get description as per defined in DatabaseDescriptor.core.xml file */
- (NSString*) getDescription;

/* Set description as per defined in DatabaseDescritor.xml file */
- (void) setDescription : (NSString*) description;

/* Get database implementer class name as per defined in DatabaseDescriptor.core.xml file. */
- (NSString*) getDatabaseImplementer;

/* Set database implementer class name as per defined in DatabaseDescriptor.core.xml file */
- (void) setDatabaseImplementer : (NSString*) databaseImplementer;

/* Get password */
- (NSString*) llgetPassword;

/* Set password as per defined in DatabaseDescriptor.core.xml file */
- (void) setPassword : (NSString*) password;

/* Check whether database implementer class defined in DatabaseDescritor.xml file or not.*/
- (BOOL) isDatabaseImplementer;

/* Check whether database transactions to make multi-threading safe or not. */
- (BOOL) isLockingRequired;

/* Set database locking as per defined in DatabaseDescriptor.core.xml file */
- (void) setLockingRequired : (BOOL) isLockingRequired;

/* Check whether database mapping object exists or not, based on table name */
- (BOOL) containsDatabaseMappingBasedOnTableName :  (NSString*) tableName;

/* Check whether database mapping object exists or not, based on POJO class name. */
- (BOOL) containsDatabaseMappingBasedOnClassName : (NSString*) className;

/* Get all database mapping paths as per defined in DatabaseDescriptor.core.xml file */
- (NSArray*) getDatabaseMappingPaths;

/* Add database mapping path as per defined in DatabaseDescriptor.core.xml file.*/
- (void) addDatabaseMappingPath : (NSString*) databaseMappingPath;

/* Get all database mapping objects contained */
- (NSArray*) getDatabaseMappings;

/* Get database mapping object based on table name */
- (DatabaseMappingDescriptor*) getDatabseMappingBasedOnTableName :  (NSString*) tableName;

/* Get database mapping object based on POJO class name. */
- (DatabaseMappingDescriptor*) getDatabseMappingBasedOnClassName : (NSString*) className;

/* Get database mapping object based on path. */
- (DatabaseMappingDescriptor*) getDatabseMappingBasedOnPath : (NSString*) databaseMappingPath;

/* Add database mapping object in respect to database mapping path */
- (void) addDatabaseMapping : (NSString*) databaseMappingPath forDatabaseMapping :(DatabaseMappingDescriptor*) databaseMapping;

/* Remove database mapping object based on database mapping path */
- (void) removeDatabaseMappingBasedOnPath : (NSString*) databaseMappingPath;

/* Remove database mappping object based on POJO class name */
- (void) removeDatabaseMappingBasedOnClassName : (NSString*) className;

/* Remove database mapping object based on table name */
- (void) removeDatabaseMappingBasedOnTableName : (NSString*) tableName;

/* Remove database mapping object based on database mapping object */
- (void) removeDatabaseMapping : (DatabaseMappingDescriptor*) databaseMapping;

/* Get all database mapping objects in sorted order. The order will be as per defined in DatabaseDescriptor.core.xml file  */
- (NSArray*) orderedDatabaseMappings;

/* Check whether library exists or not based on library name provided */
- (BOOL) containsLibraryBasedOnName : (NSString*) libraryName;

/* Check whether library exists or not based on library path provided */
- (BOOL) containsLibraryBasedOnPath : (NSString*) libraryPath;

/* Get all library paths as per defined in DatabaseDescriptor.core.xml file */
- (NSArray*) getLibraryPaths;

/* Add library path as per defined in DatabaseDescriptor.core.xml file */
- (void) addLibraryPath : (NSString*) libraryPath;

/* Get all library descriptor paths contained */
- (NSArray*) getLibraryDescriptors;

/* Get all library descriptor objects in sorted order as per defined in DatabaseDescriptor.core.xml file */
- (NSArray*) orderedLibraryDescriptors;

/* Get library descriptor object based on library descriptor path */
- (LibraryDescriptor*) getLibraryDescriptorBasedOnPath: (NSString*) libraryPath;

/* Add library object in respect to library descriptor path */
- (void) addLibrary : (NSString*) libraryPath  forLibraryDescriptor : (LibraryDescriptor*) libraryDescriptor;

/* Remove library descriptor based on library path defined in DatabaseDescriptor.core.xml file */
- (void) removeLibraryBasedOnPath : (NSString*) libraryPath;

/* Remove library descriptor based on library name defined in LibraryDescriptor.core.xml file */
- (void) removeLibraryBasedOnName : (NSString*) libraryName;

/* Remove library descriptor object based on library descriptor object */
- (void) removeLibrary : (LibraryDescriptor*) removeLibraryDescriptor;

/* Check whether library is needed by Database Descriptor or not */
- (BOOL) isLibrariesNeeded;

@end
