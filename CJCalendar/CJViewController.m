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
#import "KalDate.h"

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
    
            NSString* fontName = @"ProximaNova-Regular";
            
            if(l.tag == 1)
                fontName = @"ProximaNova-Extrabld";
            else if(l.tag == 2)
                fontName = @"ProximaNova-Bold";
    
            UIFont* fnt = [UIFont fontWithName:fontName size:sz];
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
    
    CGRect currentMonthRect = CGRectZero;

    NSDate* date = [NSDate date];

    KalDate* dt = [KalDate dateFromNSDate:date];
    
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
        
        if(dt.month == month.monthNum)
            currentMonthRect = mv.frame;
        
		//monthDate = [monthDate cc_dateByMovingToFirstDayOfTheFollowingMonth];
	}
	
	monthScroll.contentSize = CGSizeMake(monthViewWidth * numberOfMonthes, monthViewHeight);
    
    CJMonthDetailsView* v = (isRetina4)?monthDetailsViewRetina4:monthDetailsView;
    v.cal = calendar;
    
    //    scroll to the current month;
    [monthScroll scrollRectToVisible:currentMonthRect animated:YES];
    
    [self updateMonthLabel];
    
}

-(void) didSelectDate:(NSDate*)date
{
    
}

#if TARGET_IPHONE_SIMULATOR
-(void) listOfFonts
{
    // List all fonts on iPhone
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
    {
        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        fontNames = [[NSArray alloc] initWithArray:
                     [UIFont fontNamesForFamilyName:
                      [familyNames objectAtIndex:indFamily]]];
        for (indFont=0; indFont<[fontNames count]; ++indFont)
        {
            NSLog(@"    Font name: %@", [fontNames objectAtIndex:indFont]);
        }
        [fontNames release];
    }
    [familyNames release];
    
    
}
#endif

- (void)viewDidLoad
{
    
#if TARGET_IPHONE_SIMULATOR
    [self listOfFonts];
#endif
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIImage* ribbonImage = [UIImage imageNamed:@"ribbon.png"];
    ribbonView.image = [ribbonImage stretchableImageWithLeftCapWidth:20 topCapHeight:0];

    isRetina4 = NO;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if ([UIScreen mainScreen].bounds.size.height > 480.0f) {
            isRetina4 = YES;
        }
    }
    
    controlsContainer.hidden = isRetina4;

    // manage fonts
    [self replaceFontFamilyOnlabelsInView:monthDetailsView];
    [self replaceFontFamilyOnlabelsInView:monthDetailsViewRetina4];
    [self replaceFontFamilyOnlabelsInView:calendarView];
    [self replaceFontFamilyOnlabelsInView:controlsContainer];
    
    [self generateCalendar];
    
    CJMonthDetailsView *v = (isRetina4)?monthDetailsViewRetina4:monthDetailsView;
    v.delegate = self;
    CGRect f = v.frame;
    
    [self.view insertSubview:v aboveSubview:calendarView];
    
    f.origin.y = calendarView.frame.size.height + calendarView.frame.origin.y;
    v.frame = f;
}

-(void) didDetailsClosed
{
    if(controlsContainer.hidden)
        return;
    
    [UIView animateWithDuration:0.3f animations:^{
        
        controlsContainer.transform = CGAffineTransformMakeTranslation(0, 0);
        
    }];
}

-(void) didDetailsOpened
{
    if(controlsContainer.hidden)
        return;

    [UIView animateWithDuration:0.3f animations:^{
        
        controlsContainer.transform = CGAffineTransformMakeTranslation(0, controlsContainer.frame.size.height);
        
    }];    
}

-(void) viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
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
    [monthDetailsViewRetina4 release];
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
    
    CJMonthDetailsView* v = (isRetina4)?monthDetailsViewRetina4:monthDetailsView;
    v.month = mv.month;
    
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

- (void)infoViewControllerDidFinish:(CJInfoViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onInfoButton:(id)sender {
    
    CJInfoViewController* vc = nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        vc = [[CJInfoViewController alloc] initWithNibName:@"CJInfoViewController_iPhone" bundle:nil];
    } else {
        vc = [[CJInfoViewController alloc] initWithNibName:@"CJInfoViewController_iPad" bundle:nil];
    }
    [self replaceFontFamilyOnlabelsInView:vc.view];
    
    vc.delegate = self;
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:nil];

    [vc release];

}

- (IBAction)onGotoProView:(id)sender {
    
    proViewVisible = !proViewVisible;

    CJMonthDetailsView* v = (isRetina4)?monthDetailsViewRetina4:monthDetailsView;
    if(proViewVisible)
        [v showAdditional:proViewVisible];

    [UIView animateWithDuration:0.3f animations:^{

        v.transform = CGAffineTransformMakeTranslation(0, -v.frame.origin.y);
        controlsContainer.transform = CGAffineTransformMakeTranslation(0, (proViewVisible)?controlsContainer.frame.size.height:0);
        
    } completion:^(BOOL finished) {
        if(finished && !proViewVisible)
        {
            [v showAdditional:proViewVisible];
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
    [monthDetailsViewRetina4 release];
    monthDetailsViewRetina4 = nil;
    [super viewDidUnload];
}
@end
