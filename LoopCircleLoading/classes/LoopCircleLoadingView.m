//
//  LoopCircleLoadingView.m
//  LoopCircleLoading
//
//  Created by jv on 2017/5/31.
//  Copyright © 2017年 jv. All rights reserved.
//

#import "LoopCircleLoadingView.h"

static CGFloat const kDefaultSize = 10;//default circle size
static CGFloat const kDefaultDistance = 20;//default distance from center
static CGFloat const kDefaultDuration = 1;//default animation duration
static NSString* const kAnimationLayerName = @"moveAnim";//animation key for layer

@interface LoopCircleLoadingView ()<CAAnimationDelegate>
{
    NSArray *_defaultColors;//default colors
    CGFloat _leftCenter;//left circle center x
    CGFloat _rightCenter;//right circle center x
    NSTimer *_timer;//timer to monitor moving layer center x
    CGFloat _leftColorChangedPoint;//left point to change next color
    CGFloat _rightColorChangedPoint;//right point to change next color
    BOOL _colorChangedFlag;//change color flag, decide when to change color, NO and moving right or YES and moving left change color
}

@property (strong, nonatomic) LoopCircleView *leftCircle;//left circle view
@property (strong, nonatomic) LoopCircleView *middleCircle;//middle circle view
@property (strong, nonatomic) LoopCircleView *rightCircle;//right circle view

@end

@implementation LoopCircleLoadingView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    
    _defaultColors = @[[UIColor redColor],[UIColor greenColor],[UIColor blueColor]];
    _duration = kDefaultDuration;
    _distance = kDefaultDistance;
    
    
}

- (void)dealloc {
    
#if DEBUG
    NSLog(@"%s",__FUNCTION__);
#endif
 
    
}

#pragma mark - object method

- (void)start {
    
    [self _checkInit];
    
    _duration = _duration <= 0 ? kDefaultDuration : _duration;
    
    
    [_leftCircle.layer addAnimation:[self _crateMoveAnimationWithTargetValue:@(_rightCenter)] forKey:kAnimationLayerName];
    [_rightCircle.layer addAnimation:[self _crateMoveAnimationWithTargetValue:@(_leftCenter)] forKey:kAnimationLayerName];

    
    [_timer invalidate];
    _timer = [NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(_watchAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];


}

- (void)stop {
    
    [_timer invalidate];
    [_rightCircle.layer removeAllAnimations];
    [_leftCircle.layer removeAllAnimations];
    
}

#pragma mark - action

- (void)_watchAction {
    
    
    CGFloat x = _leftCircle.layer.presentationLayer.position.x;
    
    if ((!_colorChangedFlag && x >= _rightColorChangedPoint) || (_colorChangedFlag && x <= _leftColorChangedPoint)) {
        
        [self _nextColor];
        _colorChangedFlag = !_colorChangedFlag;
    }
    
}


#pragma mark - method



- (CABasicAnimation *)_crateMoveAnimationWithTargetValue:(id)value{
    
    CABasicAnimation *moveAnim = [CABasicAnimation animationWithKeyPath:@"position.x"];
    moveAnim.toValue = value;
    moveAnim.duration = _duration;
    moveAnim.autoreverses = YES;
    moveAnim.repeatCount = HUGE_VAL;
    moveAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    return moveAnim;
}

- (void)_nextColor {
    
    [_leftCircle nextIndex];
    [_middleCircle nextIndex];
    [_rightCircle nextIndex];
    [_leftCircle setNeedsDisplay];
    [_middleCircle setNeedsDisplay];
    [_rightCircle setNeedsDisplay];
}

- (void)_checkInit {
    
    if (!_leftCircle || !_middleCircle || !_rightCircle) {
        
        CGFloat size = _size <= 0 ? kDefaultSize : _size;
        NSArray<UIColor *> *colors = _colors.count > 3 ? _colors : _defaultColors;
        _distance = _distance <= 0 ? kDefaultDistance : _distance;
        
        _leftCircle = [LoopCircleView new];
        _leftCircle.colors = colors;
        [self addSubview:_leftCircle];
        
        _middleCircle = [LoopCircleView new];
        _middleCircle.colors = @[colors[1],colors[2],colors[0]];
        [self addSubview:_middleCircle];
        
        _rightCircle = [LoopCircleView new];
        _rightCircle.colors = @[colors[2],colors[0],colors[1]];
        [self addSubview:_rightCircle];
        
        CGRect frame = _middleCircle.frame;
        frame.size = CGSizeMake(size, size);
        frame.origin.x = (CGRectGetWidth(self.frame) - size) / 2;
        frame.origin.y = (CGRectGetHeight(self.frame) - size) / 2;
        _middleCircle.frame = frame;
        
        CGFloat left = CGRectGetMinX(_middleCircle.frame) - _distance - size;
        _leftCircle.frame = (CGRect){left, CGRectGetMinY(_middleCircle.frame),size,size};
        _leftCenter = _leftCircle.center.x;

        CGFloat right = CGRectGetMaxX(_middleCircle.frame) + _distance;
        _rightCircle.frame = (CGRect){right,CGRectGetMinY(_middleCircle.frame),size,size};
        _rightCenter = _rightCircle.center.x;

        _leftColorChangedPoint = _middleCircle.center.x;
        _rightColorChangedPoint = _middleCircle.center.x;

    }
    
    
}


@end


#pragma mark - LoopCircleView

@interface LoopCircleView ()

@property (assign, nonatomic) int currentIndex;

@end


@implementation LoopCircleView

#pragma mark - life cycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)setup {
    self.backgroundColor = [UIColor clearColor];
    _currentIndex = 0;
}


- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect)));
    UIColor *color = _colors[_currentIndex];
    [color set];
    CGContextFillPath(ctx);
    
}

#pragma mark - object method

- (void)nextIndex {
    
    _currentIndex++;
    
    if (_currentIndex > 2 || _currentIndex < 0) {
        _currentIndex = 0;
    }
    
}

@end



