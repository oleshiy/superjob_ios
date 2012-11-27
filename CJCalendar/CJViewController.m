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
    NSUInteger numberOfMonthes = 12;
    
    CGFloat monthViewWidth = monthScroll.frame.size.width;
	CGFloat monthViewHeight = monthScroll.frame.size.height;
	
	NSDate* monthDate = [NSDate date];
	
    if(!logic)
        logic = [[KalLogic alloc] init];

	CGFloat displacement = 0;
	for(NSUInteger i=0; i < numberOfMonthes; ++i)
	{
        //		displacement = (i % 2)?15.0f:-15.0f;
		MonthView* mv = [[MonthView alloc] initWithFrame:CGRectMake(monthViewWidth * i - displacement, 0, monthViewWidth, monthViewHeight) logic:logic];
		mv.startDate = monthDate;
		[monthScroll addSubview:mv];
		[mv release];
        mv.delegate = self;
		monthDate = [monthDate cc_dateByMovingToFirstDayOfTheFollowingMonth];
	}
	
	monthScroll.contentSize = CGSizeMake(monthViewWidth * numberOfMonthes, monthViewHeight);
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
    
    [self generateCalendar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [logic release];
    [ribbonView release];
    [monthDetailsView release];
    [calendarView release];
    [monthScroll release];
    [super dealloc];
}
- (IBAction)onInfoButton:(id)sender {
}

- (IBAction)onGotoProView:(id)sender {
}
@end
