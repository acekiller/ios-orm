/*
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

#import "Log.h"

@implementation Log

/**
 * Log info messages.
 * @param className Class Name.
 * @param methodName Method Name.
 * @param message Message.
 */

+ (void) logi : (NSString*) className methodName : (NSString*) methodName message : (NSString*) message {
    NSLog(@"Info : %@",[Log prepareMessage:className methodName:methodName message:message]);
}

/**
 * Log error messages.
 * @param className Class Name.
 * @param methodName Method Name.
 * @param message Message.
 */

+ (void) loge : (NSString*) className methodName : (NSString*) methodName message : (NSString*) message {
    NSLog(@"Error : %@",[Log prepareMessage:className methodName:methodName message:message]);
}

/**
 * Log debug messages.
 * @param className Class Name.
 * @param methodName Method Name.
 * @param message Message.
 */

+ (void) logd : (NSString*) className methodName : (NSString*) methodName message : (NSString*) message {
    NSLog(@"Debug : %@",[Log prepareMessage:className methodName:methodName message:message]);
}


+ (NSString*) prepareMessage : (NSString*) className methodName : (NSString*) methodName message : (NSString*) message {
    return [[NSArray arrayWithObjects:@"Class Name: ", className, ", Method Name: ", methodName, ", Message: ", message, nil] componentsJoinedByString:@""];
}


@end
