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
}

@property (nonatomic, retain) Month* month;
@end
