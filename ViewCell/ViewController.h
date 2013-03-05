//
//  ViewController.h
//  ViewCell
//
//  Created by Cameron Lockey on 3/1/13.
//  Copyright (c) 2013 Fragment. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CLViewCell;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet CLViewCell *viewCell;
@property (weak, nonatomic) IBOutlet CLViewCell *viewCell2;
@property (weak, nonatomic) IBOutlet CLViewCell *viewCell3;

-(void)testAction;
- (IBAction)siteLimitationsTouched:(id)sender;

@end
