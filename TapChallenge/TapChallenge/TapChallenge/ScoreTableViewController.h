//
//  ScoreTableViewController.h
//  TapChallenge
//
//  Created by Mariana Anitoiu on 18/01/17.
//  Copyright © 2017 Mariana Anitoiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScoreTableViewDelegate <NSObject>

///richiedo i risultati alla classe che conforma al mioo protocollo
-(NSArray *)scoreTableViewFetchResults;

// infoprmo che ho terminato il fwtch dei dati
-(void)scoreTableViewDidFetchResults;

@end

@interface ScoreTableViewController : UITableViewController

@property (nonatomic,strong) NSArray *scoresArray;


@property(nonatomic,unsafe_unretained) id <ScoreTableViewDelegate> delegate;

@end
