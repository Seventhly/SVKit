//
//  SVViewController.m
//  SVKit
//
//  Created by clac_0007@163.com on 10/20/2017.
//  Copyright (c) 2017 clac_0007@163.com. All rights reserved.
//

#import "SVViewController.h"
#import <SVKit/SVKit-umbrella.h>

@interface SVViewController ()

@end

@implementation SVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *string = @"123hans在111";
    BOOL result = [string sv_haveChinese];
    NSInteger count = [string sv_numberCount];
    NSLog(@"result = %d count = %ld",result,count);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
