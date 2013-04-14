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


#import "LibraryDescriptor.h"


/**
 * Exposes methods to GET and SET Library Descriptor information as per define in LibraryDescriptor.core.xml file by application.
 <p>
 <pre>
 
 Example:
 {@code
 <library>
 
 <property name="name">CORE LIBRARY TEMPLATE</property>
 <property name="description">Core Library Template</property>
 
 <!-- Database Mappings -->
 <database-mappings>
 <database-mapping path="Credential.core.xml" />
 </database-mappings>
 
 <!-- OR -->
 
 <database-mappings>
 <database-mapping path="com.core.library.template.model.Credential" />
 </database-mappings>
 
 </library>
 }
 
 </pre>
 </p>
 *
 */
@interface LibraryDescriptor()

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* descriptor;

@property (nonatomic, strong) NSMutableArray* databaseMappingPaths;

@property (nonatomic, strong) NSMutableDictionary* databaseMappingsBasedOnTableName;
@property (nonatomic, strong) NSMutableDictionary* databaseMappingsBasedOnClassName;
@property (nonatomic, strong) NSMutableDictionary* databaseMappingsBasedOnPath;

@end


@implementation LibraryDescriptor

@synthesize name = _name;
@synthesize descriptor = _descriptor;
@synthesize databaseMappingPaths = _databaseMappingPaths;
@synthesize databaseMappingsBasedOnTableName = _databaseMappingsBasedOnTableName;
@synthesize databaseMappingsBasedOnClassName = _databaseMappingsBasedOnClassName;
@synthesize databaseMappingsBasedOnPath = _databaseMappingsBasedOnPath;


	/**
	 * Get library name.
	 * @return
	 */
- (NSString*) name {
    return self.name;
}

	/**
	 * Set library name as per defined in LibraryDescriptor.core.xml
	 * @param name
	 */
- (void) setName : (NSString*) name {
    self.name = [name copy];
}

	/**
	 * Get descriptor as per defined in LibraryDescriptor.core.xml
	 * @return
	 */
- (NSString*) getDescriptor {
    return self.descriptor;
}

	/**
	 * Set description as per defined in LibraryDescritor.core.xml
	 * @param descriptor
	 */
- (void) setDescriptor : (NSString*) descriptor {
    self.descriptor = [descriptor copy];
}

    
/**
 * Check whether database mapping object exists or not, based on table name.
 * @param tableName Name of table.
 * @return TRUE: If database mapping exists, FALSE: If database mapping does not exists.
 */
- (BOOL) containsDatabaseMappingBasedOnTableName : (NSString*) tableName {
    return ([self.databaseMappingsBasedOnTableName objectForKey:tableName] != NULL);
}

/**
 * Check whether database mapping object exists or not, based on POJO class name.
 * @param className POJO class name.
 * @return TRUE: If database mapping exists, FALSE: If database mapping does not exists.
 */
- (BOOL) containsDatabaseMappingBasedOnClassName : (NSString*) className {
    return ([self.databaseMappingsBasedOnClassName objectForKey:className] != NULL);
}

/**
 * Get all database mapping paths as per defined in DatabaseDescriptor.core.xml file.
 * @return Iterator which contain all database mapping paths.
 */
- (NSArray*) getDatabaseMappingPaths {
    return self.databaseMappingPaths;
}

/**
 * Add database mapping path as per defined in DatabaseDescriptor.core.xml file.
 <p>
 <pre>
 
 EXAMPLE:
 {@code
 <database-descriptor>
 <database-mappings>
 <database-mapping path="Liquor-Mappings/Liquor.xml" />
 <database-mapping path="Liquor-Mappings/LiquorBrand.xml" />
 </database-mappings>
 </database-descriptor>
 }
 
 </pre>
 </p>
 
 * @param databaseMappingPath Database Mapping Path.
 */
- (void) addDatabaseMappingPath : (NSString*) databaseMappingPath {
    [self.databaseMappingPaths addObject:databaseMappingPath];
}

/**
 * Get all database mapping objects contained.
 * @return All database mapping objects.
 */
- (NSArray*) getDatabseMappings {
    return [self.databaseMappingsBasedOnClassName allValues];
}

/**
 * Get database mapping object based on table name.
 * @param tableName Name of table.
 * @return DatabaseMapping object based on table name.
 */
- (DatabaseMappingDescriptor*) getDatabseMappingBasedOnTableName : (NSString*) tableName {
    return [self.databaseMappingsBasedOnTableName objectForKey:tableName];
}

/**
 * Get database mapping object based on POJO class name.
 * @param className POJO class name.
 * @return Database Mapping object.
 */
- (DatabaseMappingDescriptor*) getDatabseMappingBasedOnClassName : (NSString*) className {
    return [self.databaseMappingsBasedOnClassName objectForKey:className];
}

/**
 * Get database mapping object based on path.
 * @param databaseMappingPath Database Mapping path as per defined in Database Descriptor.xml file.
 * @return Database Mapping object.
 */
- (DatabaseMappingDescriptor*) getDatabseMappingBasedOnPath : (NSString*) libraryDatabaseMappingPath {
    return [self.databaseMappingsBasedOnPath objectForKey:libraryDatabaseMappingPath];
}

/**
 * Add database mapping object in respect to database mapping path.
 * @param databaseMappingPath Database Mapping Path.
 * @param databaseMapping Database Mapping object.
 */
- (void) addDatabaseMapping : (NSString*) libraryDatabaseMappingPath forDatabaseMapping : (DatabaseMappingDescriptor*) databaseMapping {
    [self.databaseMappingsBasedOnPath setObject:databaseMapping forKey:libraryDatabaseMappingPath];
    [self.databaseMappingsBasedOnTableName setObject:databaseMapping forKey:databaseMapping.getTableName];
    [self.databaseMappingsBasedOnClassName setObject:databaseMapping forKey:databaseMapping.getClassName];
}

/**
 * Remove database mapping object based on database mapping path.
 * @param databaseMappingPath Database Mapping Path.
 */
- (void) removeDatabaseMappingBasedOnPath : (NSString*) databaseMappingPath {
    [self.databaseMappingPaths removeObject:databaseMappingPath];
    
    DatabaseMappingDescriptor* databaseMapping = [self.databaseMappingsBasedOnPath objectForKey:databaseMappingPath];
    [self.databaseMappingsBasedOnPath removeObjectForKey:databaseMappingPath];
    
    /*(for DatabaseMappingDescriptor* dmd in [self.databaseMappingsBasedOnClassName allValues]) {
        if (dmd == databaseMapping)
            
    }*/
    //self.databaseMappingsBasedOnClassName.values().remove(databaseMapping);
    //self.databaseMappingsBasedOnTableName.values().remove(databaseMapping);
}

/**
 * Remove database mappping object based on POJO class name.
 * @param className POJO class name.
 */
- (void) removeDatabaseMappingBasedOnClassName : (NSString*) className {
    DatabaseMappingDescriptor* databaseMapping = [self.databaseMappingsBasedOnClassName objectForKey:className];
    NSArray* keys = [self.databaseMappingsBasedOnPath allKeys];
    
    NSString* keyMatched = nil;
    BOOL found = false;
    
    for(NSString* key in keys) {
        DatabaseMappingDescriptor* mapping = [self.databaseMappingsBasedOnPath objectForKey:key];
        if(databaseMapping == mapping) {
            keyMatched = key;
            found = true;
            break;
        }
    }
    
    if(found) {
        [self removeDatabaseMappingBasedOnPath : keyMatched];
    }
}

/**
 * Remove database mapping object based on table name.
 * @param tableName Name of table.
 */
- (void) removeDatabaseMappingBasedOnTableName : (NSString*) tableName {
    DatabaseMappingDescriptor* databaseMapping = [self.databaseMappingsBasedOnTableName objectForKey:tableName];
    [self removeDatabaseMappingBasedOnClassName : databaseMapping.getClassName];
}

/**
 * Remove database mapping object based on database mapping object.
 * @param databaseMapping Database Mapping object which needs to be removed.
 */
- (void) removeDatabaseMapping : (DatabaseMappingDescriptor*) databaseMapping {
    [self removeDatabaseMappingBasedOnClassName : databaseMapping.getClassName];
}

/**
 * Get all database mapping objects in sorted order. The order will be as per defined in DatabaseDescriptor.core.xml file.
 * @return Iterator which contains all database mapping objects.
 */
- (NSArray*) orderedDatabaseMappings {
    NSMutableArray* orderedDatabaseMappings = [NSMutableArray new];
    
    for(NSString* databaseMappingPath in self.databaseMappingPaths) {
        [orderedDatabaseMappings addObject: [self getDatabseMappingBasedOnPath : databaseMappingPath]];
    }
    
    return orderedDatabaseMappings;
}
    

@end