//
//  DateButton.m
//  BookInTouch
//
//  Created by Dmitry Sukhorukov on 3/4/11.
//  Copyright 2011 Funny Codes. All rights reserved.
//

#import "DateButton.h"


@implementation DateButton

@synthesize date;

-(void) dealloc
{
    [date release];
    [super dealloc];
}
@end
