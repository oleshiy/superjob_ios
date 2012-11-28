//
//  Calendar.m
//  CJCalendar
//
//  Created by Dmitry Sukhorukov on 11/26/12.
//  Copyright (c) 2012 Funny Codes. All rights reserved.
//

#import "Calendar.h"
#import "TouchXML.h"
#import "Month.h"

@implementation Calendar
@synthesize monthes;

-(void) dealloc
{
    [monthes release];
    [super dealloc];
}

-(id) initWithXml:(CXMLElement*)el
{
    if(self = [super init])
    {
        NSArray* elements = [el elementsForName:@"calendar"];

        NSMutableArray* mm = [[NSMutableArray alloc] init];
        
        for(CXMLElement* ce in elements)
        {
            // ce is calendar node
            NSArray* monthesEls = [ce elementsForName:@"month"];
            NSUInteger year = [[[ce attributeForName:@"year"] stringValue] integerValue];
            
            for(CXMLElement* me in monthesEls)
            {
                Month* m = [[Month alloc] initWithXml:me andYear:year];
                [mm addObject:m];
                [m release];
            }
        }
        self.monthes = mm;
        [mm release];
    }
    return self;
}

@end
