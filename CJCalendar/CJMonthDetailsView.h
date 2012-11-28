//
//  CJMonthDetailsView.h
//  CJCalendar
//
//  Created by Dmitry Sukhorukov on 11/27/12.
//  Copyright (c) 2012 Funny Codes. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Month;
@interface CJMonthDetailsView : UIView
{
    @private
    Month* month;
    IBOutlet UILabel* monthTitle;
    IBOutlet UILabel* totalDaysLabel;
    IBOutlet UILabel* workDaysLabel;
    IBOutlet UILabel* holidaysLabel;
    IBOutlet UILabel* week40hrsLabel;
    IBOutlet UILabel* week36hrsLabel;
    IBOutlet UILabel* week20hrsLabel;
    IBOutlet UIView *additionalDetailsContainer;
}

@property (nonatomic, retain) Month* month;
@end
