//
//  JXCustomDownLoadBtn.m
//  TestFontAutoSize
//
//  Created by Joseph_Xuan on 17/6/2.
//  Copyright © 2017年 Joseph_Xuan. All rights reserved.
//

#import "JXCustomDownLoadBtn.h"

static NSTimeInterval defaultDuration = 1.0f;

static BOOL _isIgnoreEvent = NO;

static void resetState() {
    
    _isIgnoreEvent = NO;
}

@implementation JXCustomDownLoadBtn
- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if ([self isKindOfClass:[UIButton class]]) {
        
        self.clickDurationTime = self.clickDurationTime == 0 ? defaultDuration : self.clickDurationTime;
        
        if (_isIgnoreEvent) {
            
            return;
        }else if (self.clickDurationTime > 0) {
            
            _isIgnoreEvent = YES;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.clickDurationTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                resetState();
            });
            
            [super sendAction:action to:target forEvent:event];
        }
    }
    else {
        
        [super sendAction:action to:target forEvent:event];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
