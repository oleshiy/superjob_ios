//
//  CJInfoViewController.m
//  CJCalendar
//
//  Created by Dmitry Sukhorukov on 11/29/12.
//  Copyright (c) 2012 Funny Codes. All rights reserved.
//

#import "CJInfoViewController.h"

@interface CJInfoViewController ()

@end

@implementation CJInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBack:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate infoViewControllerDidFinish:self];
}

@end
