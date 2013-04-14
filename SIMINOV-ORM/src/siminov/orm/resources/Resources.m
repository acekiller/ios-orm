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

#import "Resources.h"
#import "Siminov.h"
#import "DeploymentException.h"
#import "QuickDatabaseMappingParser.h"
#import "LibraryDescriptor.h"
#import <objc/runtime.h>

@interface Resources()

    @property (nonatomic, strong) ApplicationDescriptor* applicationDescriptor;

    @property (nonatomic, strong) NSMutableDictionary* databaseBasedOnDatabaseDescriptorName;
    @property (nonatomic, strong) NSMutableDictionary* databaseBasedOnDatabaseMappingClassName;
    @property (nonatomic, strong) NSMutableDictionary* databaseBasedOnDatabaseMappingTableName;

@end

static Resources* resources = nil;

@implementation Resources


+ (id)alloc
{
	@synchronized([Resources class])
	{
		NSAssert(resources == nil, @"Exception : Attempted to allocate a second instance of Resources class.");
		resources = [super alloc];
		return resources;
	}
    
	return nil;
}

- (id)init {
	self = [super init];
	if (self != nil) {
		self.applicationDescriptor = nil;
	}
    
	return self;
}


/**
 * It provides an instance of Resources class.
 *
 * @return Resources instance.
 */

+ (Resources*) getInstance
{
	@synchronized([Resources class])
	{
		if (!resources)
			resources = [[self alloc] init];
        
		return resources;
	}
    
	return nil;
}

/**
 * Get Application Descriptor object of application.
 */
- (ApplicationDescriptor*) getApplicationDescriptor {
    [Siminov validateSiminov];
    
    return self.applicationDescriptor;
}

/**
 * Set Application Descriptor of application.
 * @param applicationDescriptor Application Descriptor object.
 */
- (void) setApplicationDescriptor : (ApplicationDescriptor*) applicationDescriptor {
    [Siminov validateSiminov];
    
    self.applicationDescriptor = applicationDescriptor;
}

/**
 * Get iterator of all database descriptors provided in Application Descriptor file.
 <p>
 <pre>
 Example: ApplicationDescriptor.xml
 
 {@code
 <core>
 
 <database-descriptors>
 <database-descriptor>DatabaseDescriptor.si.xml</database-descriptor>
 </database-descriptors>
 
 </core>
 }
 
 </pre>
 </p>
 * @return Iterator which contains all database descriptor paths provided.
 */

- (NSArray*) getDatabaseDescriptorPaths {
    [Siminov validateSiminov];
    
    if(self.applicationDescriptor == nil) {
        @throw [[DeploymentException alloc] initWithClassName:[NSString stringWithUTF8String:class_getName([Resources class])] methodName : @"databaseDescriptorsPaths" message: @"Siminov Not Active, INVALID APPLICATION-DESCRIPTOR FOUND."];
    }
    
    return [self.applicationDescriptor getDatabaseDescriptorPaths];
}

/**
 * Get DatabaseDescriptor based on path provided as per defined in Application Descriptor file.
 <p>
 <pre>
 
 Example: ApplicationDescriptor.xml
 
 {@code
 <core>
 
 <database-descriptors>
 <database-descriptor>DatabaseDescriptor.xml</database-descriptor>
 </database-descriptors>
 
 </core>
 }
 
 </pre>
 </p>
 
 * @param databaseDescriptorPath Iterator which contains all database descriptor paths provided.
 * @return
 */
- (DatabaseDescriptor*) getDatabaseDescriptorBasedOnPath : (NSString*) databaseDescriptorPath {
    [Siminov validateSiminov];
    
    if(self.applicationDescriptor == nil) {
        @throw [[DeploymentException alloc] initWithClassName:[NSString stringWithUTF8String:class_getName([Resources class])] methodName : @"databaseDescriptorBasedOnPath" message: @"Siminov Not Active, INVALID APPLICATION-DESCRIPTOR FOUND."];
    }
    
    return [self.applicationDescriptor getDatabaseDescriptorBasedOnPath : databaseDescriptorPath];
}

/**
 * Get Database Descriptor based on database descriptor name provided as per defined in Database Descriptor file.
 <p>
 <pre>
 
 Example: DatabaseDescriptor.xml
 
 {@code
 <database-descriptor>
 
 <property name="database_name">SIMINOV-TEMPLATE</property>
 
 </database-descriptor>
 }
 
 </pre>
 </p>
 
 *
 * @param databaseDescriptorName Database Descriptor object based on database descriptor name provided.
 * @return
 */
- (DatabaseDescriptor*) getDatabaseDescriptorBasedOnName : (NSString*) databaseDescriptorName {
    [Siminov validateSiminov];
    
    if(self.applicationDescriptor == nil) {
        @throw [[DeploymentException alloc] initWithClassName:[NSString stringWithUTF8String:class_getName([Resources class])] methodName : @"getDatabaseDescriptorBasedOnName" message: @"Siminov Not Active, INVALID APPLICATION-DESCRIPTOR FOUND."];
    }
    
    return [self.applicationDescriptor getDatabaseDescriptorBasedOnName : databaseDescriptorName];
}

/**
 * Get all Database Descriptors object.
 * @return Iterator which contains all Database Descriptors.
 */
- (NSArray*) getDatabaseDescriptors {
    [Siminov validateSiminov];
    
    if(self.applicationDescriptor == nil) {
        @throw [[DeploymentException alloc] initWithClassName:[NSString stringWithUTF8String:class_getName([Resources class])] methodName : @"getDatabaseDescriptors" message: @"Siminov Not Active, INVALID APPLICATION-DESCRIPTOR FOUND."];
    }
    
    return [self.applicationDescriptor getDatabaseDescriptors];
}

/**
 * Get Database Descriptor based on POJO class name provided.
 *
 * @param className POJO class name.
 * @return Database Descriptor object in respect to POJO class name.
 */
- (DatabaseDescriptor*) getDatabaseDescriptorBasedOnClassName : (NSString*) className {
    [Siminov validateSiminov];
    
    if(self.applicationDescriptor == nil) {
        @throw [[DeploymentException alloc] initWithClassName:[NSString stringWithUTF8String:class_getName([Resources class])] methodName : @"getDatabaseDescriptorBasedOnClassName" message: @"Siminov Not Active, INVALID APPLICATION-DESCRIPTOR FOUND."];
    }
    
    NSArray* databaseDescriptors = [self.applicationDescriptor getDatabaseDescriptors];
    
    for(DatabaseDescriptor* databaseDescriptor in databaseDescriptors) {

        BOOL containsDatabaseMappingInDatabaseDescriptor = [databaseDescriptor containsDatabaseMappingBasedOnClassName : className];
        
        if(containsDatabaseMappingInDatabaseDescriptor) {
            return databaseDescriptor;
        }
        
        if(![databaseDescriptor isLibrariesNeeded]) {
            continue;
        }
        
        NSArray* libraries = [databaseDescriptor getLibraryDescriptors];
        
        for(LibraryDescriptor* libraryDescriptor in libraries) {

            if([libraryDescriptor containsDatabaseMappingBasedOnClassName : className]) {
                return databaseDescriptor;
            }
        }
    }
    
    return nil;
}

/**
 * Get Database Descriptor based on table name provided.
 *
 * @param tableName Name of table.
 * @return Database Descriptor object in respect to table name.
 */
- (DatabaseDescriptor*) getDatabaseDescriptorBasedOnTableName : (NSString*) tableName {
    [Siminov validateSiminov];
    
    if(self.applicationDescriptor == nil) {
        @throw [[DeploymentException alloc] initWithClassName:[NSString stringWithUTF8String:class_getName([Resources class])] methodName : @"getDatabaseDescriptorBasedOnTableName" message: @"Siminov Not Active, INVALID APPLICATION-DESCRIPTOR FOUND."];
    }
    
    NSArray* databaseDescriptors = [self.applicationDescriptor getDatabaseDescriptors];
    
    for(DatabaseDescriptor* databaseDescriptor in databaseDescriptors) {
        
        BOOL containsDatabaseMappingInDatabaseDescriptor = [databaseDescriptor containsDatabaseMappingBasedOnTableName : tableName];
        
        if(containsDatabaseMappingInDatabaseDescriptor) {
            return databaseDescriptor;
        }
        
        if(![databaseDescriptor isLibrariesNeeded]) {
            continue;
        }
        
        NSArray* libraries = [databaseDescriptor getLibraryDescriptors];
        
        for(LibraryDescriptor* libraryDescriptor in libraries) {
            
            if([libraryDescriptor containsDatabaseMappingBasedOnTableName : tableName]) {
                return databaseDescriptor;
            }
        }
    }
    
    return nil;
}



/**
 * Get Database Mapping based on POJO class name provided.
 *
 * @param className POJO class name.
 * @return Database Mapping object in respect to POJO class name.
 */
- (DatabaseMappingDescriptor*) getDatabaseMappingDescriptorBasedOnClassName : (NSString*) className {
    [Siminov validateSiminov];
    
    if(self.applicationDescriptor == nil) {
        @throw [[DeploymentException alloc] initWithClassName:[NSString stringWithUTF8String:class_getName([Resources class])] methodName : @"getDatabaseMappingDescriptorBasedOnClassName" message: @"Siminov Not Active, INVALID APPLICATION-DESCRIPTOR FOUND."];
    }
    
    NSArray* databaseDescriptors = [self.applicationDescriptor getDatabaseDescriptors];
    
    for(DatabaseDescriptor* databaseDescriptor in databaseDescriptors) {
        
        BOOL containsDatabaseMappingInDatabaseDescriptor = [databaseDescriptor containsDatabaseMappingBasedOnClassName : className];
        
        if(containsDatabaseMappingInDatabaseDescriptor) {
            return [databaseDescriptor getDatabseMappingBasedOnClassName : className];
        }
        
        if(![databaseDescriptor isLibrariesNeeded]) {
            continue;
        }
        
        NSArray* libraries = [databaseDescriptor getLibraryDescriptors];
        
        for(LibraryDescriptor* libraryDescriptor in libraries) {
            
            if([libraryDescriptor containsDatabaseMappingBasedOnClassName : className]) {
                return [libraryDescriptor getDatabseMappingBasedOnClassName : className];
            }
        }
    }
    
    return nil;
}

/**
 * Get Database Mapping based on table name provided.
 *
 * @param tableName Name of table.
 * @return Database Descriptor object in respect to table name.
 */
- (DatabaseMappingDescriptor*) getDatabaseMappingDescriptorBasedOnTableName : (NSString*) tableName {
    [Siminov validateSiminov];
    
    if(self.applicationDescriptor == nil) {
        @throw [[DeploymentException alloc] initWithClassName:[NSString stringWithUTF8String:class_getName([Resources class])] methodName : @"getDatabaseMappingDescriptorBasedOnTableName" message: @"Siminov Not Active, INVALID APPLICATION-DESCRIPTOR FOUND."];
    }
    
    NSArray* databaseDescriptors = [self.applicationDescriptor getDatabaseDescriptors];
    
    for(DatabaseDescriptor* databaseDescriptor in databaseDescriptors) {
        
        BOOL containsDatabaseMappingInDatabaseDescriptor = [databaseDescriptor containsDatabaseMappingBasedOnTableName : tableName];
        
        if(containsDatabaseMappingInDatabaseDescriptor) {
            return [databaseDescriptor getDatabseMappingBasedOnTableName : tableName];
        }
        
        if(![databaseDescriptor isLibrariesNeeded]) {
            continue;
        }
        
        NSArray* libraries = [databaseDescriptor getLibraryDescriptors];
        
        for(LibraryDescriptor* libraryDescriptor in libraries) {
            
            if([libraryDescriptor containsDatabaseMappingBasedOnClassName : tableName]) {
                return [libraryDescriptor getDatabseMappingBasedOnTableName : tableName];
            }
        }
    }
    
    return nil;
}

- (NSArray*) getDatabaseMappingDescriptors {
    [Siminov validateSiminov];
    
    NSMutableArray* databaseMappingDescriptors = [NSMutableArray new];
    NSArray* databaseDescriptors = [self.applicationDescriptor getDatabaseDescriptors];
	
    for(DatabaseDescriptor* databaseDescriptor in databaseDescriptors) {
        
        NSArray* databaseMappings = [databaseDescriptor getDatabaseMappings];
        NSArray* libraryDescriptors = [databaseDescriptor getLibraryDescriptors];
        
        for(DatabaseMappingDescriptor* databaseMappingDescriptor in databaseMappings) {
            [databaseMappingDescriptors addObject:databaseMappingDescriptor];
        }
        
        for(LibraryDescriptor* libraryDescriptor in libraryDescriptors) {

            NSArray* libraryDatabaseMappingDescriptors = [libraryDescriptor getDatabseMappings];
            
            for(DatabaseMappingDescriptor* libraryDatabaseMappingDescriptor in libraryDatabaseMappingDescriptors) {
                [databaseMappingDescriptors addObject:libraryDatabaseMappingDescriptor];
            }
        }
        
    }
    
    return databaseMappingDescriptors;
}

/**
 * Get database mapping descriptor Object based on class name provided. If database mapping descriptor object not present in resource layer, it will parse DatabaseMappingDescriptor.si.xml file defined by application and will place it in resource layer.
 * @param className Full name of class.
 * @return DatabaseMappingDescriptor object.
 * @throws SiminovException If any exception occur while getting database mapping descriptor object.
 */
- (DatabaseMappingDescriptor*) requiredDatabaseMappingDescriptorBasedOnClassName : (NSString*) className error:(SiminovException**)err {
    
    DatabaseMappingDescriptor* databaseMapping = [self getDatabaseMappingDescriptorBasedOnClassName : className];
    
    if(databaseMapping == nil) {
        NSLog(@"%s : requiredDatabaseMappingDescriptorBasedOnClassName( %@ )Database Mapping Model Not registered With Siminov, MODEL: %@", class_getName([self class]), className, className);
        
        QuickDatabaseMappingParser* quickDatabaseMappingParser = [[QuickDatabaseMappingParser alloc] initWithClassName:className];
        SiminovException* error = nil;
        
        BOOL success = [quickDatabaseMappingParser processWithError:&error];
        if (success == NO) {
            NSString* errMsg = [NSString stringWithFormat:@"%s : requiredDatabaseMappingDescriptorBasedOnClassName( %@ ), SiminovException caught while doing quick database mapping parsing, DATABASE-MAPPING-CLASS-NAME: %@, %@", class_getName([self class]), className, className, [error localizedDescription]];
            
            NSLog(@"%@", errMsg);
            
            SiminovException* siminovException = [[SiminovException alloc] initWithClassName:[NSString stringWithUTF8String:class_getName([Resources class])] methodName:[NSString stringWithFormat:@"requiredDatabaseMappingDescriptorBasedOnClassName( %@", className] message:[NSString stringWithFormat:@"SiminovException caught while doing quick database mapping parsing, DATABASE-MAPPING-CLASS-NAME: %@, %@", className, [error localizedDescription]]];

            NSMutableDictionary* details = [NSMutableDictionary dictionary];
            [details setValue:siminovException forKey:NSLocalizedDescriptionKey];
            *err = [SiminovException errorWithDomain:@"com.siminov.orm" code:200 userInfo:details];
            
        }
        
        DatabaseMappingDescriptor* foundDatabaseMapping = [quickDatabaseMappingParser getDatabaseMapping];
        if(foundDatabaseMapping == nil) {
            NSString* errMsg = [NSString stringWithFormat:@"%s : requiredDatabaseMappingDescriptorBasedOnClassName( %@ )Database Mapping Model Not registered With Siminov, DATABASE-MAPPING-MODEL: %@", class_getName([self class]), className, className];

            NSLog(@"%@", errMsg);
            
            SiminovException* siminovException = [[SiminovException alloc] initWithClassName:[NSString stringWithUTF8String:class_getName([Resources class])] methodName:[NSString stringWithFormat:@"requiredDatabaseMappingDescriptorBasedOnClassName( %@", className] message:[NSString stringWithFormat:@"Database Mapping Model Not registered With Siminov, DATABASE-MAPPING-MODEL: %@", className]];

            
            NSMutableDictionary* details = [NSMutableDictionary dictionary];
            [details setValue:siminovException forKey:NSLocalizedDescriptionKey];
            *err = [NSError errorWithDomain:@"com.siminov.orm" code:200 userInfo:details];
        }
        
        return foundDatabaseMapping;
    }
    
    return databaseMapping;
}



/**
 * Get all Library Paths as per defined in all Database Descriptor file's.
 * @return Iterator which contains all library paths defined in all Database Descriptor file's.
 */
- (NSArray*) getLibraryPaths {
    [Siminov validateSiminov];
    
    if(self.applicationDescriptor == nil) {

        DeploymentException* deploymentException = [[DeploymentException alloc] initWithClassName:[NSString stringWithUTF8String:class_getName([Resources class])] methodName:@"getLibraryPaths" message:@"Siminov Not Active, INVALID APPLICATION-DESCRIPTOR FOUND"];
        
        [deploymentException raise];
        
    }

    NSMutableArray* libraries = [NSMutableArray new];
    NSArray* databaseDescriptors = self.applicationDescriptor.getDatabaseDescriptors;
    
    for(DatabaseDescriptor* databaseDescriptor in databaseDescriptors) {

        if([databaseDescriptor isLibrariesNeeded] == NO) {
            continue;
        }
        
        NSArray* thisDatabaseDescriptorLibraries = databaseDescriptor.getLibraryPaths;
        [libraries addObjectsFromArray:thisDatabaseDescriptorLibraries];

    }
    
    return libraries;
}

/**
 * Get all Library Descriptor objects based on Database Descriptor name.
 * @param databaseDescriptorName Name of Database Descriptor.
 * @return Iterator which contains all Library Descriptor objects based on Database Descriptor name.
 */
- (NSArray*) getLibrariesBasedOnDatabaseDescriptorName : (NSString*) databaseDescriptorName {
    [Siminov validateSiminov];
    
    if(self.applicationDescriptor == nil) {
        
        DeploymentException* deploymentException = [[DeploymentException alloc] initWithClassName:[NSString stringWithUTF8String:class_getName([Resources class])] methodName:@"getLibrariesBasedOnDatabaseDescriptorName" message:@"Siminov Not Active, INVALID APPLICATION-DESCRIPTOR FOUND"];
        
        [deploymentException raise];

    }
    
    DatabaseDescriptor* databaseDescriptor = [self.applicationDescriptor getDatabaseDescriptorBasedOnName : databaseDescriptorName];
    if(databaseDescriptor == nil) {

        DeploymentException* deploymentException = [[DeploymentException alloc] initWithClassName:[NSString stringWithUTF8String:class_getName([Resources class])] methodName:@"getLibrariesBasedOnDatabaseDescriptorName" message:@"Siminov Not Active, INVALID APPLICATION-DESCRIPTOR FOUND"];
        
        [deploymentException raise];
    }
    
    if([databaseDescriptor isLibrariesNeeded] == NO) {
        return [NSArray new];
    }
    
    return [databaseDescriptor getLibraryDescriptors];
}

/**
 * Get all Library Database Mapping objects based in library descriptor path.
 * @param libraryPath Library Descriptor path.
 * @return
 */
- (NSArray*) getLibraryDatabaseMappingDescriptorsBasedOnLibraryDescriptorPath : (NSString*) libraryPath {
    [Siminov validateSiminov];
    
    if(self.applicationDescriptor == nil) {

        DeploymentException* deploymentException = [[DeploymentException alloc] initWithClassName:[NSString stringWithUTF8String:class_getName([Resources class])] methodName:@"getLibraryDatabaseMappingsBasedOnLibraryDescriptorPath" message:@"Siminov Not Active, INVALID APPLICATION-DESCRIPTOR FOUND"];
        
        [deploymentException raise];
    }
    
    NSArray* databaseDescriptors = [self.applicationDescriptor getDatabaseDescriptors];
    for(DatabaseDescriptor* databaseDescriptor in databaseDescriptors) {

        if(![databaseDescriptor containsLibraryBasedOnPath : libraryPath]) {
            continue;
        }
        
        return [[databaseDescriptor getLibraryDescriptorBasedOnPath : libraryPath] getDatabseMappings];
    }
    
    return [NSArray new];
}

/**
 * Get IDatabase object based on Database Descriptor name.
 * @param databaseName Name of Database Descriptor.
 * @return IDatabase object.
 */
- (IDatabase*) getDatabaseBasedOnDatabaseDescriptorName : (NSString*) databaseName {
    [Siminov validateSiminov];
    
    return [self.databaseBasedOnDatabaseDescriptorName valueForKey:databaseName];
}

/**
 * Get IDatabase object based on Database Mapping POJO class name.
 * @param classObject POJO class object.
 * @return IDatabase object.
 */
- (IDatabase*) getDatabaseBasedOnDatabaseMappingDescriptorPojoClass : (id) classObject {
    [Siminov validateSiminov];
    
    return [self.databaseBasedOnDatabaseMappingClassName valueForKey: [classObject name]] ;
}

/**
 * Get IDatabase based on Database Mapping POJO class name.
 * @param databaseMappingClassName POJO class name.
 * @return IDatabase object.
 */
- (IDatabase*) getDatabaseBasedOnDatabaseMappingDescriptorClassName : (NSString*) databaseMappingClassName {
    [Siminov validateSiminov];
    
    return [self.databaseBasedOnDatabaseMappingClassName valueForKey:databaseMappingClassName];
}

/**
 * Get IDatabase object based on Database Mapping table name.
 * @param databaseMappingTableName Database Mapping table name.
 * @return IDatabase object.
 */
- (IDatabase*) getDatabaseBasedOnDatabaseMappingDescriptorTableName : (NSString*) databaseMappingTableName {
    [Siminov validateSiminov];
    
    return [self.databaseBasedOnDatabaseMappingTableName valueForKey:databaseMappingTableName];
}

/**
 * Get all IDatabase objects contain by application.
 * @return Iterator which contains all IDatabase objects.
 */
- (NSArray*) getDatabases {
    [Siminov validateSiminov];
    
    return [self.databaseBasedOnDatabaseDescriptorName allValues];
}

/**
 * Add IDatabase object in respect to Database Descriptor name.
 * @param databaseDescriptorName Database Descriptor name.
 * @param database IDatabase object.
 */
- (void) addDatabase : (NSString*) databaseDescriptorName forDatabase : (IDatabase*) database {
    [Siminov validateSiminov];
    
    DatabaseDescriptor* databaseDescriptor = [self getDatabaseDescriptorBasedOnName : databaseDescriptorName];
    if(databaseDescriptor == nil) {
        
        DeploymentException* deploymentException = [[DeploymentException alloc] initWithClassName:[NSString stringWithUTF8String:class_getName([Resources class])] methodName:@"addDatabase" message:@"Siminov Not Active, INVALID APPLICATION-DESCRIPTOR FOUND"];
        
        [deploymentException raise];
    }
    
    NSArray* databaseMappings = [databaseDescriptor getDatabaseMappings];
    for(DatabaseMappingDescriptor* databaseMapping in databaseMappings) {
        
        [self.databaseBasedOnDatabaseMappingClassName setValue:databaseMapping forKey:[databaseMapping getClassName]];
        [self.databaseBasedOnDatabaseMappingTableName setValue:databaseMapping forKey:[databaseMapping getTableName]];
    }
    
    NSArray* libraryDescriptors = [databaseDescriptor getLibraryDescriptors];
    for(LibraryDescriptor* libraryDescriptor in libraryDescriptors) {
        
        NSArray* libraryDatabaseMappings = [libraryDescriptor getDatabseMappings];
        for(DatabaseMappingDescriptor* libraryDatabaseMapping in libraryDatabaseMappings) {
            
            [self.databaseBasedOnDatabaseMappingClassName setValue:database forKey:[libraryDatabaseMapping getClassName]];
            [self.databaseBasedOnDatabaseMappingTableName setValue:database forKey: [libraryDatabaseMapping getTableName]];
        }
    }
    
    [self.databaseBasedOnDatabaseDescriptorName setValue:database forKey:databaseDescriptorName];
}

/**
 * Remove IDatabase object from Resources.
 * @param database IDatabase object which needs to be removed.
 */
- (void) removeDatabase : (IDatabase*) database {
    
    NSArray* keysClass = [self.databaseBasedOnDatabaseMappingClassName allKeysForObject:database];
    [self.databaseBasedOnDatabaseMappingClassName removeObjectsForKeys:keysClass];

    NSArray* keysTable = [self.databaseBasedOnDatabaseMappingTableName allKeysForObject:database];
    [self.databaseBasedOnDatabaseMappingTableName removeObjectsForKeys:keysTable];

    NSArray* keysName = [self.databaseBasedOnDatabaseDescriptorName allKeysForObject:database];
    [self.databaseBasedOnDatabaseDescriptorName removeObjectsForKeys:keysName];
    
}

/**
 * Remove IDatabase object from Resources based on Database Descriptor name.
 * @param databaseName Database Descriptor name.
 */
- (void) removeDatabaseBasedOnDatabaseDescriptorName : (NSString*) databaseName {

    [self removeDatabase : [self.databaseBasedOnDatabaseDescriptorName objectForKey:databaseName]];
}

/**
 * Remove IDatabase object from Resources based on Database Mapping POJO class name.
 * @param className POJO class name
 */
- (void) removeDatabaseBasedOnDatabaseMappingDescriptorClassName : (NSString*) className {
    [self removeDatabase : [self.databaseBasedOnDatabaseMappingClassName objectForKey:className]];
}

/**
 * Remove IDatabase object from Resources based on Database Mapping table name.
 * @param tableName Name of table.
 */
- (void) removeDatabaseBasedOnDatabaseMappingDescriptorTableName : (NSString*) tableName {
    [self removeDatabase : [self.databaseBasedOnDatabaseMappingTableName objectForKey:tableName]];
}

/**
 * It used to synchronize IDatabase objects to its mapping.
 * <p>
 * It is used when SIMINOV is in lazy load mode.
 */
- (void) synchronizeDatabases {
    [Siminov validateSiminov];
    
    NSArray* databaseNames = [self.databaseBasedOnDatabaseDescriptorName allKeys];
    
    for(NSString* databaseName in databaseNames) {
        
        IDatabase* database = [self getDatabaseBasedOnDatabaseDescriptorName : databaseName];
        DatabaseDescriptor* databaseDescriptor = [self getDatabaseDescriptorBasedOnName : databaseName];
        if(databaseDescriptor == nil) {
            
            DeploymentException* deploymentException = [[DeploymentException alloc] initWithClassName:[NSString stringWithUTF8String:class_getName([Resources class])] methodName:@"synchronizeDatabase" message:@"Siminov Not Active, INVALID DATABASE-DESCRIPTOR FOUND"];
            
            [deploymentException raise];

        }
        
        NSArray* databaseMappings = [databaseDescriptor getDatabaseMappings];
        for(DatabaseMappingDescriptor* databaseMapping in databaseMappings) {
            
            [self.databaseBasedOnDatabaseMappingClassName setValue:database forKey:[databaseMapping getClassName]];
            [self.databaseBasedOnDatabaseMappingTableName setValue:database forKey:[databaseMapping getTableName]];
        }
        
        NSArray* libraryDescriptors = [databaseDescriptor getLibraryDescriptors];
        for(LibraryDescriptor* libraryDescriptor in libraryDescriptors) {
            
            NSArray* libraryDatabaseMappings = [libraryDescriptor getDatabseMappings];
            for(DatabaseMappingDescriptor* libraryDatabaseMapping in libraryDatabaseMappings) {
                
                [self.databaseBasedOnDatabaseMappingClassName setValue:database forKey:[libraryDatabaseMapping getClassName]];
                [self.databaseBasedOnDatabaseMappingTableName setValue:database forKey:[libraryDatabaseMapping getTableName]];
            }
        }
    }
}

/**
 * Get SIMINOV-EVENT Handler
 * @return ISiminovEvents implementation object as per defined by application.
 */
- (ISiminovEvents*) getSiminovEventHandler {
    return [[EventHandler getInstance] getSiminovEventHandler];
}

/**
 * Get DATABASE-EVENT Handler
 * @return IDatabaseEvents implementation object as per defined by application.
 */
- (IDatabaseEvents*) getDatabaseEventHandler {
    return [[EventHandler getInstance] getDatabaseEventHandler];
}


@end
