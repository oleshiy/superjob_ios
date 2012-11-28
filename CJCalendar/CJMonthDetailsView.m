//
//  CJMonthDetailsView.m
//  CJCalendar
//
//  Created by Dmitry Sukhorukov on 11/27/12.
//  Copyright (c) 2012 Funny Codes. All rights reserved.
//

#import "CJMonthDetailsView.h"
#import "Month.h"

@implementation CJMonthDetailsView
@synthesize month;

-(void) dealloc
{
    [totalDaysLabel release];
    [workDaysLabel release];
    [holidaysLabel release];
    [week40hrsLabel release];
    [week36hrsLabel release];
    [week20hrsLabel release];
    [monthTitle release];
    [month release];
    [additionalDetailsContainer release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) setMonth:(Month *)val
{
    [val retain];
    [month release];
    month = val;
    
    monthTitle.text = [NSString stringWithFormat:@"%@ %d", month.name, month.year];
    
    totalDaysLabel.text = [NSString stringWithFormat:@"%d", month.numberOfDays];
    NSUInteger hc = [month holidaysCount];
    holidaysLabel.text = [NSString stringWithFormat:@"%d", hc];
    
    NSUInteger workdays = month.numberOfDays - hc;
    NSUInteger shortdays = [month shortDaysCount];
    workDaysLabel.text = [NSString stringWithFormat:@"%d", workdays];
    
    week40hrsLabel.text = [NSString stringWithFormat:@"%g", workdays / 5.0f * 40.0f - shortdays];
    week36hrsLabel.text = [NSString stringWithFormat:@"%g", workdays / 5.0f * 36.0f - shortdays];
    week20hrsLabel.text = [NSString stringWithFormat:@"%g", workdays / 5.0f * 20.0f - shortdays];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
