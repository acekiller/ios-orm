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

#import "ApplicationDescriptor.h"

/**
 * Exposes methods to GET and SET Application Descriptor information as per define in ApplicationDescriptor.core.xml file by application.
 <p>
 <pre>
 
 Example:
 {
 <core>
 
 <property name="name">CORE TEMPLATE</property>
 <property name="description">Core Template Application</property>
 <property name="version">0.9</property>
 
 <property name="load_initially">true</property>
 
 <!-- DATABASE-DESCRIPTORS -->
 <database-descriptors>
 <database-descriptor>DatabaseDescriptor.core.xml</database-descriptor>
 </database-descriptors>
 
 
 <!-- CORE EVENTS -->
 <event-handlers>
 <event-handler>com.core.template.events.CoreEventHandler</event-handler>
 <event-handler>com.core.template.events.DatabaseEventHandler</event-handler>
 </event-handlers>
 
 </core>
 }
 
 </pre>
 </p>
 *
 */

@interface ApplicationDescriptor()

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* description;
@property (nonatomic) double version;

@property (nonatomic) BOOL loadInitially;

@property (nonatomic, strong) NSMutableArray* databaseDescriptorPaths;
@property (nonatomic, strong) NSMutableDictionary* databaseDescriptorsBasedOnName;
@property (nonatomic, strong) NSMutableDictionary* databaseDescriptorsBasedOnPath;
@property (nonatomic, strong) NSMutableArray* events;

@end


@implementation ApplicationDescriptor

@synthesize name = _name;
@synthesize description = _description;
@synthesize version = _version;

@synthesize loadInitially = _loadInitially;

@synthesize databaseDescriptorPaths = _databaseDescriptorPaths;
@synthesize databaseDescriptorsBasedOnName = _databaseDescriptorsBasedOnName;
@synthesize databaseDescriptorsBasedOnPath = _databaseDescriptorsBasedOnPath;

#pragma mark Setters & Getters

/**
 * Get Application Descriptor Name as per defined in ApplicationDescriptor.core.xml file.
 * return Application Descriptor Name.
 */
- (NSString*) getName {
    return self.name;
}

/**
 * Set Application Descriptor Name as per defined in ApplicationDescriptor.core.xml file.
 * Name of Application Descriptor.
 */
- (void) setName : (const NSString*) name {
    self.name = [name copy];
}

/**
 * Set Description of Application as per defined in ApplicationDescriptor.core.xml file.
 * Description of application.
 */
- (NSString*) getDescription {
    return self.description;
}

/**
 * Set Description of Application as per defined in ApplicationDescriptor.core.xml file.
 * Description of application.
 */
- (void) setDescription : (const NSString*) description {
    self.description = [description copy];
}

/**
 * Get Version of Application as per defined in ApplicationDescriptor.core.xml file.
 * Version of application.
 */
- (double) getVersion {
    return self.version;
}

/**
 * Set Version of Application as per defined in ApplicationDescriptor.core.xml file.
 * Version of application.
 */
- (void) setVersion : (const double) version {
    self.version = version;
}

/**
 * Check whether database needed by application or not.
 * @return TRUE: If database needed by application, FALSE: If database is not needed by application.
 */
- (BOOL) isDatabaseNeeded {
    return self.databaseDescriptorPaths.count > 0 ? true : false;
}

/**
 * Check whether database descriptor exists in Resources or not.
 * @param databaseDescriptor Database Descriptor object.
 * @return TRUE: If Database Descriptor exists in Resources, FALSE: If Database Descriptor does not exists in Resources.
 */
- (BOOL) containsDatabaseDescriptor : (const DatabaseDescriptor*) databaseDescriptor {
    return ([self.databaseDescriptorsBasedOnName allKeysForObject:databaseDescriptor].count > 0);
}

/**
 * Check whether database descriptor exists in Resources or not, based on database descriptor path.
 * @param containDatabaseDescriptorPath Database Descriptor path.
 * @return TRUE: If Database Descriptor exists in Resources, FALSE: If Database Descriptor does not exists in Resources.
 */
- (BOOL) containsDatabaseDescriptorBasedOnPath : (const NSString*) databaseDescriptorPath {
    return ([self.databaseDescriptorsBasedOnPath objectForKey:databaseDescriptorPath] != nil);
}

/**
 * Check whether database descriptor exists in Resources or not, based on Database Descriptor name.
 * @param databaseDescriptorName Database Descriptor Name.
 * @return TRUE: If Database Descriptor exists in Resources, FALSE: If Database Descriptor does not exists in Resources.
 */
- (BOOL) containsDatabaseDescriptorBasedOnName : (const NSString*) databaseDescriptorName {
    return ([self.databaseDescriptorsBasedOnName objectForKey:databaseDescriptorName] != nil);
}

/**
 * Get Database Descriptor based on Database Descriptor Name.
 * @param databaseDescriptorName Database Desciptor Name.
 * @return Database Descriptor Object.
 */
- (DatabaseDescriptor*) getDatabaseDescriptorBasedOnName : (const NSString*) databaseDescriptorName {
    return [self.databaseDescriptorsBasedOnName objectForKey:databaseDescriptorName];
}

/**
 * Get Database Descriptor based on Database Descriptor Path.
 * @param databaseDescriptorPath Database Descriptor Path.
 * @return Database Descriptor Object.
 */
- (DatabaseDescriptor*) getDatabaseDescriptorBasedOnPath : (NSString*) databaseDescriptorPath {
    return [self.databaseDescriptorsBasedOnPath objectForKey:databaseDescriptorPath];
}

/**
 * Get all database descriptor paths as per contained in ApplicationDescriptor.core.xml file.
 * @return Iterator which contains all database descriptor paths.
 */
- (NSArray*) getDatabaseDescriptorPaths {
    return self.databaseDescriptorPaths;
}

/**
 * Get all database descriptor names as per needed by application.
 * @return Iterator which contains all database descriptor names.
 */
- (NSArray*) getDatabaseDescriptorNames {
    return self.databaseDescriptorsBasedOnName.allKeys;
}

/**
 * Add Database Descriptor path as per contained in ApplicationDescriptor.core.xml file.
 * @param databaseDescriptorPath DatabaseDescriptor path.
 */
- (void) addDatabaseDescriptorPath : (NSString*) databaseDescriptorPath {
    [self.databaseDescriptorPaths addObject:databaseDescriptorPath];
}

/**
 * Get all database descriptor objects contained by Core.
 * @return Iterator which contains all database descriptor objects.
 */
- (NSArray*) getDatabaseDescriptors {
    return [self.databaseDescriptorsBasedOnName allValues];
}

/**
 * Add Database Descriptor object in respect to database descriptor path.
 * @param databaseDescriptorPath Database Descriptor Path.
 * @param databaseDescriptor Database Descriptor Object.
 */
- (void) addDatabaseDescriptor : (NSString*) databaseDescriptorPath forDatabaseDescriptor : (DatabaseDescriptor*) databaseDescriptor {
    
    [self.databaseDescriptorsBasedOnPath setValue:databaseDescriptor forKey:databaseDescriptorPath];
    [self.databaseDescriptorsBasedOnName setValue:databaseDescriptor forKey:databaseDescriptor.getDatabaseName];
}

/**
 * Remove Database Descriptor from Resources based on database path provided, as per defined in ApplicationDescriptor.core.xml file
 * @param databaseDescriptorPath Database Descriptor Path.
 */
- (void) removeDatabaseDescriptorBasedOnPath : (NSString*) databaseDescriptorPath {
    
    [self.databaseDescriptorPaths removeObject:databaseDescriptorPath];
    
    DatabaseDescriptor* databaseDescriptor = (DatabaseDescriptor*) [self.databaseDescriptorsBasedOnPath objectForKey: databaseDescriptorPath];
    [self.databaseDescriptorsBasedOnPath removeObjectForKey: databaseDescriptorPath];
    
    //self.databaseDescriptorsBasedOnName re .values().remove(databaseDescriptor);
}

/**
 * Remove Database Descriptor from Resources based in database name provided, as per defined in DatabaseDescriptor.core.xml file
 * @param databaseDescriptorName DatabaseDescriptor Name.
 */
- (void) removeDatabaseDescriptorBasedOnName : (NSString*) databaseDescriptorName {
    
    DatabaseDescriptor* databaseDescriptor = [self.databaseDescriptorsBasedOnName objectForKey:databaseDescriptorName];
    NSArray* keys = [self.databaseDescriptorsBasedOnPath allKeys];
    
    NSString* keyMatched = nil;
    BOOL found = false;
    
    for(NSString* key in keys) {
        DatabaseDescriptor* descriptor = [self.databaseDescriptorsBasedOnPath objectForKey:key];
        if(databaseDescriptor == descriptor) {
            keyMatched = key;
            found = true;
            break;
        }
    }
    
    if(found) {
        [self removeDatabaseDescriptorBasedOnPath : keyMatched];
    }
}

/**
 * Remove DatabaseDescriptor object from Resources.
 * @param databaseDescriptor DatabaseDescriptor object which needs to be removed.
 */
- (void) removeDatabaseDescriptor : (DatabaseDescriptor*) databaseDescriptor {
    [self removeDatabaseDescriptorBasedOnName : [databaseDescriptor getDatabaseName]];
}

/**
 * It defines the behaviour of CORE. (Should core load all database mapping at initialization or on demand).
 * @return TRUE: If load initially is set to true, FALSE: If load initially is set to false.
 */
- (BOOL) doLoadInitially {
    return self.loadInitially;
}

/**
 * Set load initially to true or false.
 * @param initialLoad (true/false) defined by ApplicationDescriptor.core.xml file.
 */
- (void) setLoadInitially : (BOOL) initialLoad {
    self.loadInitially = initialLoad;
}

/**
 * Get all event handlers as per defined in ApplicationDescriptor.core.xml file.
 * @return All event handlers defined in ApplicationDescriptor.core.xml file
 */
- (NSArray*) getEvents {
    return self.events;
}

/**
 * Add event as per defined in ApplicationDescriptor.core.xml file.
 * @param event Event Handler class name.
 */
- (void) addEvent : (NSString*) event {
    [self.events addObject:event];
}


@end
