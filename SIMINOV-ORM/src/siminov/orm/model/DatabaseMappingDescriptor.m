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
 * Exposes methods to GET and SET Library Descriptor information as per define in DatabaseDescriptor.core.xml or LibraryDescriptor.core.xml  file by application.
 <p>
 <pre>
 
 Example:
 {@code
 
 <database-mapping>
 
 <table table_name="LIQUOR" class_name="com.core.template.model.Liquor">
 
 <column variable_name="liquorType" column_name="LIQUOR_TYPE">
 <property name="type">TEXT</property>
 <property name="primary_key">true</property>
 <property name="not_null">true</property>
 <property name="unique">true</property>
 </column>
 
 <column variable_name="description" column_name="DESCRIPTION">
 <property name="type">TEXT</property>
 </column>
 
 <column variable_name="history" column_name="HISTORY">
 <property name="type">TEXT</property>
 </column>
 
 <column variable_name="link" column_name="LINK">
 <property name="type">TEXT</property>
 <property name="default">www.wikipedia.org</property>
 </column>
 
 <column variable_name="alcholContent" column_name="ALCHOL_CONTENT">
 <property name="type">TEXT</property>
 </column>
 
 <index name="LIQUOR_INDEX_BASED_ON_LINK" unique="true">
 <column>HISTORY</column>
 </index>
 
 </table>
 
 </database-mapping>
 
 }
 
 </pre>
 </p>
 *
 */


#import "DatabaseMappingDescriptor.h"

@interface Column : NSObject

@property (nonatomic, strong) NSString* variableName;
@property (nonatomic, strong) NSString* columnName;

@property (nonatomic, strong) NSString* getterMethodName;
@property (nonatomic, strong) NSString* setterMethodName;

@property (nonatomic, strong) NSString* type;
@property (nonatomic, strong) NSString* defaultValue;
@property (nonatomic, strong) NSString* check;

@property (nonatomic) BOOL primaryKey;
@property (nonatomic) BOOL isUnique;
@property (nonatomic) BOOL isNotNull;

@end

@interface Index : NSObject

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSMutableArray* columns;
@property (nonatomic) BOOL unique;

@end


@implementation Column

    @synthesize variableName = _variableName;
    @synthesize columnName = _columnName;
    @synthesize getterMethodName = _getterMethodName;
    @synthesize setterMethodName = _setterMethodName;
    @synthesize type = _type;
    @synthesize defaultValue = _defaultValue;
    @synthesize check = _check;
    @synthesize primaryKey = _primaryKey;
    @synthesize isUnique = _isUnique;
    @synthesize isNotNull = _isNotNull;

@end

@implementation Index

    @synthesize name = _name;
    @synthesize unique = _unique;
    @synthesize columns = _columns;

    /**
     * Check whether index contain column or not.
     * @param column Name of column.
     * @return TRUE: If index contains column, FALSE: If index does not contain column.
     */
    - (BOOL) containsColumn : (NSString*) column {
        return [self.columns containsObject:column];
    }

    /**
     * Get all columns.
     * @return Iterator which contain all columns.
     */
    - (NSArray*) getColumns {
        return self.columns;
    }

    /**
     * Add column to index.
     * @param column Name of column.
     */
    - (void) addColumn : (NSString*) column {
        [self.columns addObject:column];
    }

    /**
     * Remove column from index.
     * @param column Name of column.
     */
    - (void) removeColumn : (NSString*) column {
        [self.columns removeObject:column];
    }


@end

@interface Relationship

    @property (nonatomic, strong) NSString* relationshipType;

    @property (nonatomic, strong) NSString* refer;
    @property (nonatomic, strong) NSString* referTo;

    @property (nonatomic, strong) NSString* onUpdate;
    @property (nonatomic, strong) NSString* onDelete;

    @property (nonatomic, strong) NSString* getterReferMethodName;
    @property (nonatomic, strong) NSString* setterReferMethodName;

    @property (nonatomic) BOOL load;

    @property (nonatomic, strong) DatabaseMappingDescriptor* referedDatabaseMappingDescriptor;


@end

@implementation Relationship

    @synthesize relationshipType = _relationshipType;
    @synthesize refer = _refer;
    @synthesize referTo = _referTo;
    @synthesize onUpdate = _onUpdate;
    @synthesize onDelete = _onDelete;
    @synthesize getterReferMethodName = _getterReferMethodName;
    @synthesize setterReferMethodName = _setterReferMethodName;
    @synthesize load = _load;
    @synthesize referedDatabaseMappingDescriptor = _referedDatabaseMappingDescriptor;

@end

@interface DatabaseMappingDescriptor()

    @property (nonatomic, strong) NSString* tableName;
    @property (nonatomic, strong) NSString* className;

    @property (nonatomic, strong) NSMutableDictionary* columnsBasedOnColumnNames;
    @property (nonatomic, strong) NSMutableDictionary* columnsBasedOnVariableNames;

    @property (nonatomic, strong) NSMutableDictionary* indexes;

    @property (nonatomic, strong) NSMutableDictionary* relationshipsBasedOnRefer;
    @property (nonatomic, strong) NSMutableDictionary* relationshipsBasedOnReferTo;

    - (Column*) getColumnBasedOnVariableName : (NSString*) variableName;
    - (Column*) getColumnBasedOnColumnName : (NSString*) columnName;
    - (void) removeColumn : (Column*) column;
    - (void) removeIndex : (Index*) index;
    - (Index*) getIndex : (NSString*) indexName;

@end


@implementation DatabaseMappingDescriptor

//Constants
NSString* const ONE_TO_ONE = @"one-to-one";
NSString* const ONE_TO_MANY = @"one-to-many";
NSString* const MANY_TO_ONE = @"many-to-one";
NSString* const MANY_TO_MANY = @"many-to-many";


@synthesize tableName = _tableName;
@synthesize className = _className;
@synthesize columnsBasedOnColumnNames = _columnsBasedOnColumnNames;
@synthesize columnsBasedOnVariableNames = _columnsBasedOnVariableNames;
@synthesize indexes = _indexes;
@synthesize relationshipsBasedOnRefer = _relationshipsBasedOnRefer;
@synthesize relationshipsBasedOnReferTo = _relationshipsBasedOnReferTo;


/**
 * Check whether column exists based on column name.
 * @param columnName Name of column.
 * @return TRUE: If column exists, FALSE: If column do not exists.
 */
- (BOOL) containsColumnBasedOnColumnName : (NSString*) columnName {
    return ([self.columnsBasedOnColumnNames objectForKey:columnName] != nil);
}

/**
 * Check whether column exists based on variable name.
 * @param variableName Name of variable.
 * @return TRUE: If column exists, FALSE: If column do not exists.
 */
- (BOOL) containsColumnBasedOnVariableName : (NSString*) variableName {
    return ([self.columnsBasedOnVariableNames objectForKey:variableName] != nil);
}

/**
 * Get column based on column name.
 * @param columnName Name of column name.
 * @return Column object.
 */
- (Column*) getColumnBasedOnColumnName : (NSString*) columnName {
    return [self.columnsBasedOnColumnNames objectForKey:columnName];
}

/**
 * Get column based on variable name.
 * @param variableName Name of variable.
 * @return Column object.
 */
- (Column*) getColumnBasedOnVariableName : (NSString*) variableName {
    return [self.columnsBasedOnVariableNames objectForKey:variableName];
}

/**
 * Get all column names.
 * @return Iterator of all column names.
 */
- (NSArray*) getColumnNames {
    return [self.columnsBasedOnColumnNames allKeys];
}

/**
 * Get all columns.
 * @return Iterator of all columns.
 */
- (NSArray*) getColumns {
    return [self.columnsBasedOnVariableNames allValues];
}

/**
 * Add column to DatabaseMapping object.
 * @param column Column object.
 */
- (void) addColumn : (Column*) column {
    [self.columnsBasedOnVariableNames setValue:column forKey:column.variableName ];
    [self.columnsBasedOnColumnNames setValue:column forKey:column.columnName];
}

/**
 * Remove column based on variable name.
 * @param variableName Name of variable.
 */
- (void) removeColumnBasedOnVariableName : (NSString*) variableName {
    [self removeColumn : [self getColumnBasedOnVariableName :variableName]];
}

/**
 * Remove column based on column name.
 * @param columnName Name of column.
 */
- (void) removeColumnBasedOnColumnName : (NSString*) columnName {
    [self removeColumn : [self getColumnBasedOnColumnName : columnName]];
}

/**
 * Remove column based on column object.
 * @param column Column object which need to be removed.
 */
- (void) removeColumn : (Column*) column {
    //self.columnsBasedOnColumnNames.values().remove(column); ask
}

/**
 * Check whether index exists based in index name.
 * @param indexName Name of index.
 * @return TRUE: If index exists, FALSE: If index do not exists.
 */
- (BOOL) containsIndex : (NSString*) indexName {
    return ([self.indexes objectForKey:indexName] != NULL);
}

/**
 * Get index object based on index name.
 * @param indexName Name of index.
 * @return Index object.
 */
- (Index*) getIndex : (NSString*) indexName {
    return [self.indexes objectForKey:indexName];
}

/**
 * Get all index names.
 * @return Iterator which contains all index names.
 */
- (NSArray*) getIndexNames {
    return [self.indexes allKeys];
}

/**
 * Get all indexs.
 * @return Iterator which contain all indexs.
 */
- (NSArray*) getIndexes {
    return [self.indexes allValues];
}

/**
 * Add index to DatabaseMapping object.
 * @param index Index object.
 */
- (void) addIndex : (Index*) index {
    [self.indexes setValue:index forKey:index.name];
}


/**
 * Remove index object.
 * @param index Index object.
 */
- (void) removeIndex : (Index*) index {
    [self.indexes removeObjectForKey:index.name];
}


/**
 * Remove index object.
 * @param indexName Name of index.
 */
- (void) removeIndexForIndexName : (NSString*) indexName {
    [self removeIndex : [self getIndex : indexName]];
}


/**
 * Get iterator of relationship objects.
 * @return Relationship objects.
 */
- (NSArray*) getRelationships {
    return [self.relationshipsBasedOnRefer allValues];
}

/**
 * Get iterator of relationship objects based on refer.
 * @param refer Name of refer.
 * @return Relationship object based on refer.
 */
- (Relationship*) getRelationshipBasedOnRefer : (NSString*) refer {
    return [self.relationshipsBasedOnRefer objectForKey:refer];
}

/**
 * Get relationship object based on refer to.
 * @param referTo Name of refer to.
 * @return Relationship object based on refer to.
 */
- (Relationship*) getRelationshipBasedOnReferTo : (NSString*) referTo {
    return [self.relationshipsBasedOnReferTo objectForKey:referTo];
}

/**
 * Get one to one relationship object.
 * @return Iterator of relationship objects.
 */
- (NSArray*) getOneToOneRelationships {
    
    NSMutableArray* oneToOneRelationships = [NSMutableArray new];
    NSArray* relationships = [self.relationshipsBasedOnRefer allValues] ;
    
    //NSArray* relationshipsIterator = relationships.iterator();
    for(Relationship* rsp in relationships) {
        //Relationship relationship = relationshipsIterator.next();
        
        if([rsp.relationshipType  caseInsensitiveCompare : ONE_TO_ONE]) {
            [oneToOneRelationships addObject:rsp];
        }
    }
	
    return oneToOneRelationships;
}

/**
 * Get one to many relationship object.
 * @return Iterator of relationship objects.
 */
- (NSArray*) getOneToManyRelationships {
    
    NSMutableArray* oneToManyRelationships = [NSMutableArray new];
    NSArray* relationships = [self.relationshipsBasedOnRefer allValues];
    
    //Iterator<Relationship> relationshipsIterator = relationships.iterator();
    for(Relationship* rsp in relationships) {
        //Relationship* relationship = relationshipsIterator.next();
        
        if([rsp.relationshipType caseInsensitiveCompare : ONE_TO_MANY]) {
            [oneToManyRelationships addObject:rsp];
        }
    }
	
    return oneToManyRelationships;
}

/**
 * Get many to one relationship object.
 * @return Iterator of relationship objects.
 */
- (NSArray*) getManyToOneRelationships {
    
    NSMutableArray* manyToOneRelationships = [NSMutableArray new];
    NSArray* relationships = [self.relationshipsBasedOnRefer allValues];
    
    //Iterator<Relationship> relationshipsIterator = relationships.iterator();
    for(Relationship* rsp in relationships) {
        //Relationship* relationship = relationshipsIterator.next();
        
        if([rsp.relationshipType caseInsensitiveCompare : MANY_TO_ONE]) {
            [manyToOneRelationships addObject:rsp];
        }
    }
	
    return manyToOneRelationships;
}

/**
 * Get many to many relationship object.
 * @return Iterator of relationship objects.
 */
- (NSArray*) getManyToManyRelationships {
    
    NSMutableArray* manyToManyRelationships = [NSMutableArray new];
    NSArray* relationships = [self.relationshipsBasedOnRefer allValues];
    
    //Iterator<Relationship> relationshipsIterator = relationships.iterator();
    for(Relationship* rsp in relationships) {
        //Relationship* relationship = relationshipsIterator.next();
        
        if([rsp.relationshipType caseInsensitiveCompare : MANY_TO_MANY]) {
            [manyToManyRelationships addObject:rsp];
        }
    }
	
    return manyToManyRelationships;
}

/**
 * Add relationship object.
 * @param relationship Relationship object.
 */
- (void) addRelationship : (Relationship*) relationship {
    [self.relationshipsBasedOnRefer setValue:relationship forKey:relationship.refer];
    [self.relationshipsBasedOnReferTo setValue:relationship forKey:relationship.referTo];
}


@end
