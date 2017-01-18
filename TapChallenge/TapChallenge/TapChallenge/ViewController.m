//
//  ViewController.m
//  TapChallenge
//
//  Created by Mariana Anitoiu on 13/01/17.
//  Copyright © 2017 Mariana Anitoiu. All rights reserved.
//

#import "ViewController.h"

#import <Foundation/Foundation.h>

#define GAMETIMER 1
#define GAMETIME 10
#define FirstAppLaunch @"FirstAppLaunch"

#define Defaults [NSUserDefaults standardUserDefaults]
#define Results @"UsersScore"

@interface ViewController (){
    int _tapsCount;
    int _timeCount;
    
    NSTimer *_gameTimer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initializeGame];
    self.tapsCountLabel.minimumScaleFactor = 0.5;
    [self.tapsCountLabel setAdjustsFontSizeToFitWidth:true];
}
-(void)viewDidAppear:(BOOL)animated{
    
    if([self firstAppLaunch] ==false){
        //app appena installata
        
        [Defaults setBool:true forKey:FirstAppLaunch];
        [Defaults synchronize];
    }else{
    
        if([self risultati].count > 0){
            NSNumber *value = [self risultati].lastObject;
            [self mostraUltimoRiosultato:value.intValue];
        }
    }
    
}


-(void)initializeGame{
    _tapsCount = 0;
    _timeCount  = GAMETIME;
    
    
    [self.tapsCountLabel setText:@"Tap to play"];
    [self.timeLabel setText:[NSString stringWithFormat:@"tap challenge  - %i sec", _timeCount]];
}


#pragma mark - Actions

-(IBAction)buttonPressed:(id)sender{
    
    
    //loggo in console il valore dei taps effettuati;
    NSLog(@"buttonPressed: %i", _tapsCount);
    
    
    // crea il timer se non c'è già
    if(_gameTimer == nil){
    _gameTimer = [NSTimer scheduledTimerWithTimeInterval:GAMETIMER target:self selector:@selector(timerTick) userInfo:nil repeats:true];
    }
    
    //incremento il mio taps counter
    _tapsCount++;
    
    
    //aggiorno il valore della label
    [self.tapsCountLabel setText:[NSString stringWithFormat:@"%i",_tapsCount]];
    
    
    
}
                  
                  
-(void)timerTick{
        NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _timeCount--;
    [self.timeLabel setText:[NSString stringWithFormat:@"%i sec", _timeCount]];
    
    if(_timeCount == 0){
        [_gameTimer invalidate];
        _gameTimer = nil;
        
       // [self initializeGame];
        
        NSString *massage = [NSString stringWithFormat:@"Hai fatto %i taps!!!",_tapsCount];
        
        UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"Game Over!" message:massage preferredStyle:UIAlertControllerStyleAlert];
        //fa la stessa cosa ma, viene fuori in basso alla schermata
        /*UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"Game Over!" message:massage preferredStyle:UIAlertControllerStyleActionSheet];*/
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
           // NSLog(@"OK ACTION PREMUTO");
            
            [self salvaRisultato];
            [self initializeGame];
            
            
        }];
        [alertViewController addAction:okAction];
        [self presentViewController:alertViewController animated:true completion:nil];
        
    }
}
- (IBAction)editingDidBegin:(id)sender {
}

#pragma mark -UI

-(void)mostraUltimoRiosultato:(int)risultato{
    //voglio che UIAlertController mi mostri al primo avvio dell'app il precedente risultato del mio utente;
    
   /* if([self risultato] == 0){
        
        NSString *message = [NSString stringWithFormat:@"Non hai mai giocato!"];
        UIAlertController*alertViewController = [UIAlertController alertControllerWithTitle:@"RESTART!" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK!" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            [self initializeGame];
            
        }];
        [alertViewController addAction:okAction];
        [self presentViewController:alertViewController animated:true completion:nil];
        
        
        
    }
        if([self risultato] != 0){
        NSString *message = [NSString stringWithFormat:@"Avevi fatto %i",risultato];
        UIAlertController*alertViewController = [UIAlertController alertControllerWithTitle:@"START!" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK!" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
             [self salvaRisultato];
            [self initializeGame];
            
        }];
        [alertViewController addAction:okAction];
        [self presentViewController:alertViewController animated:true completion:nil];
    }*/
    NSString *message = [NSString stringWithFormat:@"Il tuo miglior risultato: %i Taps!!!",risultato];
    UIAlertController*alertViewController = [UIAlertController alertControllerWithTitle:@"START!" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK!" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        [self initializeGame];
        
    }];
    [alertViewController addAction:okAction];
    [self presentViewController:alertViewController animated:true completion:nil];
    
}


#pragma mark - Persistenza

-(NSArray *)risultati{
    //ricavo i dati salvati dagli userDefaults:
    NSArray *array = [[Defaults objectForKey:Results]mutableCopy];
    if(array == nil){
        array = @[];
    }
    
    //loggo la variabile"value"
    
    NSLog(@"VALORE DAGLI USER DEFAULTS -> %@",array);
    return array;
}

-(void) salvaRisultato{
    
    NSMutableArray *array = [[Defaults objectForKey:Results]mutableCopy];
    if(array == nil){
        //OLD WAY
        //array = [[NSMutableArray alloc]init].mutableCopy;
        
        //new WAY
        array = @[].mutableCopy;
    }
    [array addObject:@(_tapsCount)];
    
    NSLog(@"mio array -> %@",array);
    //[[NSUserDefaults standardUserDefaults] setInteger:_tapsCount forKey:@"TapsCount"];
    
   // [setInteger:_tapsCount forKey:@"TapsCount"]
    //[[NSUserDefaults standardUserDefaults] synchronize];
    
   NSArray *arrayToBeSaved =
    [array sortedArrayUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
       
       
        int value1 = obj1.intValue;
        int value2 = obj2.intValue;
        if(value1 == value2){
            return NSOrderedSame;
        }
        if(value1 < value2){
            return NSOrderedAscending;
        }
        
            return NSOrderedDescending;
        
    }];
    
    [Defaults setObject:arrayToBeSaved forKey:Results];
    [Defaults synchronize];
}

-(bool)firstAppLaunch{
    return [[NSUserDefaults standardUserDefaults]boolForKey:FirstAppLaunch];
}


@end
