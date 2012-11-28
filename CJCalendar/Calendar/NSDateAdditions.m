/* 
 * Copyright (c) 2009 Keith Lazuka
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "NSDateAdditions.h"

static NSCalendar* sharedCal = nil;

@implementation NSDate (KalAdditions)

+(NSCalendar*) sharedCal
{
    @synchronized(sharedCal)
    {
        if(!sharedCal)
        {
            sharedCal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            sharedCal.firstWeekday = 2;
        }
    }
    return sharedCal;
}

- (NSDate *)cc_dateByMovingToBeginningOfDay
{
  unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
  NSDateComponents* parts = [[NSDate sharedCal] components:flags fromDate:self];
  [parts setHour:0];
  [parts setMinute:0];
  [parts setSecond:0];
  return [[NSCalendar currentCalendar] dateFromComponents:parts];
}

- (NSDate *)cc_dateByMovingToEndOfDay
{
  unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
  NSDateComponents* parts = [[NSDate sharedCal]  components:flags fromDate:self];
  [parts setHour:23];
  [parts setMinute:59];
  [parts setSecond:59];
  return [[NSCalendar currentCalendar] dateFromComponents:parts];
}

- (NSDate *)cc_dateByMovingToFirstDayOfTheMonth
{
  NSDate *d = nil;
  BOOL ok = [[NSDate sharedCal]  rangeOfUnit:NSMonthCalendarUnit startDate:&d interval:NULL forDate:self];
  NSAssert1(ok, @"Failed to calculate the first day the month based on %@", self);
  return d;
}

- (NSDate *)cc_dateByMovingToFirstDayOfThePreviousMonth
{
  NSDateComponents *c = [[[NSDateComponents alloc] init] autorelease];
  c.month = -1;
  return [[[NSDate sharedCal]  dateByAddingComponents:c toDate:self options:0] cc_dateByMovingToFirstDayOfTheMonth];  
}

- (NSDate *)cc_dateByMovingToFirstDayOfTheFollowingMonth
{
  NSDateComponents *c = [[[NSDateComponents alloc] init] autorelease];
  c.month = 1;
  return [[[NSDate sharedCal]  dateByAddingComponents:c toDate:self options:0] cc_dateByMovingToFirstDayOfTheMonth];
}

- (NSDateComponents *)cc_componentsForMonthDayAndYear
{
  return [[NSDate sharedCal]  components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self];
}

- (NSUInteger)cc_weekday
{
    NSUInteger ret = [[NSDate sharedCal]  ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:self];
    return ret;
}

- (NSUInteger)cc_numberOfDaysInMonth
{
  return [[NSDate sharedCal]  rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self].length;
}

@end