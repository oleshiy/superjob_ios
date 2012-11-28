//
//  CJMonthDetailsView.m
//  CJCalendar
//
//  Created by Dmitry Sukhorukov on 11/27/12.
//  Copyright (c) 2012 Funny Codes. All rights reserved.
//

#import "CJMonthDetailsView.h"
#import "Month.h"
#import "Calendar.h"

@implementation CJMonthDetailsView
@synthesize month, cal, currentHalf, currentQuartal;

-(void) dealloc
{
    [cal release];
    [totalDaysLabel release];
    [workDaysLabel release];
    [holidaysLabel release];
    [week40hrsLabel release];
    [week36hrsLabel release];
    [week20hrsLabel release];
    [monthTitle release];
    [month release];
    [additionalDetailsContainer release];
    [hideBtn release];
    [quartTitleLabel release];
    [halfYearTitleLabel release];
    [yearTitleLabel release];
    [quartTotalDaysLabel release];
    [quartWorkDaysLabel release];
    [quartHolidaysLabel release];
    [quart40hrsLabel release];
    [quart36hrsLabel release];
    [quart20hrsLabel release];
    [halfyearToalDaysLabel release];
    [halfyearWorkDaysLabel release];
    [halfyearHolidaysLabel release];
    [halfyear40hrsLabel release];
    [halfyear36hrsLabel release];
    [halfyer20hrsLabel release];
    [yearTotalDaysLabel release];
    [yearWorkDaysLabel release];
    [yearHolidaysLabel release];
    [year40hrsLabel release];
    [year36hrsLabel release];
    [year20hrslabel release];
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

-(void) calculateHalfYearEstimates
{
    currentHalf  = ((month.monthNum - 1) / 6) + 1;
    
    halfYearTitleLabel.text = [NSString stringWithFormat:@"%d полугодие %d", currentHalf, month.year];
    
    float week40 = 0.0;
    float week36 = 0.0;
    float week20 = 0.0;
    
    NSUInteger totalDays = 0;
    NSUInteger totalShortDays = 0;
    NSUInteger totalWorkDays = 0;
    NSUInteger totalHolidays = 0;
    
    for(Month* m in cal.monthes)
    {
        NSUInteger monthHalf = ((m.monthNum - 1) / 6) + 1;
        
        if(currentHalf != monthHalf)
            continue;
        
        NSUInteger hc = [m holidaysCount];
        NSUInteger workdays = m.numberOfDays - hc;
        NSUInteger shortdays = [m shortDaysCount];
        
        totalWorkDays += workdays;
        totalHolidays += hc;
        totalShortDays += shortdays;
        totalDays += m.numberOfDays;
        
        
        week40 +=  workdays / 5.0f * 40.0f - shortdays;
        week36 +=   workdays / 5.0f * 36.0f - shortdays;
        week20 += workdays / 5.0f * 20.0f - shortdays;
    }
    
    halfyearToalDaysLabel.text = [NSString stringWithFormat:@"%d", totalDays];
    halfyearHolidaysLabel.text = [NSString stringWithFormat:@"%d", totalHolidays];
    halfyearWorkDaysLabel.text = [NSString stringWithFormat:@"%d", totalWorkDays];
    
    halfyear40hrsLabel.text = [NSString stringWithFormat:@"%g", week40];
    halfyear36hrsLabel.text = [NSString stringWithFormat:@"%g", week36];
    halfyer20hrsLabel.text = [NSString stringWithFormat:@"%g", week20];

}

-(void) calculateQuartalEstimates
{
    currentQuartal  = ((month.monthNum - 1) / 3) + 1;

    quartTitleLabel.text = [NSString stringWithFormat:@"%d квартал %d", currentQuartal, month.year];
    
    float week40 = 0.0;
    float week36 = 0.0;
    float week20 = 0.0;
    
    NSUInteger totalDays = 0;
    NSUInteger totalShortDays = 0;
    NSUInteger totalWorkDays = 0;
    NSUInteger totalHolidays = 0;
    
    for(Month* m in cal.monthes)
    {
        NSUInteger monthQuart = ((m.monthNum - 1) / 3) + 1;
        
        if(monthQuart != currentQuartal)
            continue;
        
        NSUInteger hc = [m holidaysCount];
        NSUInteger workdays = m.numberOfDays - hc;
        NSUInteger shortdays = [m shortDaysCount];
        
        totalWorkDays += workdays;
        totalHolidays += hc;
        totalShortDays += shortdays;
        totalDays += m.numberOfDays;
        
        
        week40 +=  workdays / 5.0f * 40.0f - shortdays;
        week36 +=   workdays / 5.0f * 36.0f - shortdays;
        week20 += workdays / 5.0f * 20.0f - shortdays;
    }
    
    quartTotalDaysLabel.text = [NSString stringWithFormat:@"%d", totalDays];
    quartHolidaysLabel.text = [NSString stringWithFormat:@"%d", totalHolidays];
    quartWorkDaysLabel.text = [NSString stringWithFormat:@"%d", totalWorkDays];
    
    quart40hrsLabel.text = [NSString stringWithFormat:@"%g", week40];
    quart36hrsLabel.text = [NSString stringWithFormat:@"%g", week36];
    quart20hrsLabel.text = [NSString stringWithFormat:@"%g", week20];
    
}

-(void) calculateYearEstimates
{
    float week40 = 0.0;
    float week36 = 0.0;
    float week20 = 0.0;
    
    NSUInteger totalDays = 0;
    NSUInteger totalShortDays = 0;
    NSUInteger totalWorkDays = 0;
    NSUInteger totalHolidays = 0;
    
    for(Month* m in cal.monthes)
    {
        NSUInteger hc = [m holidaysCount];
        NSUInteger workdays = m.numberOfDays - hc;
        NSUInteger shortdays = [m shortDaysCount];
    
        totalWorkDays += workdays;
        totalHolidays += hc;
        totalShortDays += shortdays;
        totalDays += m.numberOfDays;
        
        
        week40 +=  workdays / 5.0f * 40.0f - shortdays;
        week36 +=   workdays / 5.0f * 36.0f - shortdays;
        week20 += workdays / 5.0f * 20.0f - shortdays;
    }
    
    yearTotalDaysLabel.text = [NSString stringWithFormat:@"%d", totalDays];
    yearHolidaysLabel.text = [NSString stringWithFormat:@"%d", totalHolidays];
    yearWorkDaysLabel.text = [NSString stringWithFormat:@"%d", totalWorkDays];
    
    year40hrsLabel.text = [NSString stringWithFormat:@"%g", week40];
    year36hrsLabel.text = [NSString stringWithFormat:@"%g", week36];
    year20hrslabel.text = [NSString stringWithFormat:@"%g", week20];
}

-(void) setCal:(Calendar *)val
{
    [val retain];
    [cal release];
    cal = val;
    
    [self calculateYearEstimates];
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
    
    [self calculateQuartalEstimates];
    [self calculateHalfYearEstimates];
}


-(void) showAdditional:(BOOL)willShow
{
    additionalDetailsContainer.hidden = !willShow;
    hideBtn.hidden = !willShow;
    
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
