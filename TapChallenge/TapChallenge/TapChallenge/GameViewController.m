//
//  ViewController.m
//  TapChallenge
//
//  Created by Mariana Anitoiu on 13/01/17.
//  Copyright © 2017 Mariana Anitoiu. All rights reserved.
//

#import "GameViewController.h"
#import "ScoreTableViewController.h"

#import <Foundation/Foundation.h>

#define GAMETIMER 1
#define GAMETIME 10
#define FirstAppLaunch @"FirstAppLaunch"

#define Defaults [NSUserDefaults standardUserDefaults]
#define Results @"UsersScore"

@interface GameViewController (){
    int _tapsCount;
    int _timeCount;
    
    NSTimer *_gameTimer;
}

@end



@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   
    self.tapsCountLabel.minimumScaleFactor = 0.5;
    [self.tapsCountLabel setAdjustsFontSizeToFitWidth:true];
    
    [self initializeGame];
    
    
    //Setto il navigatore bar title
    self.title = @"Tap challenge";
    
    
    
    //creo un pulsante che andrò a mettere dentro la navigationBar
    UIBarButtonItem *scoreButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(scoreButtonPressed)];
    
    
    //imposto il pulsante come elemento alla DX della mia navigation bar
    self.navigationItem.rightBarButtonItem = scoreButtonItem;
}
-(void)viewDidAppear:(BOOL)animated{
    
    
    //METODO SATANDARD PER IL PRIMO LANCIO DELL'APP
   /* if([self firstAppLaunch] ==false){
        //app appena installata
        
        [Defaults setBool:true forKey:FirstAppLaunch];
        [Defaults synchronize];
    }else{
    
        if([self risultati].count > 0){
            NSNumber *value = [self risultati].lastObject;
            [self mostraUltimoRiosultato:value.intValue];
        }
    }*/
    
    [self resumeGame];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [self pauseGame];
}


-(void)initializeGame{
    _tapsCount = 0;
    _timeCount  = GAMETIME;
    
    
    [self.tapsCountLabel setText:@"Tap to play"];
    [self.timeLabel setText:[NSString stringWithFormat:@"tap challenge  - %i sec", _timeCount]];
}


#pragma mark -Play / Pause game

-(void)pauseGame{
    if(_gameTimer != nil){
        
        [_gameTimer invalidate];
        
        _gameTimer = nil;
    }
}

-(void)resumeGame{
    
    if(_timeCount !=0 && _tapsCount >0){
        
        _gameTimer = [NSTimer scheduledTimerWithTimeInterval:GAMETIMER target:self selector:@selector(timerTick) userInfo:nil repeats:true];
    }
}

#pragma mark - Actions


-(void)scoreButtonPressed{
    
    
    //es. creazione di un ViewController da codice
    
    /*UIViewController *viewController = [[UIViewController alloc]init];
     
    //setto il titolo
    viewController.title =@"nuovo";
     
     //prsonalizzo il colore dello sfondo
    viewController.view.backgroundColor = [UIColor redColor];*/
    
    
    //prendo dalla storyboard il mio VC con storyBoardID "ScoreTableViewController"
    ScoreTableViewController *tableViewController =
    [self.storyboard instantiateViewControllerWithIdentifier:@"ScoreTableViewController"];
    
    
    //prendo i risultati del mio utente e li passo allo scoreVC
    // NSArray *resultArray = [self risultati];
    //[tableViewController setScoresArray:resultArray];
    
    
    //instauro il collegamewnto tra GameVC e ScoreVC attraverso il Delegate
    tableViewController.delegate = self;
    
    
    //push all'interno dello stack del mio navigationController un nuovo ViewContr
    [self.navigationController pushViewController:tableViewController animated:true];
}


-(IBAction)tapGestureRecognizerDidRecognizeTap:(id)sender{
    
    //loggo in console il valore dei taps effettuati;
    NSLog(@"buttonPressed: %i", _tapsCount);
    
    
    // crea il timer solo se serve
    if(_gameTimer == nil){
        _gameTimer = [NSTimer scheduledTimerWithTimeInterval:GAMETIMER target:self selector:@selector(timerTick) userInfo:nil repeats:true];
    }
    
    //incremento il mio taps counter
    _tapsCount++;
    
    
    //aggiorno il valore della label
    [self.tapsCountLabel setText:[NSString stringWithFormat:@"%i",_tapsCount]];
    

}

-(IBAction)buttonPressed:(id)sender{
    
    
    //loggo in console il valore dei taps effettuati;
    /*NSLog(@"buttonPressed: %i", _tapsCount);
    
    
    // crea il timer se non c'è già
    if(_gameTimer == nil){
    _gameTimer = [NSTimer scheduledTimerWithTimeInterval:GAMETIMER target:self selector:@selector(timerTick) userInfo:nil repeats:true];
    }
    
    //incremento il mio taps counter
    _tapsCount++;
    
    
    //aggiorno il valore della label
    [self.tapsCountLabel setText:[NSString stringWithFormat:@"%i",_tapsCount]];*/
    
    
    
}
                  
                  
-(void)timerTick{
    
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    _timeCount--;
    
    
    [self.timeLabel setText:[NSString stringWithFormat:@"%i sec", _timeCount]];
    
    
    //gime over
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
            
            //salvo i dati utente
            [self salvaRisultato];
            
           //inizializzo tutte le variabili di gioco al vaolore iniziale
            [self initializeGame];
            }];
        alertViewController.view.backgroundColor = [UIColor yellowColor];
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
    
    UIAlertController*alertViewController = [UIAlertController alertControllerWithTitle:@"Wall of fame!" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK!" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        
        //non faccio nulla
        //[self initializeGame];
        
    }];
    [alertViewController addAction:okAction];
    [self presentViewController:alertViewController animated:true completion:nil];
    
}


#pragma mark - Persistenza

-(NSArray *)risultati{
    
    //ricavo i dati salvati dagli userDefaults:
    
    NSArray *array = [[Defaults objectForKey:Results]mutableCopy];
    
    if(array == nil){
        
        array = @[]; //inizializzo un array STATICO
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
    
    //OLD WAY
    //NSNumber *number = [NSNumber numberWithInt:_tapsCount];
    
    
    // NEW WAY
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
        if(value1 > value2){
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

#pragma mark - ScoreTableViewDelegate


-(NSArray *)scoreTableViewFetchResults{
    
    return [self risultati];
}


-(void)scoreTableViewDidFetchResults{
    
    NSLog(@"%s",__PRETTY_FUNCTION__);
}


@end
