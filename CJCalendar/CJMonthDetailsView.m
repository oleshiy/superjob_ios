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
@synthesize month, cal, currentHalf, currentQuartal, delegate;

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
    [numberFormatter release];
    [week40dimLabel release];
    [quartWeek40dimLabel release];
    [halfyearWeek40dimLabel release];
    [yearWeek40dimLabel release];
    [workDaysDimlabel release];
    [quartWorkDaysDimlabel release];
    [halfyearWorkDaysDimlabel release];
    [yearWorkDaysDimlabel release];
    [headDivider release];
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

-(void) updateDimFrame:(UILabel*)dimLabel valuelabel:(UILabel*)valueLabel
{
    [valueLabel sizeToFit];
    
    CGRect f = valueLabel.frame;
    CGRect f1 = dimLabel.frame;
    
    f1.origin.x = f.origin.x + f.size.width + 3.0f;
    dimLabel.frame = f1;
}

-(void) updateDimFrame:(UILabel*)dimLabel valuelabel:(UILabel*)valueLabel dayValue:(float)val
{
    [self updateDimFrame:dimLabel valuelabel:valueLabel];
    
    int mod10 = (int)val % 10;

    if(mod10 == 1)
        dimLabel.text = @"день";
    else if(mod10 < 5 && mod10 > 1)
        dimLabel.text = @"дня";
    else
        dimLabel.text = @"дней";    
}

-(void) awakeFromNib
{
    numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.groupingSeparator = @" ";
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    numberFormatter.groupingSize = 3;
    numberFormatter.usesGroupingSeparator = YES;
    numberFormatter.decimalSeparator = @",";
    
    initialFrame = CGRectNull;
    
}

-(void) calculateHalfYearEstimates
{
    currentHalf  = ((month.monthNum - 1) / 6) + 1;
    
    halfYearTitleLabel.text = [NSString stringWithFormat:@"%d полугодие", currentHalf];
    
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
        week20 += workdays / 5.0f * 24.0f - shortdays;
    }
    
    halfyearToalDaysLabel.text = [NSString stringWithFormat:@"%d", totalDays];
    halfyearHolidaysLabel.text = [NSString stringWithFormat:@"%d", totalHolidays];
    halfyearWorkDaysLabel.text = [NSString stringWithFormat:@"%d", totalWorkDays];
    
    halfyear40hrsLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble: week40]];
    halfyear36hrsLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble: week36]];
    halfyer20hrsLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble: week20]];

    [self updateDimFrame:halfyearWeek40dimLabel valuelabel:halfyear40hrsLabel];
    [self updateDimFrame:halfyearWorkDaysDimlabel valuelabel:halfyearToalDaysLabel dayValue:totalDays];
}

-(void) calculateQuartalEstimates
{
    currentQuartal  = ((month.monthNum - 1) / 3) + 1;

    quartTitleLabel.text = [NSString stringWithFormat:@"%d квартал", currentQuartal];
    
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
        week20 += workdays / 5.0f * 24.0f - shortdays;
    }
    
    quartTotalDaysLabel.text = [NSString stringWithFormat:@"%d", totalDays];
    quartHolidaysLabel.text = [NSString stringWithFormat:@"%d", totalHolidays];
    quartWorkDaysLabel.text = [NSString stringWithFormat:@"%d", totalWorkDays];
    
    quart40hrsLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble: week40]];
    quart36hrsLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble: week36]];
    quart20hrsLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble: week20]];
    
    [self updateDimFrame:quartWeek40dimLabel valuelabel:quart40hrsLabel];
    [self updateDimFrame:quartWorkDaysDimlabel valuelabel:quartTotalDaysLabel dayValue:totalDays];

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
        week20 += workdays / 5.0f * 24.0f - shortdays;
    }
    
    yearTotalDaysLabel.text = [NSString stringWithFormat:@"%d", totalDays];
    yearHolidaysLabel.text = [NSString stringWithFormat:@"%d", totalHolidays];
    yearWorkDaysLabel.text = [NSString stringWithFormat:@"%d", totalWorkDays];
    
    year40hrsLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat: week40]];
    year36hrsLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat: week36]];
    year20hrslabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat: week20]];

    [self updateDimFrame:yearWeek40dimLabel valuelabel:year40hrsLabel];
    [self updateDimFrame:yearWorkDaysDimlabel valuelabel:yearTotalDaysLabel dayValue:totalDays];
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
        
    monthTitle.text = [NSString stringWithFormat:@"%@", month.name];
    
    totalDaysLabel.text = [NSString stringWithFormat:@"%d", month.numberOfDays];
    NSUInteger hc = [month holidaysCount];
    holidaysLabel.text = [NSString stringWithFormat:@"%d", hc];
    
    NSUInteger workdays = month.numberOfDays - hc;
    NSUInteger shortdays = [month shortDaysCount];
    workDaysLabel.text = [NSString stringWithFormat:@"%d", workdays];
    
    week40hrsLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble: workdays / 5.0f * 40.0f - shortdays]];
    week36hrsLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble: workdays / 5.0f * 36.0f - shortdays]];
    week20hrsLabel.text = [numberFormatter stringFromNumber:[NSNumber numberWithDouble: workdays / 5.0f * 24.0f - shortdays]];

    [self updateDimFrame:week40dimLabel valuelabel:week40hrsLabel];
    [self updateDimFrame:workDaysDimlabel valuelabel:totalDaysLabel dayValue:month.numberOfDays];
    
    
    [self calculateQuartalEstimates];
    [self calculateHalfYearEstimates];
}


-(void) showAdditional:(BOOL)willShow
{
//    additionalDetailsContainer.hidden = !willShow;
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

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    [UIView animateWithDuration:0.3f animations:^{
        headDivider.alpha = 0.0f;
    }];
    
    lastLocation = [touch locationInView: self];
    
    if(CGRectIsNull(initialFrame))
        initialFrame = self.frame;
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [[event allTouches] anyObject];
    
    CGPoint location = [touch locationInView: self];
    
    CGFloat yDisplacement = location.y - lastLocation.y;

    opening = yDisplacement < 0;

    
    CGRect frame = touch.view.frame;
    frame.origin.y += yDisplacement;
    
    if(frame.origin.y > initialFrame.origin.y)
        frame.origin.y = initialFrame.origin.y;

    if(frame.origin.y < 0)
        frame.origin.y = 0;
    
    touch.view.frame = frame;

    CGFloat hg = initialFrame.origin.y;
    [delegate progressOpeningView:frame.origin.y / hg];
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

    //(self.frame.origin.y < ((self.frame.size.height - (self.frame.size.height - initialFrame.origin.y)) * 0.5f))
    if(opening)
    {
        [UIView animateWithDuration:0.3f animations:^{
            CGRect f = self.frame;
            f.origin.y = 0;
            self.frame = f;
        } completion:^(BOOL finished) {
            if(finished)
            {
                headDivider.alpha = 1.0;
                [delegate didDetailsOpened];
            }
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3f animations:^{
            self.frame = initialFrame;
        } completion:^(BOOL finished) {
            if(finished)
            {
                [delegate didDetailsClosed];
                headDivider.alpha = 1.0;
            }
        }];
    }
}

@end
