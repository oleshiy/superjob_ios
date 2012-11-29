//
//  CJInfoViewController.h
//  CJCalendar
//
//  Created by Dmitry Sukhorukov on 11/29/12.
//  Copyright (c) 2012 Funny Codes. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CJInfoViewController;

@protocol CJInfoViewControllerDelegate
- (void)infoViewControllerDidFinish:(CJInfoViewController *)controller;
@end

@interface CJInfoViewController : UIViewController
{
}

@property (assign, nonatomic) id <CJInfoViewControllerDelegate> delegate;

- (IBAction)onBack:(id)sender;

@end
