//
//  DateButton.h
//  BookInTouch
//
//  Created by Dmitry Sukhorukov on 3/4/11.
//  Copyright 2011 Funny Codes. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DateButton : UIButton {
@private
    NSDate* date;
}
@property (nonatomic, retain) NSDate* date;
@end
