//
//  ViewController.m
//  iosdemo
//
//  Created by John Bender on 3/5/15.
//  Copyright (c) 2015 TUNE, Inc. All rights reserved.
//

#import "ViewController.h"
#import "TouchView.h"
#import "UIColor+RandomColor.h"

@interface ViewController ()
{
    IBOutlet UILabel *nameLabel;
    
    UIDynamicAnimator *animator;
    NSArray *bubbles;
}

@property (nonatomic, copy) NSString *secondName;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSMutableArray *array = [NSMutableArray array];
    for( UIView *v in self.view.subviews )
        if( [v class] == [TouchView class] )
            [array addObject:v];
    bubbles = [NSArray arrayWithArray:array];
    
    NSDictionary *dict;
    //dict = [NSDictionary new];
    // dict = new NSDictionary();
    dict = [NSDictionary alloc];
    dict = [dict init];
    
    NSDictionary *dict2 = [NSDictionary dictionaryWithDictionary:dict];
    // dict2 = NSDictionary.dictionaryWithDictionary(dict);
    
    dict2 = [NSDictionary dictionaryWithObject:dict
                                        forKey:@"DictKey"];
    // dict2 = NSDictionary.dictionaryWithObjectForKey(dict, @"DictKey");
    
    NSDictionary *dict3 = @{@"MyKey": dict2};
    
    id value = [dict3 objectForKey:@"MyKey23523432"];
    value = dict3[@"MyKey2345346"];
    
    //dict3[@"newKey"] = @"NewVal";
    NSMutableDictionary *muteDict = [NSMutableDictionary dictionaryWithDictionary:dict3];
    muteDict[@"newKey"] = @"NewVal";
    dict3 = [NSDictionary dictionaryWithDictionary:muteDict];
    
    //nil == NULL == 0 == FALSE == NO
    NSString *desc = [value description];
    NSLog(@"%@", desc);
    
    NSArray *a = nil;
    NSLog(@"%d", [a count]);
    if([a count] > 0) {
        // do stuff
        NSLog( @"has objects" );
    }
    
    [self doSomethingWithFirstThing:dict
                     andSecondThing:dict2
                            andThis:dict3];
    
    self.name = @"John"; // [self setName:@"John"];
    NSLog( @"name is %@", _name );
    
    nameLabel.text = _name;
}

// void doXWithYAndZ(Object x, Object y, Object z);
-(void) doSomethingWithFirstThing:(NSObject*)x
                   andSecondThing:(NSObject*)y
                          andThis:(NSObject*)z
{
    // doSomethingWithThis:andThis:
    // doSomethingWithThis:
    NSLog( @"x is %@", x );
    NSLog( @"y is %@", y );
}

-(void) doSomethingWithThis:(NSObject*)obj1
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) changeName
{
    self.name = @"Peter";
}

-(IBAction) pressedChangeNameButton
{
    [self changeName];
    nameLabel.text = self.name;

    CGFloat x = self.view.frame.size.width*(CGFloat)rand()/(CGFloat)RAND_MAX;
    CGFloat y = self.view.frame.size.height*(CGFloat)rand()/(CGFloat)RAND_MAX;
    TouchView *tv = [[TouchView alloc] initWithFrame:CGRectMake( x, y, 44., 44. )];
    tv.backgroundColor = [UIColor randomColorWithAlpha:0.9];
    [self.view addSubview:tv];

    NSMutableArray *array = [NSMutableArray arrayWithArray:bubbles];
    [array addObject:tv];
    bubbles = [NSArray arrayWithArray:array];
}

-(IBAction) pressedDropButton
{
    animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UIDynamicItemBehavior *objects = [UIDynamicItemBehavior new];
    objects.density = 0.0000001;
    objects.elasticity = 0.5;
    
    UICollisionBehavior *collision = [UICollisionBehavior new];
    [collision setTranslatesReferenceBoundsIntoBoundaryWithInsets:UIEdgeInsetsZero];
    [objects addChildBehavior:collision];
    
    UIGravityBehavior *gravity = [UIGravityBehavior new];
    gravity.magnitude = 0.5;
    gravity.gravityDirection = CGVectorMake( 0., 1. );
    
    [animator addBehavior:objects];
    [animator addBehavior:gravity];
    [animator addBehavior:collision];
    
    for( UIView *v in bubbles ) {
        [gravity addItem:v];
        [objects addItem:v];
        [collision addItem:v];
    }
}

-(void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if( motion == UIEventSubtypeMotionShake ) {
        for( UIView *b in bubbles )
            [UIView animateWithDuration:0.5
                             animations:
             ^{
                 b.frame = CGRectMake( b.frame.origin.x + b.frame.size.width/2.,
                                       b.frame.origin.y + b.frame.size.height/2.,
                                       0., 0. );
             } completion:^(BOOL finished)
             {
                 [b removeFromSuperview];
             }];
        bubbles = [NSArray array];
    }
}

@end
