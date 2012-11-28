//
//  Holiday.h
//  CJCalendar
//
//  Created by Dmitry Sukhorukov on 11/26/12.
//  Copyright (c) 2012 Funny Codes. All rights reserved.
//

@class CXMLElement;

typedef enum
{
    HKNone,
    HKBeforeHoliday,
    HKHoliday,
    HKDayOff
    
} HolidayKind;

@interface Holiday : NSObject
{
@private
    HolidayKind kind;
    NSString* name;
    NSUInteger startDay;
    NSUInteger finishDay;
}

@property (readonly) HolidayKind kind;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, assign) NSUInteger startDay;
@property (nonatomic, assign) NSUInteger finishDay;

-(id) initWithXml:(CXMLElement*)el;

@end
