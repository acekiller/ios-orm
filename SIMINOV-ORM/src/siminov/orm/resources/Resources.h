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
#import "ApplicationDescriptor.h"
#import "SiminovException.h"
#import "SiminovCriticalException.h"
#import "IDatabase.h"
#import "ISiminovEvents.h"
#import "EventHandler.h"

@interface Resources : NSObject

/* It provides an instance of Resources class */
+ (Resources*) getInstance;

/* Get Application Descriptor object of application */
- (ApplicationDescriptor*) getApplicationDescriptor;

/* Set Application Descriptor of application */
- (void) setApplicationDescriptor : (ApplicationDescriptor*) applicationDescriptor;

/* Get iterator of all database descriptors provided in Application Descriptor file. */
- (NSArray*) getDatabaseDescriptorPaths;

/* Get DatabaseDescriptor based on path provided as per defined in Application Descriptor file. */
- (DatabaseDescriptor*) getDatabaseDescriptorBasedOnPath : (NSString*) databaseDescriptorPath;

/* Get DatabaseDescriptor based on name provided as per defined in Application Descriptor file. */
- (DatabaseDescriptor*) getDatabaseDescriptorBasedOnName : (NSString*) databaseDescriptorName;

/* Get all Database Descriptors object. */
- (NSArray*) getDatabaseDescriptors;

/* Get Database Descriptor based on table name provided */
- (DatabaseDescriptor*) getDatabaseDescriptorBasedOnTableName : (NSString*) tableName;

/* Get Database Mapping based on class name provided. */
- (DatabaseMappingDescriptor*) getDatabaseMappingDescriptorBasedOnClassName : (NSString*) className;

/* Get Database Mapping based on POJO table name provided. */
- (DatabaseMappingDescriptor*) getDatabaseMappingDescriptorBasedOnTableName : (NSString*) tableName;

/* Get Database Mapping descriptors */
- (NSArray*) getDatabaseMappingDescriptors;

/* Get database mapping descriptor Object based on class name provided. If database mapping descriptor object not present in resource layer, it will parse DatabaseMappingDescriptor.si.xml file defined by application and will place it in resource layer. */
- (DatabaseMappingDescriptor*) requiredDatabaseMappingDescriptorBasedOnClassName : (NSString*) className error:(SiminovException**)err;

/* Get all Library Paths as per defined in all Database Descriptor file's */
- (NSArray*) getLibraryPaths;

/* Get all Library Descriptor objects based on Database Descriptor name */
- (NSArray*) getLibrariesBasedOnDatabaseDescriptorName : (NSString*) databaseDescriptorName;

/* Get all Library Database Mapping objects based in library descriptor path */
- (NSArray*) getLibraryDatabaseMappingDescriptorsBasedOnLibraryDescriptorPath : (NSString*) libraryPath;

/* Get IDatabase object based on Database Descriptor name. */
- (IDatabase*) getDatabaseBasedOnDatabaseDescriptorName : (NSString*) databaseName;
@end
