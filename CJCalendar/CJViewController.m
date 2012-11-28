//
//  CJViewController.m
//  CJCalendar
//
//  Created by Dmitry Sukhorukov on 11/25/12.
//  Copyright (c) 2012 Funny Codes. All rights reserved.
//

#import "CJViewController.h"
#import "CJMonthDetailsView.h"
#import "MonthView.h"
#import "NSDateAdditions.h"
#import "KalLogic.h"
#import "TouchXML.h"
#import "CXMLDocument.h"
#import "Calendar.h"
#import "Month.h"
#import "MonthView.h"

@interface CJViewController ()

@end

@implementation CJViewController

-(void) replaceFontFamilyOnlabelsInView:(UIView*)view
{
    for(UILabel* l in view.subviews)
    {
        if([l.subviews count])
            [self replaceFontFamilyOnlabelsInView:l];
        
        if([l isKindOfClass:[UILabel class]] /*|| [l isKindOfClass:[UITextField class]]*/)
        {
            UIFont* f = l.font;
            CGFloat sz = f.pointSize;
            
            UIFont* fnt = [UIFont fontWithName:(l.tag)?@"ProximaNova-Extrabld":@"ProximaNova-Regular" size:sz];
            l.font = fnt;
        }
        
    }
    
}


-(void) generateCalendar
{
    
    CGFloat monthViewWidth = monthScroll.frame.size.width;
	CGFloat monthViewHeight = monthScroll.frame.size.height;
	
	NSDate* monthDate = nil;
	
    if(!logic)
        logic = [[KalLogic alloc] init];

	CGFloat displacement = 0;
    
    CXMLDocument* doc = [[CXMLDocument alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"calendar" ofType:@"xml"]]  options:0 error:nil];
    
    if(!calendar)
        calendar = [[Calendar alloc] initWithXml:[doc rootElement]];
    
    [doc release];
    
    NSUInteger numberOfMonthes = [calendar.monthes count];

	for(NSUInteger i=0; i < numberOfMonthes; ++i)
	{
        Month* month = [calendar.monthes objectAtIndex:i];

        monthDate = month.date;
        
		MonthView* mv = [[MonthView alloc] initWithFrame:CGRectMake(monthViewWidth * i - displacement, 0, monthViewWidth, monthViewHeight) logic:logic];
        mv.month = month;
		mv.startDate = monthDate;
		[monthScroll addSubview:mv];
		[mv release];
        mv.delegate = self;
		//monthDate = [monthDate cc_dateByMovingToFirstDayOfTheFollowingMonth];
	}
	
	monthScroll.contentSize = CGSizeMake(monthViewWidth * numberOfMonthes, monthViewHeight);
    
    monthDetailsView.cal = calendar;
    [self updateMonthLabel];
    
}

-(void) didSelectDate:(NSDate*)date
{
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIImage* ribbonImage = [UIImage imageNamed:@"ribbon.png"];
    ribbonView.image = [ribbonImage stretchableImageWithLeftCapWidth:20 topCapHeight:0];
    
    // manage fonts
    [self replaceFontFamilyOnlabelsInView:monthDetailsView];
    [self replaceFontFamilyOnlabelsInView:calendarView];
    [self replaceFontFamilyOnlabelsInView:controlsContainer];
    
    [self generateCalendar];
    
    [self.view insertSubview:monthDetailsView aboveSubview:calendarView];
    CGRect f = monthDetailsView.frame;
    
    f.origin.y = calendarView.frame.size.height + calendarView.frame.origin.y;
    monthDetailsView.frame = f;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [calendar release];
    [logic release];
    [ribbonView release];
    [monthDetailsView release];
    [calendarView release];
    [monthScroll release];
    [monthTitle release];
    [controlsContainer release];
    [periodInfoLabel release];
    [holidaysContainerView release];
    [holidayDatesLabel release];
    [holidayTitleLabel release];
    [super dealloc];
}

-(void) updateMonthLabel
{
    // update month label depends on scrollview offset
    
    calculatedOffset = (NSUInteger)monthScroll.contentOffset.x/monthScroll.frame.size.width;
    
//    prevBtn.enabled = (calculatedOffset > 0);
//    nextBtn.enabled = (calculatedOffset < ([monthesViews count] - 1));
    
    MonthView* mv = [monthScroll.subviews objectAtIndex:calculatedOffset];
    monthTitle.text = [NSString stringWithFormat:@"%@ %d", mv.month.name, mv.month.year];
    
    monthDetailsView.month = mv.month;
    
    periodInfoLabel.text = [NSString stringWithFormat:@"%d квартал, %d полугодие %d год", monthDetailsView.currentQuartal, monthDetailsView.currentHalf, mv.month.year];
    
    
    NSArray* marked = [mv.month markedHolidays];
    
    holidaysContainerView.hidden = (marked.count == 0);
    
    if(!holidaysContainerView.hidden)
    {
        holidayDatesLabel.textColor = mv.month.holidayColor;
        
        NSMutableString* stDays = [NSMutableString string];
        NSMutableString* stTitles = [NSMutableString string];
        [stTitles appendString:@"— "];
        NSUInteger cnt = 0;
        for(Holiday* h in marked)
        {
            if(h.startDay == h.finishDay)
                [stDays appendFormat:@"%d", h.startDay];
            else if ((h.finishDay - h.startDay) > 1)
                [stDays appendFormat:@"%d-%d", h.startDay, h.finishDay];
            
            [stTitles appendString:h.name];
            ++cnt;
            if(cnt != [marked count])
            {
                [stDays appendString:@", "];
                [stTitles appendString:@", "];
            }
            
            
            
        }
        
        holidayDatesLabel.text = stDays;
        holidayTitleLabel.text = stTitles;

        [holidayDatesLabel sizeToFit];
        CGRect f = holidayTitleLabel.frame;
        f.origin.x = holidayDatesLabel.frame.origin.x + holidayDatesLabel.frame.size.width + 5.0f;
        holidayTitleLabel.frame = f;
    }
    
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView      // called when scroll view grinds to a halt
{
    [self updateMonthLabel];
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self updateMonthLabel];
}

#pragma mark - Actions

- (IBAction)onInfoButton:(id)sender {
}

- (IBAction)onGotoProView:(id)sender {
    
    proViewVisible = !proViewVisible;

    if(proViewVisible)
        [monthDetailsView showAdditional:proViewVisible];

    [UIView animateWithDuration:0.3f animations:^{

        monthDetailsView.transform = CGAffineTransformMakeTranslation(0, -monthDetailsView.frame.origin.y);
        controlsContainer.transform = CGAffineTransformMakeTranslation(0, (proViewVisible)?controlsContainer.frame.size.height:0);
        
    } completion:^(BOOL finished) {
        if(finished && !proViewVisible)
        {
            [monthDetailsView showAdditional:proViewVisible];
        }
    }];
    
}

- (IBAction)onNextMonth:(id)sender {
    if(calculatedOffset == ([monthScroll.subviews count] - 1))
        return;
    
    ++calculatedOffset;
    
    CGFloat newOffset = calculatedOffset * monthScroll.frame.size.width;
    
    [monthScroll setContentOffset:CGPointMake(newOffset, 0) animated:YES];
}

- (IBAction)onPrevMonth:(id)sender {
    if(calculatedOffset == 0)
        return;
    
    --calculatedOffset;
    
    CGFloat newOffset = calculatedOffset * monthScroll.frame.size.width;
    
    [monthScroll setContentOffset:CGPointMake(newOffset, 0) animated:YES];
}

- (void)viewDidUnload {
    [controlsContainer release];
    controlsContainer = nil;
    [periodInfoLabel release];
    periodInfoLabel = nil;
    [holidaysContainerView release];
    holidaysContainerView = nil;
    [holidayDatesLabel release];
    holidayDatesLabel = nil;
    [holidayTitleLabel release];
    holidayTitleLabel = nil;
    [super viewDidUnload];
}
@end
