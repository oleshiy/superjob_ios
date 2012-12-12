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

@protocol DetailsViewDelegate <NSObject>
-(void) didDetailsOpened;
-(void) didDetailsClosed;
-(void) progressOpeningView:(CGFloat)values;
@end

@interface CJMonthDetailsView : UIView
{
    @private
    Month* month;
    Calendar* cal;
    
    id<DetailsViewDelegate> delegate;
    
    
    IBOutlet UIImageView *headDivider;
    IBOutlet UIButton *hideBtn;
    IBOutlet UILabel* monthTitle;
    IBOutlet UILabel* totalDaysLabel;
    IBOutlet UILabel* workDaysLabel;
    IBOutlet UILabel *workDaysDimlabel;
    IBOutlet UILabel* holidaysLabel;
    IBOutlet UILabel* week40hrsLabel;
    IBOutlet UILabel *week40dimLabel;
    IBOutlet UILabel* week36hrsLabel;
    IBOutlet UILabel* week20hrsLabel;
    IBOutlet UIView *additionalDetailsContainer;
    
    IBOutlet UILabel *quartTitleLabel;
    IBOutlet UILabel *halfYearTitleLabel;
    IBOutlet UILabel *yearTitleLabel;
    
    
    IBOutlet UILabel *quartTotalDaysLabel;
    IBOutlet UILabel *quartWorkDaysLabel;
    IBOutlet UILabel *quartWorkDaysDimlabel;
    IBOutlet UILabel *quartHolidaysLabel;
    IBOutlet UILabel *quart40hrsLabel;
    IBOutlet UILabel *quartWeek40dimLabel;
    IBOutlet UILabel *quart36hrsLabel;
    IBOutlet UILabel *quart20hrsLabel;
    
    IBOutlet UILabel *halfyearToalDaysLabel;
    IBOutlet UILabel *halfyearWorkDaysLabel;
    IBOutlet UILabel *halfyearWorkDaysDimlabel;
    IBOutlet UILabel *halfyearHolidaysLabel;
    IBOutlet UILabel *halfyear40hrsLabel;
    IBOutlet UILabel *halfyearWeek40dimLabel;
    IBOutlet UILabel *halfyear36hrsLabel;
    IBOutlet UILabel *halfyer20hrsLabel;
    
    IBOutlet UILabel *yearTotalDaysLabel;
    IBOutlet UILabel *yearWorkDaysLabel;
    IBOutlet UILabel *yearWorkDaysDimlabel;
    IBOutlet UILabel *yearHolidaysLabel;
    IBOutlet UILabel *year40hrsLabel;
    IBOutlet UILabel *yearWeek40dimLabel;
    IBOutlet UILabel *year36hrsLabel;
    IBOutlet UILabel *year20hrslabel;
    
    NSUInteger currentQuartal;
    NSUInteger currentHalf;
    
    NSNumberFormatter* numberFormatter;
    
    
    CGPoint lastLocation;
    CGRect initialFrame;
    
    BOOL opening;
    
    
    
}

@property (readonly) NSUInteger currentQuartal;
@property (readonly) NSUInteger currentHalf;
@property (nonatomic, retain) Month* month;
@property (nonatomic, retain) Calendar* cal;

@property (nonatomic, assign) id<DetailsViewDelegate> delegate;

-(void) showAdditional:(BOOL)willShow;

@end
