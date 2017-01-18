//
//  ViewController.h
//  TapChallenge
//
//  Created by Mariana Anitoiu on 13/01/17.
//  Copyright © 2017 Mariana Anitoiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(nonatomic,weak) IBOutlet UILabel *tapsCountLabel;
@property(nonatomic,weak) IBOutlet UILabel *timeLabel;
@property(nonatomic,weak) IBOutlet UITextField *text;
-(IBAction)buttonPressed:(id)sender;


@end

