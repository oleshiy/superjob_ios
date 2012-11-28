//
//  Month.m
//  CJCalendar
//
//  Created by Dmitry Sukhorukov on 11/26/12.
//  Copyright (c) 2012 Funny Codes. All rights reserved.
//

#import "Month.h"
#import "TouchXML.h"
#import "UIColor+ext.h"
#import "Holiday.h"

@implementation Month
@synthesize holidayColor, beforeHolidayColor, year, date, holidays, name, numberOfDays;

-(void) dealloc
{
    [name release];
    [holidays release];
    [holidayColor release];
    [beforeHolidayColor release];
    [date release];
    [super dealloc];
}
-(id) initWithXml:(CXMLElement*)el andYear:(NSUInteger)yearOfMonth
{
    if(self = [super init])
    {
        year = yearOfMonth;
        
        NSArray* holidayEls = [el elementsForName:@"holiday"];
        
        NSMutableArray* temp = [[NSMutableArray alloc] init];
        for(CXMLElement* hEl in holidayEls)
        {
            Holiday* h = [[Holiday alloc] initWithXml:hEl];
            [temp addObject:h];
            [h release];
        }
        self.holidays = temp;
        [temp release];
        
        NSString* cl = [[el attributeForName:@"holiday_color"] stringValue];
        
        self.holidayColor = [UIColor colorWithHexString:cl];
        
        NSString* stNum = [[el attributeForName:@"month"] stringValue];
        
        self.name = [[el attributeForName:@"name"] stringValue];
        
        NSDateFormatter* fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"dd.MM.yyyy";
        date = [[fmt dateFromString:[NSString stringWithFormat:@"01.%@.%04d", stNum, year]] retain];
        [fmt release];
        
        cl = [[el attributeForName:@"before_holiday_color"] stringValue];
        self.beforeHolidayColor = [UIColor colorWithHexString:cl];
        
    }
    return self;
 
}

-(HolidayKind) holidayForDay:(NSUInteger)day
{
    for(Holiday* h in holidays)
    {
        if((h.startDay <= day) && (h.finishDay >= day))
            return h.kind;
    }
    
    return HKNone;
}

-(NSUInteger) holidaysCount
{
    NSUInteger cntr = 0;
    for(Holiday* h in holidays)
    {
        if(h.kind != HKBeforeHoliday)
        {
            NSUInteger cnt = h.finishDay - h.startDay + 1;
            cntr+=cnt;
        }
    }
    
    return cntr;
}

-(NSUInteger) shortDaysCount
{
    NSUInteger cntr = 0;
    for(Holiday* h in holidays)
    {
        if(h.kind == HKBeforeHoliday)
        {
            ++cntr;
        }
    }
    
    return cntr;
}

@end
