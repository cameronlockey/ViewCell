//
//  UIView+Constraints.m
//  ViewCell
//
//  Created by Cameron Lockey on 3/4/13.
//  Copyright (c) 2013 Fragment. All rights reserved.
//

#import "UIView+Constraints.h"

@implementation UIView (Constraints)

-(void)addEqualityConstraintOn:(NSLayoutAttribute)attribute forSubView:(UIView *)subview
{
	[self addConstraint:[NSLayoutConstraint constraintWithItem:subview attribute:attribute relatedBy:NSLayoutRelationEqual toItem:self attribute:attribute multiplier:1.0 constant:0]];
}

-(void)prepForManualConstraints:(UIView *)subview
{
	subview.translatesAutoresizingMaskIntoConstraints = NO;
}

-(void)prepViewsForManualConstraints:(NSArray *)subviews
{
	for (UIView *view in subviews) {
		[self prepForManualConstraints:view];
	}
}

-(void)centerViewsVertically:(NSArray *)subviews
{
	for (id view in subviews) {
		[self addEqualityConstraintOn:NSLayoutAttributeCenterY forSubView:view];
	}
}
@end
