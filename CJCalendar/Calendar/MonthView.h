//
//  MonthView.h
//  BookInTouch
//
//  Created by Dmitry Sukhorukov on 3/4/11.
//  Copyright 2011 Funny Codes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KalLogic.h"

@protocol MonthViewDelegate
-(void) didSelectDate:(NSDate*)date;
@end

@interface MonthView : UIView 
{
@private
	NSArray* dateButtons;
	NSDate* startDate;
	KalLogic* logic;
	
	UILabel* titleLabel;
    
    id<MonthViewDelegate> delegate;
}

@property (nonatomic, assign) id<MonthViewDelegate> delegate;
@property (nonatomic, retain) NSArray* dateButtons;
@property (nonatomic, retain) NSDate* startDate;
@property (nonatomic, retain) UILabel* titleLabel;

- (id)initWithFrame:(CGRect)frame logic:(KalLogic*)logic;

@end
