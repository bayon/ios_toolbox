//
//  FBFViewController.m
//  DragDropDeluxeX
//
//  Created by Bayon Forte on 2/27/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "FBFViewController.h"

//THANKS TO: http://www.raywenderlich.com/50197/uikit-dynamics-tutorial

// should redo this tutorial at a few different stages...


/*
 @protocol UIDynamicItem <NSObject>
 
 @property (nonatomic, readwrite) CGPoint center;
 @property (nonatomic, readonly) CGRect bounds;
 @property (nonatomic, readwrite) CGAffineTransform transform;
 
 @end
 */
@interface FBFViewController () <UICollisionBehaviorDelegate>
{
	UIDynamicAnimator *_animator;
	UIGravityBehavior *_gravity;
	UICollisionBehavior *_collision;
    
    BOOL _firstContact;
}

@end

@implementation FBFViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    
    _collision.collisionDelegate = self;
    
    
    //square
	UIView *square = [[UIView alloc] initWithFrame:
	                  CGRectMake(100, 100, 100, 100)];
	square.backgroundColor = [UIColor grayColor];
	[self.view addSubview:square];
    
    //barrier
    UIView* barrier = [[UIView alloc] initWithFrame:CGRectMake(0, 300, 130, 20)];
    barrier.backgroundColor = [UIColor redColor];
    [self.view addSubview:barrier];
    
    
    
    
    //gravity
	_animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
	_gravity = [[UIGravityBehavior alloc] initWithItems:@[square]];
	[_animator addBehavior:_gravity];
    
	//collision
	//_collision = [[UICollisionBehavior alloc] initWithItems:@[square]];
    //_collision = [[UICollisionBehavior alloc] initWithItems:@[square, barrier]]; //interesting collision
    _collision = [[UICollisionBehavior alloc] initWithItems:@[square]];
	_collision.translatesReferenceBoundsIntoBoundary = YES;
	[_animator addBehavior:_collision];
    
    // add a boundary that coincides with the top edge
    CGPoint rightEdge = CGPointMake(barrier.frame.origin.x +
                                    barrier.frame.size.width, barrier.frame.origin.y);
    [_collision addBoundaryWithIdentifier:@"barrier"
                                fromPoint:barrier.frame.origin
                                  toPoint:rightEdge];
    
    _collision.action =  ^{
        NSLog(@"%@, %@",
              NSStringFromCGAffineTransform(square.transform),
              NSStringFromCGPoint(square.center));
        
    };
    
    //dynamic behavior
    UIDynamicItemBehavior* itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:@[square]];
    itemBehaviour.elasticity = 0.6;
    [_animator addBehavior:itemBehaviour];
    
    /*
     
     elasticity – determines how ‘elastic’ collisions will be, i.e. how bouncy or ‘rubbery’ the item behaves in collisions.
     friction – determines the amount of resistance to movement when sliding along a surface.
     density – when combined with size, this will give the overall mass of an item. The greater the mass, the harder it is to accelerate or decelerate an object.
     resistance – determines the amount of resistance to any linear movement. This is in contrast to friction, which only applies to sliding movements.
     angularResistance – determines the amount of resistance to any rotational movement.
     allowsRotation – this is an interesting one that doesn’t model any real-world physics property. With this property set to NO the object will not rotate at all, regardless of any rotational forces that occur.
     */
    
}

- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item
   withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p {
    NSLog(@"Boundary contact occurred - %@", identifier);
    UIView* view = (UIView*)item;
    view.backgroundColor = [UIColor yellowColor];
    [UIView animateWithDuration:0.3 animations:^{
        view.backgroundColor = [UIColor grayColor];
    }];
    
    if (!_firstContact)
    {
        _firstContact = YES;
        
        UIView* square = [[UIView alloc] initWithFrame:CGRectMake(30, 0, 100, 100)];
        square.backgroundColor = [UIColor grayColor];
        [self.view addSubview:square];
        
        [_collision addItem:square];
        [_gravity addItem:square];
        
        UIAttachmentBehavior* attach = [[UIAttachmentBehavior alloc] initWithItem:view
                                                                   attachedToItem:square];
        [_animator addBehavior:attach];
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
