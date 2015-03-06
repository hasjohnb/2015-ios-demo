//
//  TouchView.h
//  iosdemo
//
//  Created by John Bender on 3/5/15.
//  Copyright (c) 2015 TUNE, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TouchView : UIImageView
{
    BOOL isMoving;
    UITouch *movingTouch;
    CGSize touchOffset;
    CGPoint originalPosition;
}

@end
