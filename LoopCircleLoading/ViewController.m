//
//  ViewController.m
//  LoopCircleLoading
//
//  Created by jv on 2017/5/31.
//  Copyright © 2017年 jv. All rights reserved.
//

#import "ViewController.h"
#import "LoopCircleLoadingView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet LoopCircleLoadingView *loadingView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _loadingView.backgroundColor = [UIColor cyanColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_loadingView start];

}


- (void)viewWillDisappear:(BOOL)animated {
    
    [_loadingView stop];
    
    [super viewWillDisappear:animated];
}



@end
