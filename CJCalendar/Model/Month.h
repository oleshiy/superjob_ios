//
//  Month.h
//  CJCalendar
//
//  Created by Dmitry Sukhorukov on 11/26/12.
//  Copyright (c) 2012 Funny Codes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Holiday.h"

@class CXMLElement;

@interface Month : NSObject
{
    @private
    UIColor* holidayColor;
    UIColor* beforeHolidayColor;
    NSUInteger year;
    NSDate* date;
    NSArray* holidays;
    NSString* name;

    NSUInteger numberOfDays;
}

@property (nonatomic, retain) UIColor* holidayColor;
@property (nonatomic, retain) NSArray* holidays;
@property (nonatomic, retain) UIColor* beforeHolidayColor;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, readonly) NSDate* date;
@property (readonly) NSUInteger year;
@property (nonatomic) NSUInteger numberOfDays;

-(id) initWithXml:(CXMLElement*)el  andYear:(NSUInteger)yearOfMonth;
-(HolidayKind) holidayForDay:(NSUInteger)day;
-(NSUInteger) holidaysCount;
-(NSUInteger) shortDaysCount;

@end
