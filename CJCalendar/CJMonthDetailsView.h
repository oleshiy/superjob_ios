//
//  CJMonthDetailsView.h
//  CJCalendar
//
//  Created by Dmitry Sukhorukov on 11/27/12.
//  Copyright (c) 2012 Funny Codes. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Month;
@class Calendar;

@interface CJMonthDetailsView : UIView
{
    @private
    Month* month;
    Calendar* cal;
    
    
    IBOutlet UIButton *hideBtn;
    IBOutlet UILabel* monthTitle;
    IBOutlet UILabel* totalDaysLabel;
    IBOutlet UILabel* workDaysLabel;
    IBOutlet UILabel* holidaysLabel;
    IBOutlet UILabel* week40hrsLabel;
    IBOutlet UILabel* week36hrsLabel;
    IBOutlet UILabel* week20hrsLabel;
    IBOutlet UIView *additionalDetailsContainer;
    
    IBOutlet UILabel *quartTitleLabel;
    IBOutlet UILabel *halfYearTitleLabel;
    IBOutlet UILabel *yearTitleLabel;
    
    
    IBOutlet UILabel *quartTotalDaysLabel;
    IBOutlet UILabel *quartWorkDaysLabel;
    IBOutlet UILabel *quartHolidaysLabel;
    IBOutlet UILabel *quart40hrsLabel;
    IBOutlet UILabel *quart36hrsLabel;
    IBOutlet UILabel *quart20hrsLabel;
    
    IBOutlet UILabel *halfyearToalDaysLabel;
    IBOutlet UILabel *halfyearWorkDaysLabel;
    IBOutlet UILabel *halfyearHolidaysLabel;
    IBOutlet UILabel *halfyear40hrsLabel;
    IBOutlet UILabel *halfyear36hrsLabel;
    IBOutlet UILabel *halfyer20hrsLabel;
    
    IBOutlet UILabel *yearTotalDaysLabel;
    IBOutlet UILabel *yearWorkDaysLabel;
    IBOutlet UILabel *yearHolidaysLabel;
    IBOutlet UILabel *year40hrsLabel;
    IBOutlet UILabel *year36hrsLabel;
    IBOutlet UILabel *year20hrslabel;
    
    NSUInteger currentQuartal;
    NSUInteger currentHalf;
    
    NSNumberFormatter* numberFormatter;
}

@property (readonly) NSUInteger currentQuartal;
@property (readonly) NSUInteger currentHalf;
@property (nonatomic, retain) Month* month;
@property (nonatomic, retain) Calendar* cal;

-(void) showAdditional:(BOOL)willShow;

@end
