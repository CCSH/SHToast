//
//  ViewController.m
//  SHToast
//
//  Created by CSH on 2017/8/16.
//  Copyright © 2017年 CSH. All rights reserved.
//

#import "ViewController.h"
#import "SHToast.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [SHToastStyle share].textColor = [UIColor orangeColor];
}

- (IBAction)toast:(id)sender {

    [SHToast showWithText:@"我是Toast"];
}
- (IBAction)push:(id)sender {
    
    [SHToast showPushWithContent:@"我是push内容"
                    title:@"推送" image:[UIImage new] block:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
