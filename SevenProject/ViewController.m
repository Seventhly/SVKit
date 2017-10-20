//
//  ViewController.m
//  SevenProject
//
//  Created by kuaiqian on 2017/9/29.
//  Copyright © 2017年 Seven. All rights reserved.
//

#import "ViewController.h"
#import "SVCameraTool.h"

#import "SVConditionTextField.h"
#import "NSString+SVAmount.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet SVConditionTextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.textField.conditionType = SVConditionType_Alphanumeric;
    self.textField.maxLength = 10;
    
    NSString *amount = @"123456.789";
    NSLog(@"amount = %@",[amount sv_bankAmountCode]);
    
}

- (IBAction)buttonAction:(id)sender {
    [[SVCameraTool shareInstance] showCameraViewControllerWithType:SVCamerPicker delegate:self imageBlock:^(UIImage *image) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
