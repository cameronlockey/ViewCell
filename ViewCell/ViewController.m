//
//  ViewController.m
//  ViewCell
//
//  Created by Cameron Lockey on 3/1/13.
//  Copyright (c) 2013 Fragment. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"
#import "CLViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize viewCell, viewCell2, viewCell3;

- (void)viewDidLoad
{
    [super viewDidLoad];
		
	// set colors
	[CLViewCell setBorderColor:nil
					 CellColor:nil
					 TextColor:nil
						Shadow:YES
				   ShadowColor:nil
				  RoundCorners:YES
					  ForCells:[NSArray arrayWithObjects:viewCell, viewCell2, viewCell3, nil]];
	
	viewCell.title.text = @"Site Limitations:";
	viewCell2.title.text = @"Concerns:";
	viewCell3.title.text = @"Maintenance:";
	viewCell.detail.text = @"Whatever 123 lorem ipsum";
	viewCell2.detail.text = @"Whatever 123 lorem ipsum";
	viewCell3.detail.text = @"Whatever 123 lorem ipsum";
	viewCell.accessory.image = [UIImage imageNamed:@"disclosure-indicator.png"];
	viewCell2.accessory.image = [UIImage imageNamed:@"disclosure-indicator.png"];
	viewCell3.accessory.image = [UIImage imageNamed:@"disclosure-indicator.png"];
	viewCell.icon.image = [UIImage imageNamed:@"icon-map.png"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)testAction
{
	NSLog(@"test action called...");
}

- (IBAction)siteLimitationsTouched:(id)sender {
	NSLog(@"site limitations touched...");
}

@end
