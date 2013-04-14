//
//  ApplicationDescriptorParser.m
//  SIMINOV-ORM
//
//  Created by Anupam on 14/04/13.
//  Copyright (c) 2013 Siminov. All rights reserved.
//

/**
 * Exposes methods to parse Application Descriptor information as per define in ApplicationDescriptor.si.xml file by application.
 <p>
 <pre>
 
 Example:
 {@code
 <core>
 
 <property name="name">SIMINOV TEMPLATE</property>
 <property name="description">Siminov Template Application</property>
 <property name="version">0.9</property>
 
 <property name="load_initially">true</property>
 
 <!-- DATABASE-DESCRIPTORS -->
 <database-descriptors>
 <database-descriptor>DatabaseDescriptor.si.xml</database-descriptor>
 </database-descriptors>
 
 
 <!-- SIMINOV EVENTS -->
 <event-handlers>
 <event-handler>com.core.template.events.SiminovEventHandler</event-handler>
 <event-handler>com.core.template.events.DatabaseEventHandler</event-handler>
 </event-handlers>
 
 </core>
 }
 
 </pre>
 </p>
 *
 */


#import "ApplicationDescriptorParser.h"

@interface ApplicationDescriptorParser()

@property (nonatomic,strong) ApplicationDescriptor* applicationDescriptor;

@property (nonatomic,strong) Resources* resources;// = Resources.getInstance();

@property (nonatomic,strong) NSString* tempValue;
@property (nonatomic,strong) NSString* propertyName;


@end

@implementation ApplicationDescriptorParser

@synthesize applicationDescriptor = _applicationDescriptor;
@synthesize resources = _resources;
@synthesize tempValue = _tempValue;
@synthesize propertyName = _propertyName;


- (id) initWithSiminovException : (NSError*) siminovException deploymentException : (NSError*) deploymentException {
    
    self.resources = [Resources getInstance];
    /*
    Context* context = [self.resources getApplicationContext];
    
    if(context == nil) {
        Log.loge(getClass().getName(), "Constructor", "Invalid Application Context found.");
        throw new SiminovException(getClass().getName(), "Constructor", "Invalid Application Context found.");
    }
    */
    
    /*
     * Parse ApplicationDescriptor.
     */
    InputStream applicationDescriptorStream = null;
    
    try {
        applicationDescriptorStream = context.getAssets().open(APPLICATION_DESCRIPTOR_FILE_NAME);
    } catch(IOException ioException) {
        Log.loge(getClass().getName(), "Constructor", "IOException caught while getting input stream of application descriptor, " + ioException.getMessage());
        throw new SiminovException(getClass().getName(), "Constructor", "IOException caught while getting input stream of application descriptor, " + ioException.getMessage());
    }
    
    try {
        parseMessage(applicationDescriptorStream);
    } catch(Exception exception) {
        Log.loge(getClass().getName(), "Constructor", "Exception caught while parsing APPLICATION-DESCRIPTOR, " + exception.getMessage());
        throw new SiminovException(getClass().getName(), "Constructor", "Exception caught while parsing APPLICATION-DESCRIPTOR, " + exception.getMessage());
    }
    
    doValidation();
}

public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException {
    
    tempValue = "";
    
    if(localName.equalsIgnoreCase(APPLICATION_DESCRIPTOR_SIMINOV)) {
        applicationDescriptor = new ApplicationDescriptor();
    } else if(localName.equalsIgnoreCase(APPLICATION_DESCRIPTOR_PROPERTY)) {
        initializeProperty(attributes);
    }
}

public void characters(char[] ch, int start, int length) throws SAXException {
    tempValue = new String(ch,start,length);
    
    if(tempValue == null || tempValue.length() <= 0) {
        return;
    }
    
    tempValue.trim();
}

public void endElement(String uri, String localName, String qName) throws SAXException {
    if(localName.equalsIgnoreCase(APPLICATION_DESCRIPTOR_PROPERTY)) {
        applicationDescriptor.addProperty(propertyName, tempValue);
    } else if(localName.equalsIgnoreCase(APPLICATION_DESCRIPTOR_DATABASE_DESCRIPTOR)) {
        applicationDescriptor.addDatabaseDescriptorPath(tempValue);
    } else if(localName.equalsIgnoreCase(APPLICATION_DESCRIPTOR_EVENT_HANDLER)) {
        
        if(tempValue == null || tempValue.length() <= 0) {
            return;
        }
        
        applicationDescriptor.addEvent(tempValue);
    }
}

private void initializeProperty(final Attributes attributes) {
    propertyName = attributes.getValue(APPLICATION_DESCRIPTOR_NAME);
}

private void doValidation() throws DeploymentException {
    
    /*
     * Validate Application Name field.
     */
    String name = applicationDescriptor.getName();
    if(name == null || name.length() <= 0) {
        Log.loge(getClass().getName(), "doValidation", "NAME IS MANDATORY FIELD - APPLICATION-DESCRIPTOR");
        throw new DeploymentException(getClass().getName(), "doValidation", "NAME IS MANDATORY FIELD - APPLICATION-DESCRIPTOR");
    }
    
    Iterator<String> databaseDescriptorPaths = applicationDescriptor.getDatabaseDescriptorPaths();
    while(databaseDescriptorPaths.hasNext()) {
        String databaseDescriptorPath = databaseDescriptorPaths.next();
        
        if(!databaseDescriptorPath.contains(SIMINOV_DESCRIPTOR_EXTENSION)) {
            Log.loge(getClass().getName(), "doValidation", "INVALID DATABASE DESCRIPTOR PATH FOUND, it should contain .core extension in path, PATH-DEFINED: " + databaseDescriptorPath);
            throw new DeploymentException(getClass().getName(), "doValidation", "INVALID DATABASE DESCRIPTOR PATH FOUND, it should contain .core extension in path, PATH-DEFINED: " + databaseDescriptorPath);
        }
    }
}

/**
 * Get application descriptor object.
 * @return Application Descriptor Object.
 */
public ApplicationDescriptor getApplicationDescriptor() {
    return this.applicationDescriptor;
}
    
}


@end
