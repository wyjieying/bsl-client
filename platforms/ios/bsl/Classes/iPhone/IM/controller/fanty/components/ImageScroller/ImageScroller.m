//
//  ImageScroller.m
//  cube-ios
//
//  Created by apple2310 on 13-9-10.
//
//

#import "ImageScroller.h"
#import "AsyncImageView.h"

#import "GTGZImageDownloadedManager.h"
#import <QuartzCore/QuartzCore.h>

@implementation ImageScroller

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled=YES;
        frame=self.bounds;
        frame.origin.x=20.0f;
        frame.origin.y=20.0f;
        frame.size.width-=40.0f;
        frame.size.height-=40.0f;
        imageView=[[UIImageView alloc] initWithFrame:frame];
        imageView.contentMode=UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        
        self.backgroundColor=[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.75f];
    }
    return self;
}


-(void)showInView:(UIView*)view{
    [view addSubview:self];
    
    
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [imageView.layer addAnimation:animation forKey:nil];

    self.alpha=0.0f;
    [UIView animateWithDuration:0.1f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.alpha=1.0f;
    } completion:^(BOOL finish){
        
    }];

    
}

-(void)showImage:(NSString*)url{
    imageView.image=[[GTGZImageDownloadedManager sharedInstance] originImageByUrl:url];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
    
        self.alpha=0.0f;
    } completion:^(BOOL finish){
    
        [self removeFromSuperview];
    }];
}

@end
