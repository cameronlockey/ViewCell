//
//  UIView+Constraints.h
//  ViewCell
//
//  Created by Cameron Lockey on 3/4/13.
//  Copyright (c) 2013 Fragment. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Constraints)

-(void)addEqualityConstraintOn:(NSLayoutAttribute)attribute forSubView:(UIView*)subview;
-(void)prepForManualConstraints:(UIView*)subview;
-(void)prepViewsForManualConstraints:(NSArray*)subviews;
-(void)centerViewsVertically:(NSArray*)subviews;

@end
