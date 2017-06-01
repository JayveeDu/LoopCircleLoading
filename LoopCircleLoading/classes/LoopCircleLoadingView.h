//
//  LoopCircleLoadingView.h
//  LoopCircleLoading
//
//  Created by jv on 2017/5/31.
//  Copyright © 2017年 jv. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 loading view
 */
@interface LoopCircleLoadingView : UIView

@property (strong, nonatomic) NSArray<UIColor *> *colors;//3 colors to switch
@property (assign, nonatomic) NSTimeInterval duration;//animation duration
@property (assign, nonatomic) CGFloat distance;//how long these circle move from the center
@property (assign, nonatomic) CGFloat size;//circle size

- (void)start;//start animation
- (void)stop;//stop animation

@end


/**
 circle view for loading
 */
@interface LoopCircleView : UIView

@property (strong, nonatomic) NSArray *colors;//colors to switch , only 3 colors

- (void)nextIndex;//make circle color to next

@end


