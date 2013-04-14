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

/**
 * Exposes methods to GET and SET Database Descriptor information as per define in DatabaseDescriptor.core.xml file by application.
 <p>
 <pre>
 
 Example:
 {@code
 
 <database-descriptor>
 
 <property name="database_name">CORE-TEMPLATE</property>
 <property name="description">Core Template Database Config</property>
 <property name="is_locking_required">true</property>
 <property name="external_storage">false</property>
 <property name="database_implementer"></property>
 <property name="password"></property>
 
 <!-- Database Mappings -->
 <database-mappings>
 <database-mapping path="Liquor-Mappings/Liquor.core.xml" />
 <database-mapping path="Liquor-Mappings/LiquorBrand.core.xml" />
 </database-mappings>
 
 <!-- OR -->
 
 <database-mappings>
 <database-mapping path="com.core.template.model.Liquor" />
 <database-mapping path="com.core.template.model.LiquorBrand" />
 </database-mappings>
 
 
 <!-- Libraries -->
 <libraries>
 <library>com.core.library.template.resources</library>
 </libraries>
 
 </database-descriptor>
 
 }
 
 </pre>
 </p>
 */


#import "DatabaseDescriptor.h"

@interface DatabaseDescriptor()

@property (nonatomic, strong) NSString* databaseName;
@property (nonatomic, strong) NSString* description;

@property (nonatomic, strong) NSString* databaseImplementer;
@property (nonatomic, strong) NSString* password;

@property (nonatomic) BOOL isLockingRequired;

@property (nonatomic, strong) NSMutableArray* databaseMappingPaths;
@property (nonatomic, strong) NSMutableArray*  libraryPaths;

@property (nonatomic, strong) NSMutableDictionary* databaseMappingsBasedOnTableName;
@property (nonatomic, strong) NSMutableDictionary* databaseMappingsBasedOnClassName;
@property (nonatomic, strong) NSMutableDictionary* databaseMappingsBasedOnPath;

@property (nonatomic, strong) NSMutableDictionary* libraryDescriptorsBasedOnName;
@property (nonatomic, strong) NSMutableDictionary* libraryDescriptorsBasedOnPath;


@end

@implementation DatabaseDescriptor

@synthesize databaseName = _databaseName;
@synthesize description = _description;
@synthesize databaseImplementer = _databaseImplementer;
@synthesize password = _password;
@synthesize isLockingRequired = _isLockingRequired;
@synthesize databaseMappingPaths = _databaseMappingPaths;
@synthesize libraryPaths = _libraryPaths;
@synthesize databaseMappingsBasedOnTableName = _databaseMappingsBasedOnTableName;
@synthesize databaseMappingsBasedOnClassName = _databaseMappingsBasedOnClassName;
@synthesize databaseMappingsBasedOnPath = _databaseMappingsBasedOnPath;
@synthesize libraryDescriptorsBasedOnName = _libraryDescriptorsBasedOnName;
@synthesize libraryDescriptorsBasedOnPath = _libraryDescriptorsBasedOnPath;

/**
 * Get database descriptor name as defined in DatabaseDescriptor.core.xml file.
 * @return Database Descriptor Name.
 */
- (NSString*) getDatabaseName {
    return self.databaseName;
}

/**
 * Set database descriptor name as per defined in DatabaseDescriptor.core.xml file.
 * @param databaseName Database Descriptor Name.
 */
- (void) setDatabaseName : (NSString*) databaseName {
    self.databaseName = databaseName;
}

/**
 * Get description as per defined in DatabaseDescriptor.core.xml file.
 * @return Description defined in DatabaseDescriptor.core.xml file.
 */
- (NSString*) getDescription {
    return self.description;
}

/**
 * Set description as per defined in DatabaseDescritor.xml file.
 * @param description Description defined in DatabaseDescriptor.core.xml file.
 */
- (void) setDescription : (NSString*) description {
    self.description = description;
}

/**
 * Get database implementer class name as per defined in DatabaseDescriptor.core.xml file.
 * @return Database Implementer Class Name.
 */
- (NSString*) getDatabaseImplementer {
    return self.databaseImplementer;
}

/**
 * Set database implementer class name as per defined in DatabaseDescriptor.core.xml file.
 * @param databaseImplementer Database Implementer Class Name.
 */
- (void) setDatabaseImplementer : (NSString*) databaseImplementer {
    self.databaseImplementer = databaseImplementer;
}

/**
 * Get password.
 * @return Password.
 */
- (NSString*) llgetPassword {
    return self.password;
}

/**
 * Set password as per defined in DatabaseDescriptor.core.xml file.
 * @param password
 */
- (void) setPassword : (NSString*) password {
    self.password = password;
}

/**
 * Check whether database implementer class defined in DatabaseDescritor.xml file or not.
 * @return TRUE: If database implementer class define in DatabaseDescriptor.core.xml file, FALSE: If database implementer class not defined in DatabaseDescriptor.core.xml file.
 */
- (BOOL) isDatabaseImplementer {
    if(self.databaseImplementer == nil || self.databaseImplementer.length <= 0) {
        return false;
    }
    
    return true;
}

/**
 * Check whether database needs to be stored on SDCard or not.
 * @return TRUE: If external_storage defined as true in DatabaseDescriptor.core.xml file, FALSE: If external_storage defined as false in DatabaseDescritor.xml file.
 */
- (BOOL) isExternalStorageEnable {
    return self.isExternalStorageEnable;
}

/**
 * Check whether database transactions to make multi-threading safe or not.
 * @return TRUE: If locking is required as per defined in DatabaseDescriptor.core.xml file, FALSE: If locking is not required as per defined in DatabaseDescriptor.core.xml file.
 */
- (BOOL) isLockingRequired {
    return self.isLockingRequired;
}

/**
 * Set database locking as per defined in DatabaseDescriptor.core.xml file.
 * @param isLockingRequired (true/false) database locking as per defined in DatabaseDescriptor.core.xml file.
 */
- (void) setLockingRequired : (BOOL) isLockingRequired {
    self.isLockingRequired = isLockingRequired;
}

/**
 * Check whether database mapping object exists or not, based on table name.
 * @param tableName Name of table.
 * @return TRUE: If database mapping exists, FALSE: If database mapping does not exists.
 */
- (BOOL) containsDatabaseMappingBasedOnTableName :  (NSString*) tableName {
    return ([self.databaseMappingsBasedOnTableName  objectForKey:tableName] != nil);
}

/**
 * Check whether database mapping object exists or not, based on POJO class name.
 * @param className POJO class name.
 * @return TRUE: If database mapping exists, FALSE: If database mapping does not exists.
 */
- (BOOL) containsDatabaseMappingBasedOnClassName : (NSString*) className {
    return ([self.databaseMappingsBasedOnClassName objectForKey:className] != nil);
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
- (NSArray*) getDatabaseMappings {
    return [self.databaseMappingsBasedOnClassName allValues];
}

/**
 * Get database mapping object based on table name.
 * @param tableName Name of table.
 * @return DatabaseMapping object based on table name.
 */
- (DatabaseMappingDescriptor*) getDatabseMappingBasedOnTableName :  (NSString*) tableName {
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
- (DatabaseMappingDescriptor*) getDatabseMappingBasedOnPath : (NSString*) databaseMappingPath {
    return [self.databaseMappingsBasedOnPath objectForKey:databaseMappingPath];
}

/**
 * Add database mapping object in respect to database mapping path.
 * @param databaseMappingPath Database Mapping Path.
 * @param databaseMapping Database Mapping object.
 */
- (void) addDatabaseMapping : (NSString*) databaseMappingPath forDatabaseMapping :(DatabaseMappingDescriptor*) databaseMapping {
    
    [self.databaseMappingsBasedOnPath setObject:databaseMapping forKey:databaseMappingPath];
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
    
    //self.databaseMappingsBasedOnClassName.values().remove(databaseMapping);
    //this.databaseMappingsBasedOnTableName.values().remove(databaseMapping);
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
        [self removeDatabaseMappingBasedOnPath:keyMatched];
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
    
    NSMutableArray* orderedDatabaseMappings = [[NSMutableArray alloc] init];
    
    for(NSString* databaseMappingPath in self.databaseMappingPaths) {
        [orderedDatabaseMappings addObject: [self getDatabseMappingBasedOnPath : databaseMappingPath]];
    }
    
    return orderedDatabaseMappings;
}

/**
 * Check whether library exists or not based on library name provided.
 * @param libraryName Name of library as per defined in LibraryDescriptor.core.xml file.
 * @return
 */
- (BOOL) containsLibraryBasedOnName : (NSString*) libraryName {
    return ([self.libraryDescriptorsBasedOnName objectForKey:libraryName] != nil);
}

/**
 * Check whether library exists or not based on library path provided.
 * @param libraryPath Path of library as per defined in DatabaseDescriptor.core.xml file.
 * @return
 */
- (BOOL) containsLibraryBasedOnPath : (NSString*) libraryPath {
    return ([self.libraryDescriptorsBasedOnPath objectForKey:libraryPath] != nil);
}

/**
 * Get all library paths as per defined in DatabaseDescriptor.core.xml file.
 * @return Iterator which contains all library paths.
 */
- (NSArray*) getLibraryPaths {
    return self.libraryPaths;
}

/**
 * Add library path as per defined in DatabaseDescriptor.core.xml file.
 * @param libraryPath Library path defined in DatabaseDescriptor.core.xml file.
 */
- (void) addLibraryPath : (NSString*) libraryPath {
    [self.libraryPaths addObject:libraryPath];
}

/**
 * Get all library descriptor paths contained.
 * @return Iterator which contains all library descriptor objects.
 */
- (NSArray*) getLibraryDescriptors {
    return [self.libraryDescriptorsBasedOnName allValues];
}

/**
 * Get all library descriptor objects in sorted order as per defined in DatabaseDescriptor.core.xml file.
 * @return Iterator which contains all library descriptor objects in sorted order.
 */
- (NSArray*) orderedLibraryDescriptors {
    NSMutableArray* orderedLibraryDescriptors = [[NSMutableArray alloc] init];
    
    for(NSString* libraryName in self.libraryPaths) {
        [orderedLibraryDescriptors addObject:[self getLibraryDescriptorBasedOnPath : libraryName]];
    }
    
    return orderedLibraryDescriptors;
}

/**
 * Get library descriptor object based on library descriptor path.
 * @param libraryPath Library Descriptor path.
 * @return
 */
- (LibraryDescriptor*) getLibraryDescriptorBasedOnPath: (NSString*) libraryPath {
    return [self.libraryDescriptorsBasedOnPath objectForKey:libraryPath];
}

/**
 * Add library object in respect to library descriptor path.
 * @param libraryPath Library Descriptor Path.
 * @param libraryDescriptor Library Descriptor Object.
 */
- (void) addLibrary : (NSString*) libraryPath  forLibraryDescriptor : (LibraryDescriptor*) libraryDescriptor {
    [self.libraryDescriptorsBasedOnPath setObject:libraryDescriptor forKey:libraryPath];
    [self.libraryDescriptorsBasedOnName setObject:libraryDescriptor forKey: libraryDescriptor.name];
}

/**
 * Remove library descriptor based on library path defined in DatabaseDescriptor.core.xml file.
 * @param libraryPath Library Descriptor Path.
 */
- (void) removeLibraryBasedOnPath : (NSString*) libraryPath {
    [self.libraryPaths removeObject:libraryPath];
    
    LibraryDescriptor* libraryDescriptor = [self.libraryDescriptorsBasedOnPath objectForKey:libraryPath];
    [self.libraryDescriptorsBasedOnPath removeObjectForKey:libraryPath];
    
    //self.libraryDescriptorsBasedOnName.values().remove(libraryDescriptor); ask
}

/**
 * Remove library descriptor based on library name defined in LibraryDescriptor.core.xml file.
 * @param libraryName Library Name.
 */
- (void) removeLibraryBasedOnName : (NSString*) libraryName {
    [self removeLibrary : [self.libraryDescriptorsBasedOnName objectForKey:libraryName]];
}

/**
 * Remove library descriptor object based on library descriptor object.
 * @param removeLibraryDescriptor Library Descriptor object.
 */
- (void) removeLibrary : (LibraryDescriptor*) removeLibraryDescriptor {
    LibraryDescriptor* libraryDescriptor = [self.libraryDescriptorsBasedOnName objectForKey:[removeLibraryDescriptor name]];
    NSArray* keys = [self.libraryDescriptorsBasedOnPath allKeys];
    
    NSString* keyMatched = nil;
    BOOL found = false;
    
    for(NSString* key in keys) {
        LibraryDescriptor* descriptor = [self.libraryDescriptorsBasedOnPath objectForKey:key];
        if(libraryDescriptor == descriptor) {
            keyMatched = key;
            found = true;
            break;
        }
    }
    
    if(found) {
        [self removeLibraryBasedOnPath : keyMatched];
    }
}

/**
 * Check whether library is needed by Database Descriptor or not.
 * @return TRUE: If library exists, FALSE: If no library exists.
 */
- (BOOL) isLibrariesNeeded {
    return ([self.libraryPaths count] > 0 ? true : false);
}


@end
