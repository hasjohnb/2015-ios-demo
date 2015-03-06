//
//  TouchView.m
//  iosdemo
//
//  Created by John Bender on 3/5/15.
//  Copyright (c) 2015 TUNE, Inc. All rights reserved.
//

#import "TouchView.h"
#import <QuartzCore/QuartzCore.h>

@implementation TouchView

-(id) initWithFrame:(CGRect)frame
{
    if( self = [super initWithFrame:frame] ) {
        [self addBlanco];
    }
    return self;
}

-(void) awakeFromNib
{
    [self addBlanco];
}

-(void) addBlanco
{
    UIImage *blanco = [UIImage imageNamed:@"blanco.jpg"];
    self.image = blanco;
}

-(void) pickUp
{
    isMoving = TRUE;
    
    [self.superview bringSubviewToFront:self];

    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformMakeRotation(M_PI);
        // doesn't animate
        //self.layer.cornerRadius = self.frame.size.width/2.;
    }];
}

-(void) drop
{
    isMoving = FALSE;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.transform = CGAffineTransformMakeRotation(0.);
        //self.layer.cornerRadius = 0.;
    }];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if( isMoving ) return;
    
    movingTouch = [touches anyObject];
    CGPoint touchPoint = [movingTouch locationInView:self.superview];
    touchOffset = CGSizeMake( self.center.x - touchPoint.x,
                              self.center.y - touchPoint.y );
    originalPosition = self.center;
    [self pickUp];
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if( [touches containsObject:movingTouch] ) {
        CGPoint touchPoint = [movingTouch locationInView:self.superview];
        self.center = CGPointMake( touchPoint.x + touchOffset.width,
                                   touchPoint.y + touchOffset.height );
    }
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if( [touches containsObject:movingTouch] ) {
        [self drop];
        movingTouch = nil;
    }
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if( [touches containsObject:movingTouch] ) {
        movingTouch = nil;
        self.center = originalPosition;
        [self drop];
    }
}

@end
