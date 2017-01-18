//
//  ViewController.h
//  SingleViewApplication
//
//  Created by Mariana Anitoiu on 11/01/17.
//  Copyright © 2017 Mariana Anitoiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic , weak) IBOutlet  UILabel * helloWorldLable;

@property (nonatomic, weak) IBOutlet UITextField *userNameTextField;

-(IBAction)userNameTextFieldDidEndOnExit:(id)sender;
-(IBAction)userNameTextFieldEditingDidEnd:(id)sender;
-(IBAction)buttonPressed:(id)sender;
@end

