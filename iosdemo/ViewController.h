//
//  ViewController.h
//  iosdemo
//
//  Created by John Bender on 3/5/15.
//  Copyright (c) 2015 TUNE, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, copy) NSString *name;
@property (atomic, weak, readonly) NSArray *otherNames;

//void myMethod();
-(void) myMethod; // instance method
+(void) myMethod; // class method

@end

