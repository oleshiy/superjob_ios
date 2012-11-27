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

@class CJMonthDetailsView;
@class KalLogic;

@interface CJViewController : UIViewController<MonthViewDelegate>
{
    @private
    IBOutlet UIImageView *ribbonView;
    IBOutlet CJMonthDetailsView *monthDetailsView;
    IBOutlet CJCalendarView *calendarView;
    IBOutlet UIScrollView *monthScroll;
    
    KalLogic* logic;
}
- (IBAction)onInfoButton:(id)sender;
- (IBAction)onGotoProView:(id)sender;
@end
