//
//  CLViewCell.h
//  ViewCell
//
//  Created by Cameron Lockey on 3/1/13.
//  Copyright (c) 2013 Fragment. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	CLViewCornersNone = 1,
	CLViewCornersTop = UIRectCornerTopLeft | UIRectCornerTopRight,
	CLViewCornersBottom = UIRectCornerBottomLeft | UIRectCornerBottomRight,
	CLViewCornersAll = UIRectCornerAllCorners
} CLViewCorners;

@interface CLViewCell : UIControl

@property (assign,nonatomic)				CLViewCorners		cornerType;
@property (strong,nonatomic)				UILabel				*title;
@property (strong,nonatomic)				UILabel				*detail;
@property (strong,nonatomic)				UIImageView			*accessory;
@property (strong,nonatomic)				UIImageView			*icon;
@property (strong,nonatomic)				UIView				*backgroundView;
@property (strong,nonatomic)				UIColor				*borderColor;
@property (strong,nonatomic)				UIColor				*cellColor;
@property (strong,nonatomic)				UIColor				*textColor;



// convenience methods
+(void)setBorderColor:(UIColor*)border_color CellColor:(UIColor*)cell_color TextColor:(UIColor*)text_color Shadow:(BOOL)shadow ShadowColor:(UIColor*)shadow_color RoundCorners:(BOOL)round_corners ForCells:(NSArray*)cells;
+(void)roundCornersForCells:(NSArray*)cells;

@end