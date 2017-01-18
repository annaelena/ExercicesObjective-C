//
//  ViewController.m
//  SingleViewApplication
//
//  Created by Mariana Anitoiu on 11/01/17.
//  Copyright © 2017 Mariana Anitoiu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    int _tapCount;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    NSLog(@"1");
    
    NSString *stringa = @"Ciao";
    int number = 345;
    
    NSLog(@"Hello Word -> %@, %i, \n %@ \n %i", @"elena", 456, stringa,number);

    // Do any additional setup after loading the view, typically from a nib.
    
    [self.helloWorldLable setText:@"testo da codice"];
    //[self aggiornaTesto:@"nuovo testo"];
    
    NSArray *arrayStatico = @[@"prima stringa", @"seconda stringa", @1];
    NSLog(@"%@",arrayStatico);
    
    NSMutableArray *arrayMutabile = @[].mutableCopy;
    [arrayMutabile addObject:@"primo utente"];
    NSLog(@"%@",arrayMutabile);
    
    NSArray *arrayStatico2 = [[NSArray alloc] initWithObjects:@"prima stringa", @"seconda stringa", @1, nil];
    NSLog(@"%@",arrayStatico2);
    
    [self.userNameTextField setText:@"Mario"];
    
    _tapCount=0;
    [self.helloWorldLable setTextColor:[UIColor blackColor]];
    
}

-(void)aggiornaTesto : (NSString *)nuovoTesto{
    [self.helloWorldLable setText:nuovoTesto];
}

-(void)viewDidAppear:(BOOL)animated{
    
    for (int i= 0; i < 10; i++) {
        //sleep(1);
        NSString * string = [NSString stringWithFormat:@"%i",i];
        //[self aggiornaTesto:string];
        
        NSLog(@"%@",string);
    }

    NSLog(@"2");
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"3");
}

-(void)awakeFromNib{
    [super awakeFromNib];
    NSLog(@"4");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions


-(IBAction)userNameTextFieldDidEndOnExit:(id)sender{
    
    NSLog(@"userNameTextFieldDidEndOnExit");
    
}
-(IBAction)userNameTextFieldEditingDidEnd:(UITextField *)sender{
    NSLog(@"userNameTextFieldEditingDidEnd");
    NSLog(@"testo scritto dall'utente: %@", sender.text);
    
}

-(IBAction)buttonPressed:(id)sender{
    NSLog(@"button pressed correctly");
    
    _tapCount++;
    
    NSLog(@"tapCount -> %i\n",_tapCount );
    
    [self.helloWorldLable setText:[NSString stringWithFormat:@"%i",_tapCount]];
}

@end
