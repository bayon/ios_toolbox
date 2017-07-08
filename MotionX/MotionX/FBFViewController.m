//
//  FBFViewController.m
//  MotionX
//
//  Created by Bayon Forte on 2/17/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "FBFViewController.h"

@interface FBFViewController ()

@end

@implementation FBFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Movement of pacman
    
	self.lastUpdateTime = [[NSDate alloc] init];
	self.currentPoint  = CGPointMake(0, 144);
	self.motionManager = [[CMMotionManager alloc]  init];
	self.queue         = [[NSOperationQueue alloc] init];
	self.motionManager.accelerometerUpdateInterval = kUpdateInterval;
	[self.motionManager startAccelerometerUpdatesToQueue:self.queue withHandler:
	 ^(CMAccelerometerData *accelerometerData, NSError *error) {
         [(id)self setAcceleration : accelerometerData.acceleration];
         [self performSelectorOnMainThread:@selector(update) withObject:nil waitUntilDone:NO];
     }];

}

- (void)movePacman {
    
    //check collisions
    [self collisionWithExit];
	[self collisionWithBoundaries];
    [self collsionWithWalls];
    
    
    
	self.previousPoint = self.currentPoint;
    
	// Move pacman to its new position
    
	CGRect frame = self.pacman.frame;
	frame.origin.x = self.currentPoint.x;
	frame.origin.y = self.currentPoint.y;
    
	self.pacman.frame = frame;
    
	// Rotate the sprite
    
	CGFloat newAngle = (self.pacmanXVelocity + self.pacmanYVelocity) * M_PI * 4;
	self.angle += newAngle * kUpdateInterval;
    
	CABasicAnimation *rotate;
	rotate                     = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
	rotate.fromValue           = [NSNumber numberWithFloat:0];
	rotate.toValue             = [NSNumber numberWithFloat:self.angle];
	rotate.duration            = kUpdateInterval;
	rotate.repeatCount         = 1;
	rotate.removedOnCompletion = NO;
	rotate.fillMode            = kCAFillModeForwards;
	[self.pacman.layer addAnimation:rotate forKey:@"10"];
}

- (void)update {
	NSTimeInterval secondsSinceLastDraw = -([self.lastUpdateTime timeIntervalSinceNow]);
    
	self.pacmanYVelocity = self.pacmanYVelocity - (self.acceleration.x * secondsSinceLastDraw);
	self.pacmanXVelocity = self.pacmanXVelocity - (self.acceleration.y * secondsSinceLastDraw);
    
	CGFloat xDelta = secondsSinceLastDraw * self.pacmanXVelocity * 500;
	CGFloat yDelta = secondsSinceLastDraw * self.pacmanYVelocity * 500;
    
	self.currentPoint = CGPointMake(self.currentPoint.x + xDelta,
	                                self.currentPoint.y + yDelta);
    
	[self movePacman];
    
	self.lastUpdateTime = [NSDate date];
}

- (void)collisionWithBoundaries {
	if (self.currentPoint.x < 0) {
		_currentPoint.x = 0;
		self.pacmanXVelocity = -(self.pacmanXVelocity / 2.0);
	}
    
	if (self.currentPoint.y < 0) {
		_currentPoint.y = 0;
		self.pacmanYVelocity = -(self.pacmanYVelocity / 2.0);
	}
    
	if (self.currentPoint.x > self.view.bounds.size.width - self.pacman.image.size.width) {
		_currentPoint.x = self.view.bounds.size.width - self.pacman.image.size.width;
		self.pacmanXVelocity = -(self.pacmanXVelocity / 2.0);
	}
    
	if (self.currentPoint.y > self.view.bounds.size.height - self.pacman.image.size.height) {
		_currentPoint.y = self.view.bounds.size.height - self.pacman.image.size.height;
		self.pacmanYVelocity = -(self.pacmanYVelocity / 2.0);
	}
}

- (void)collisionWithExit {
	if (CGRectIntersectsRect(self.pacman.frame, self.exit.frame)) {
		[self.motionManager stopAccelerometerUpdates];
        
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Congratulations"
		                                                message:@"You've won the game!"
		                                               delegate:self
		                                      cancelButtonTitle:@"OK"
		                                      otherButtonTitles:nil];
		[alert show];
	}
}
- (void)collsionWithWalls {
    
    CGRect frame = self.pacman.frame;
    frame.origin.x = self.currentPoint.x;
    frame.origin.y = self.currentPoint.y;
    
    for (UIImageView *image in self.wall) {
        
        if (CGRectIntersectsRect(frame, image.frame)) {
            
            // Compute collision angle
            CGPoint pacmanCenter = CGPointMake(frame.origin.x + (frame.size.width / 2),
                                               frame.origin.y + (frame.size.height / 2));
            CGPoint imageCenter  = CGPointMake(image.frame.origin.x + (image.frame.size.width / 2),
                                               image.frame.origin.y + (image.frame.size.height / 2));
            CGFloat angleX = pacmanCenter.x - imageCenter.x;
            CGFloat angleY = pacmanCenter.y - imageCenter.y;
            
            if (abs(angleX) > abs(angleY)) {
                _currentPoint.x = self.previousPoint.x;
                self.pacmanXVelocity = -(self.pacmanXVelocity / 2.0);
            } else {
                _currentPoint.y = self.previousPoint.y;
                self.pacmanYVelocity = -(self.pacmanYVelocity / 2.0);
            }
            
        }
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
