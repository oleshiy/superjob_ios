//
//  Calendar.h
//  CJCalendar
//
//  Created by Dmitry Sukhorukov on 11/26/12.
//  Copyright (c) 2012 Funny Codes. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CXMLElement;
@interface Calendar : NSObject
{
    @private
    NSArray* monthes;
}

@property (nonatomic, retain) NSArray* monthes;

-(id) initWithXml:(CXMLElement*)el;

@end
