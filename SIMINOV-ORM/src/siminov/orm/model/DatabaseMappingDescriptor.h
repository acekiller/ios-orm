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

@class Relationship, Index, Column;


@interface DatabaseMappingDescriptor : NSObject

- (NSString*) getTableName;

- (NSString*) getClassName;

- (void) setTableName:(NSString *)tableName;

/* Check whether column exists based on column name. */
- (BOOL) containsColumnBasedOnColumnName : (NSString*) columnName;

/* Check whether column exists based on variable name. */
- (BOOL) containsColumnBasedOnVariableName : (NSString*) variableName;

- (Column*) getColumnBasedOnColumnName : (NSString*) columnName;

/* Get column based on variable name */
- (Column*) getColumnBasedOnVariableName : (NSString*) variableName;

/* Get all column names */
- (NSArray*) getColumnNames;

/* Get all columns */
- (NSArray*) getColumns;

/* Add column to DatabaseMapping object */
- (void) addColumn : (Column*) column;

/* Remove column based on variable name */
- (void) removeColumnBasedOnVariableName : (NSString*) variableName;

/* Remove column based on column name */
- (void) removeColumnBasedOnColumnName : (NSString*) columnName;

/* Remove column based on column object */
- (void) removeColumn : (Column*) column;

/* Check whether index exists based in index name */
- (BOOL) containsIndex : (NSString*) indexName;

/* Get index object based on index name */
- (Index*) getIndex : (NSString*) indexName;

/* Get all index names */
- (NSArray*) getIndexNames;

/* Get all indexs */
- (NSArray*) getIndexes;

/* Add index to DatabaseMapping object */
- (void) addIndex : (Index*) index;

/* Remove index object */
- (void) removeIndex : (Index*) index;

/* Remove index object */
- (void) removeIndexForIndexName : (NSString*) indexName;

/* Get iterator of relationship objects */
- (NSArray*) getRelationships;

/* Get iterator of relationship objects based on refer */
- (Relationship*) getRelationshipBasedOnRefer : (NSString*) refer;

/* Get relationship object based on refer to */
- (Relationship*) getRelationshipBasedOnReferTo : (NSString*) referTo;

/* Get one to one relationship object */
- (NSArray*) getOneToOneRelationships;

/* Get one to many relationship object */
- (NSArray*) getOneToManyRelationships;

/* Get many to one relationship object */
- (NSArray*) getManyToOneRelationships;

/* Get many to many relationship object */
- (NSArray*) getManyToManyRelationships;

/* Add relationship object */
- (void) addRelationship : (Relationship*) relationship;


@end
