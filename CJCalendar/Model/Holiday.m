//
//  Holiday.m
//  CJCalendar
//
//  Created by Dmitry Sukhorukov on 11/26/12.
//  Copyright (c) 2012 Funny Codes. All rights reserved.
//

#import "Holiday.h"
#import "TouchXML.h"

@implementation Holiday
@synthesize name;
@synthesize startDay;
@synthesize finishDay;
@synthesize kind;

-(void) dealloc
{
    [name release];
    [super dealloc];
}

-(id) initWithXml:(CXMLElement*)el
{
    if(self = [super init])
    {
        NSString* stKind = [[el attributeForName:@"kind"] stringValue];
        
        if([stKind isEqualToString:@"holiday"])
            kind = HKHoliday;
        else if([stKind isEqualToString:@"dayoff"])
            kind = HKDayOff;
        else if([stKind isEqualToString:@"daybefore"])
            kind = HKBeforeHoliday;
        
        startDay = [[[el attributeForName:@"start"] stringValue] integerValue];
        
        CXMLNode* node = [el attributeForName:@"finish"];

        finishDay = startDay;
        
        if(node)
            finishDay = [[node stringValue] integerValue];
        
    
    }
    return self;
}

@end
