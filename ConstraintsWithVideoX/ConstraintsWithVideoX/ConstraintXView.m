//
//  ConstraintXView.m
//  ConstraintsX
//
//  Created by Bayon Forte on 2/27/14.
//  Copyright (c) 2014 Mocura. All rights reserved.
//

#import "ConstraintXView.h"

@interface ConstraintXView () {
    
}

@end

@implementation ConstraintXView
@synthesize centerView = _centerView;
- (id)init {
	return [self initWithFrame:CGRectZero];
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
		self.backgroundColor = [UIColor blueColor];
		[self addSubview:self.centerView];
		[self setupConstraints];
	}
	return self;
}

- (void)updateConstraints {
	[super updateConstraints];
}

- (UIView *)centerView {
	if (_centerView == nil) {
		_centerView = [[UIView alloc] init];
		[_centerView setTranslatesAutoresizingMaskIntoConstraints:NO];
		_centerView.backgroundColor = [UIColor redColor];
	}
	return _centerView;
}

- (void)setupConstraints {
	// Width constraint : NSLayoutAttributeWidth
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.centerView
	                                                 attribute:NSLayoutAttributeWidth
	                                                 relatedBy:NSLayoutRelationEqual
	                                                    toItem:self
	                                                 attribute:NSLayoutAttributeWidth
	                                                multiplier:0.5
	                                                  constant:0]];

	// Height constraint : NSLayoutAttributeHeight
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.centerView
	                                                 attribute:NSLayoutAttributeHeight
	                                                 relatedBy:NSLayoutRelationEqual
	                                                    toItem:self
	                                                 attribute:NSLayoutAttributeHeight
	                                                multiplier:0.5
	                                                  constant:0]];

	// Center horizontally : NSLayoutAttributeCenterX
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.centerView
	                                                 attribute:NSLayoutAttributeCenterX
	                                                 relatedBy:NSLayoutRelationEqual
	                                                    toItem:self
	                                                 attribute:NSLayoutAttributeCenterX
	                                                multiplier:1.0
	                                                  constant:0.0]];

	// Center vertically : NSLayoutAttributeCenterY
	[self addConstraint:[NSLayoutConstraint constraintWithItem:self.centerView
	                                                 attribute:NSLayoutAttributeCenterY
	                                                 relatedBy:NSLayoutRelationEqual
	                                                    toItem:self
	                                                 attribute:NSLayoutAttributeCenterY
	                                                multiplier:1.0
	                                                  constant:0.0]];
}

@end
