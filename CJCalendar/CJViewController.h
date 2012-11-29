//
//  CJViewController.h
//  CJCalendar
//
//  Created by Dmitry Sukhorukov on 11/25/12.
//  Copyright (c) 2012 Funny Codes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJCalendarView.h"
#import "MonthView.h"
#import "CJInfoViewController.h"

@class CJMonthDetailsView;
@class KalLogic;
@class Calendar;

@interface CJViewController : UIViewController<MonthViewDelegate, CJInfoViewControllerDelegate>
{
    @private
    IBOutlet UIImageView *ribbonView;
    IBOutlet CJMonthDetailsView *monthDetailsView;
    IBOutlet CJCalendarView *calendarView;
    IBOutlet UIScrollView *monthScroll;
    IBOutlet UILabel *monthTitle;
    IBOutlet UIView *controlsContainer;
    IBOutlet UILabel *periodInfoLabel;
    IBOutlet UIView *holidaysContainerView;
    IBOutlet UILabel *holidayDatesLabel;
    IBOutlet UILabel *holidayTitleLabel;
    
    KalLogic* logic;
    Calendar* calendar;
    
    NSUInteger calculatedOffset;
    
    BOOL proViewVisible;
}

- (IBAction)onInfoButton:(id)sender;
- (IBAction)onGotoProView:(id)sender;
- (IBAction)onNextMonth:(id)sender;
- (IBAction)onPrevMonth:(id)sender;

@end
