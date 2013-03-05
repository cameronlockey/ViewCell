//
//  CLViewCell.m
//  ViewCell
//
//  Created by Cameron Lockey on 3/1/13.
//  Copyright (c) 2013 Fragment. All rights reserved.
//

#import "CLViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+Constraints.h"

#define CORNER_RADIUS 10
#define CORNER_RADII CGSizeMake(CORNER_RADIUS,CORNER_RADIUS)
#define INNER_CORNER_RADIUS 10.3
#define INNER_CORNER_RADII CGSizeMake(INNER_CORNER_RADIUS,INNER_CORNER_RADIUS)

@interface CLViewCell()

@end

@implementation CLViewCell

@synthesize title, detail, cornerType, backgroundView, accessory, icon;

-(id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) {
		UIColor *defaultTextColor = [UIColor blackColor];
		
		// set up labels
		title = [[UILabel alloc] init];
		title.backgroundColor = [UIColor clearColor];
		title.font = [UIFont boldSystemFontOfSize:14.0f];
		title.textColor = (self.textColor != nil) ? self.textColor : defaultTextColor;
		
		detail = [[UILabel alloc] init];
		detail.backgroundColor = [UIColor clearColor];
		detail.font = [UIFont systemFontOfSize:14.0f];
		detail.textColor = (self.textColor != nil) ? self.textColor : defaultTextColor;
		
		accessory = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
		icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
		
		self.backgroundColor = [UIColor clearColor];
		
		UIView *containerView = [[UIView alloc]initWithFrame:self.bounds];
		backgroundView = containerView;
		[self addSubview:backgroundView];
		[self addSubview:title];
		[self addSubview:detail];
		[self addSubview:accessory];
		[self addSubview:icon];

	}
	return self;
}

-(void)layoutSubviews
{	
	// set up constraints
	[self prepViewsForManualConstraints:self.subviews];
	
	// constrain labels to the left and to each other
	[self addConstraint:[NSLayoutConstraint constraintWithItem:title attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
	[self addConstraint:[NSLayoutConstraint constraintWithItem:detail attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
	[self addConstraint:[NSLayoutConstraint constraintWithItem:detail attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:title attribute:NSLayoutAttributeRight multiplier:1.0 constant:15]];
	
	// only set icon constraints if icon is set
	if (icon.image != nil) {
		// constrain icon to left of view
		[self addEqualityConstraintOn:NSLayoutAttributeCenterY forSubView:icon];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:icon attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:15]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:title attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:icon attribute:NSLayoutAttributeRight multiplier:1.0 constant:15]];
	}
	else
		[self addConstraint:[NSLayoutConstraint constraintWithItem:title attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:15]];
	
	// only set accessory constraints if accessory is set
	if (accessory.image != nil) {
		// constrain accessory to right of view
		[self addConstraint:[NSLayoutConstraint constraintWithItem:accessory attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-15]];
		[self addEqualityConstraintOn:NSLayoutAttributeCenterY forSubView:accessory];
	}
	
	[super layoutSubviews];
}

+(void)roundView:(UIView *)view onCorner:(UIRectCorner)rectCorner radius:(float)radius
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                   byRoundingCorners:rectCorner
                                                         cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    [view.layer setMask:maskLayer];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
	// default colors
	UIColor *defaultCellColor = [UIColor whiteColor];
	UIColor *defaultBorderColor = [UIColor lightGrayColor];
	
	// set the mask path as a regular rectangle, sized to view bounds
	CGRect fillFrame = CGRectMake(self.bounds.origin.x+0.3, self.bounds.origin.y+0.3, self.bounds.size.width-1.5, self.bounds.size.height-1.5);
	
	UIBezierPath *borderPath = [UIBezierPath bezierPathWithRect:self.bounds];
	UIBezierPath *fillPath = [UIBezierPath bezierPathWithRect:fillFrame];
	
	// modify the mask path if corners are specified
	switch (self.cornerType) {
		case CLViewCornersNone:
			break;
		case CLViewCornersTop:
			// Create the path (with only the top corners rounded)
			borderPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
														   byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
																 cornerRadii:CORNER_RADII];
			fillPath = [UIBezierPath bezierPathWithRoundedRect:fillFrame
														byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
															  cornerRadii:INNER_CORNER_RADII];
			break;
		case CLViewCornersBottom:
			// Create the path (with only the bottom corners rounded)
			borderPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
											 byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight
												   cornerRadii:CORNER_RADII];
			fillPath = [UIBezierPath bezierPathWithRoundedRect:fillFrame
											 byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight
												   cornerRadii:INNER_CORNER_RADII];
			break;
		case CLViewCornersAll:
			// Create the path (with all corners rounded)
			borderPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
											 byRoundingCorners:UIRectCornerAllCorners
												   cornerRadii:CORNER_RADII];
			fillPath = [UIBezierPath bezierPathWithRoundedRect:fillFrame
											   byRoundingCorners:UIRectCornerAllCorners
													 cornerRadii:INNER_CORNER_RADII];
			break;
		default:
			break;
	}
	
	// create the border layer
	CALayer *borderLayer = [CALayer layer];
	borderLayer.frame = self.bounds;
	borderLayer.backgroundColor = (self.borderColor != nil) ? self.borderColor.CGColor : defaultBorderColor.CGColor;
	CAShapeLayer *borderMask = [CAShapeLayer layer];
	borderMask.frame = self.bounds;
	borderMask.path = borderPath.CGPath;
	borderLayer.mask = borderMask;
	
	// create the fill layer
	CALayer *fillLayer = [CALayer layer];
	fillLayer.frame = fillFrame;
	fillLayer.backgroundColor = (self.cellColor) ? self.cellColor.CGColor : defaultCellColor.CGColor;
	CAShapeLayer *fillMask = [CAShapeLayer layer];
	fillMask.frame = fillFrame;
	fillMask.path = fillPath.CGPath;
	fillLayer.mask = fillMask;
	
	[self.backgroundView.layer addSublayer:borderLayer];
	[self.backgroundView.layer addSublayer:fillLayer];
	
	[title sizeToFit];
	[detail sizeToFit];
	[icon sizeToFit];
	[accessory sizeToFit];
	
}

+(void)setBorderColor:(UIColor *)border_color
			CellColor:(UIColor *)cell_color
			TextColor:(UIColor *)text_color
			   Shadow:(BOOL)shadow
		  ShadowColor:(UIColor *)shadow_color
		 RoundCorners:(BOOL)round_corners
			 ForCells:(NSArray *)cells
{
	for (CLViewCell *cell in cells)
	{
		// set border color
		if (border_color != nil)
			cell.borderColor = border_color;
		
		// set cell fill color
		if (cell_color)
			cell.cellColor = cell_color;
		
		// set text color
		if (text_color)
		{
			cell.title.textColor = text_color;
			cell.detail.textColor = text_color;
		}
		
		// set text shadow
		if (shadow) {
			UIColor *defaultShadowColor = [UIColor whiteColor];
			UIColor *shadowColor = (shadow_color != nil) ? shadow_color : defaultShadowColor;
			CGSize offset = CGSizeMake(0, 1);
			float radius = 0;
			float opacity = 0.4;
			cell.title.layer.shadowColor = shadowColor.CGColor;
			cell.title.layer.shadowOffset = offset;
			cell.title.layer.shadowRadius = radius;
			cell.title.layer.shadowOpacity = opacity;
			cell.detail.layer.shadowColor = shadowColor.CGColor;
			cell.detail.layer.shadowOffset = offset;
			cell.detail.layer.shadowRadius = radius;
			cell.detail.layer.shadowOpacity = opacity;
		}
	}
	
	if (round_corners)
		[self roundCornersForCells:cells];
}

+(void)roundCornersForCells:(NSArray *)cells
{
	for(CLViewCell *cell in cells)
	{
		if ([cell isEqual:[cells objectAtIndex:0]])
			cell.cornerType = CLViewCornersTop;
		else if ([cell isEqual:cells.lastObject])
			cell.cornerType = CLViewCornersBottom;
		else
			cell.cornerType = CLViewCornersNone;
	}
}

-(void)setHighlighted:(BOOL)highlighted
{
	[super setHighlighted:highlighted];
	
	CALayer *fillLayer = [self.backgroundView.layer.sublayers objectAtIndex:1];
	
	if (highlighted)
		fillLayer.backgroundColor = [UIColor lightTextColor].CGColor;
	else
		fillLayer.backgroundColor = [UIColor whiteColor].CGColor;
}

@end
