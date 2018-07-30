//
//  ViewController.m
//  RepeatBnt
//
//  Created by admin on 2018/7/30.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    UIButton *bnt = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 100, 50)];
    [bnt setTitle:@"点击" forState:UIControlStateNormal];
    [bnt addTarget:self action:@selector(bntTaget) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bnt];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)bntTaget{
    NSLog(@"点击");
}


@end
