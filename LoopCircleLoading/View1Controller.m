//
//  View1Controller.m
//  LoopCircleLoading
//
//  Created by jv on 2017/6/1.
//  Copyright © 2017年 jv. All rights reserved.
//

#import "View1Controller.h"
#import "LoopCircleLoadingView.h"

@interface View1Controller ()

@property (weak, nonatomic) IBOutlet LoopCircleLoadingView *loadingView;

@end

@implementation View1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
