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

#import "SiminovException.h"

@interface SiminovException()

@property (nonatomic, strong) NSString* className;
@property (nonatomic, strong) NSString* methodName;
@property (nonatomic, strong) NSString* message;

@end

@implementation SiminovException

- (id) initWithClassName:(NSString*)className methodName:(NSString*)methodName message:(NSString*)message {
    
    if(self)
    {
        self.className = className;
        self.methodName = methodName;
        self.message = message;
    }
    
    return self;
}

/**
 * Get POJO class name.
 * @return POJO Class Name.
 */
- (NSString*) getClassName {
    return self.className;
}

/**
 * Set POJO class name.
 * @param className POJO Class Name.
 */
- (void) setClassName : (NSString*) className {
    self.className = className;
}

/**
 * Get method Name.
 * @return Name Of Method.
 */
- (NSString*) getMethodName {
    return self.methodName;
}

/**
 * Set method Name.
 * @param methodName Name Of Method.
 */
- (void) setMethodName : (NSString*) methodName {
    self.methodName = methodName;
}

/**
 * Get message.
 * @return Message.
 */
- (NSString*) getMessage {
    return self.message;
}

/**
 * Set message.
 * @param message Message.
 */
- (void) setMessage : (NSString*) message {
    self.message = message;
}

@end
