//
//  MonthView.m
//  BookInTouch
//
//  Created by Dmitry Sukhorukov on 3/4/11.
//  Copyright 2011 Funny Codes. All rights reserved.
//

#import "MonthView.h"
#import "DateButton.h"
#import "NSDateAdditions.h"
#import "KalDate.h"
#import <QuartzCore/QuartzCore.h>

const NSUInteger kNumberOfDateCols = 7;
const NSUInteger kNumberOfDateRows = 5;

@implementation MonthView

@synthesize dateButtons;
@synthesize startDate;
@synthesize titleLabel;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame logic:(KalLogic*)thelogic
{
    
    self = [super initWithFrame:frame];

    if (self) {

		UIColor* shadowColor = [UIColor whiteColor];
		UIColor* hlTextColor = [UIColor blackColor];
		NSMutableArray* tempButtons = [[NSMutableArray alloc] init];
		UIImage* dateBgImg = [UIImage imageNamed:@"square.png"];
		CGFloat wd = (self.frame.size.width - 40) / kNumberOfDateCols;
		CGFloat hg = (self.frame.size.height - 16) / kNumberOfDateRows;

		NSArray* dow = [NSArray arrayWithObjects:@"пн",@"вт",@"ср",@"чт",@"пт",@"сб",@"вс",nil];
		
		
		for(NSUInteger col = 0; col < 7; col++)
		{
			UILabel* l = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width * 0.5f - kNumberOfDateCols * wd * 0.5f + col * wd
																   , 0
																   , wd
																   , 20)];
			l.font = [UIFont systemFontOfSize:10.0f];
			l.shadowOffset = CGSizeMake(0.0f, 1.0f);
			l.shadowColor = shadowColor;
			l.backgroundColor = [UIColor clearColor];
			l.opaque = NO;
			l.textAlignment = NSTextAlignmentCenter;
			l.text = [dow objectAtIndex:col];
			l.textColor = [UIColor blackColor];
			[self addSubview:l];
			[l release];
		}
        // Initialization code.
		for(NSUInteger row = 0; row <  kNumberOfDateRows; row++)
		{
			for(NSUInteger col = 0; col < kNumberOfDateCols; col++)
			{
				DateButton* btn = [DateButton buttonWithType:UIButtonTypeCustom];
				//btn.backgroundColor = [UIColor redColor];
				btn.opaque = NO;
				btn.frame = CGRectMake(self.frame.size.width * 0.5f - kNumberOfDateCols * wd * 0.5f + col * wd + 4
									   , 16 + row * hg
									   , wd - 5
									   , hg - 5);
				[btn setBackgroundImage:dateBgImg forState:UIControlStateNormal];
				btn.titleLabel.font = [UIFont fontWithName:@"ProximaNova-Extrabld" size:22];
				[btn setTitleColor:hlTextColor forState:UIControlStateNormal];
				[self addSubview:btn];
                
                btn.showsTouchWhenHighlighted = YES;
                
                btn.backgroundColor = [UIColor colorWithRed:231/255.0f green:237/255.0f blue:239/255.0f alpha:1.0f];
                btn.layer.shouldRasterize = YES;
                btn.layer.rasterizationScale = [[UIScreen mainScreen] scale];
                btn.layer.masksToBounds = NO;
                btn.layer.cornerRadius = 5.0f;
                
				[tempButtons addObject:btn];
				
			}
		}
		
		self.dateButtons = tempButtons;
		[tempButtons release];
    }
    return self;
}

-(void) setStartDate:(NSDate *)val
{
	[val retain];
	[startDate release];
	startDate = val;
	
	logic = [[KalLogic alloc] initForDate:startDate];

	NSArray* daysBefore = logic.daysInFinalWeekOfPreviousMonth;
	NSArray* daysMonth = logic.daysInSelectedMonth;
    NSArray* daysAfter = logic.daysInFirstWeekOfFollowingMonth;

	NSUInteger daysToSkipBefore = [daysBefore count];
	NSUInteger daysCount = [daysMonth count];
	NSUInteger cnt = 0;
	NSUInteger cntBefore = 0;
    NSUInteger cntAfter = 0;

	NSArray* monthes = [NSArray arrayWithObjects:@"January",@"February",@"March",@"April",@"May",@"June",@"Jule",@"August",@"September",@"October",@"November",@"December",nil];
	KalDate* std = [KalDate dateFromNSDate:startDate];
	titleLabel.text = [NSString stringWithFormat:@"%@ %d", [monthes objectAtIndex:[std month]-1], [std year]];
	
    KalDate* dt = nil;
	for(DateButton* btn in dateButtons)
	{
        
		if(daysToSkipBefore)
		{
			btn.enabled = NO;
            [btn setTitleColor:[UIColor colorWithRed:189/255.0f green:204/255.0f blue:210/255.0f alpha:1.0f] forState:UIControlStateNormal];
			dt = [daysBefore objectAtIndex:cntBefore];
            ++cntBefore;
			--daysToSkipBefore;
		} else if(daysCount)
		{
			dt = [daysMonth objectAtIndex:cnt];
			--daysCount;
			++cnt;
		} else
        {
            [btn setTitleColor:[UIColor colorWithRed:189/255.0f green:204/255.0f blue:210/255.0f alpha:1.0f] forState:UIControlStateNormal];
            dt = [daysAfter objectAtIndex:cntAfter];
            ++cntAfter;
        }
        
        [btn setTitle:[NSString stringWithFormat:@"%d", [dt day]] forState:UIControlStateNormal];
        btn.date = [dt NSDate];
        [btn addTarget:self action:@selector(didSelectDate:) forControlEvents:UIControlEventTouchUpInside];

		
	}
	
}

-(void) didSelectDate:(DateButton*)button
{
    [delegate didSelectDate:button.date];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/


- (void)dealloc 
{
	[titleLabel release];
	[logic release];
	[startDate release];
	[dateButtons release];
    [super dealloc];
}


@end
