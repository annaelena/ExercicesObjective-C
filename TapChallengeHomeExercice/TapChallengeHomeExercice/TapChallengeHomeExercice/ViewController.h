//
//  ViewController.h
//  TapChallengeHomeExercice
//
//  Created by Mariana Anitoiu on 18/01/17.
//  Copyright © 2017 Mariana Anitoiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *tapsCountLabel;
@property(nonatomic,weak) IBOutlet UILabel *timeLabel;

-(IBAction)buttonPressed:(id)sender;


@end

