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

#import "Siminov.h"
#import "DeploymentException.h"
#import <objc/runtime.h>

static BOOL isActive = YES;

@implementation Siminov

/**
 * It is used to check whether SIMINOV FRAMEWORK is active or not.
 * <p>
 * SIMINOV become active only when deployment of application is successful.
 *
 * @exception If SIMINOV is not active it will throw DeploymentException which is RuntimeException.
 *
 */
+ (void)validateSiminov {
    
    if(!isActive) {
        DeploymentException* depEx = [[DeploymentException alloc] initWithClassName:[NSString stringWithUTF8String : class_getName([Siminov class])] methodName:@"validateSiminov" message:@"Siminov Not Active."];
        
        @throw depEx;
    }
}

@end
