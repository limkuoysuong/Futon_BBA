//
//  GameScore.m
//  FutonBBA
//
//  Created by Kheang Senghort on 5/22/14.
//  Copyright (c) 2014 Doi Daihei. All rights reserved.
//

#import "GameScore.h"

//NSUserDefaults *defaults;
#define  DEFINE_SCORE 0

@implementation GameScore

static NSString* const RESULT_SCORE_KEY = @"result_score_key";
static NSString* const CURRENT_SCORE_KEY = @"current_score_key";


+ (NSNumber *)getScore:(int)scoreNumber
{
    // Create variable NSUserDefaults
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    // Create variable store format note key
    NSString* score = [NSString stringWithFormat:RESULT_SCORE_KEY];
    
    // Create variable arrayScore to variable defaults by key score
    NSArray *arrayScore = [defaults arrayForKey:score];
    
    // Create variable getScore of NSNumber
    NSNumber* getScore;
    if (arrayScore) {
        
        // store index of variable getScore
        getScore = [arrayScore objectAtIndex:scoreNumber];
        
        //NSLog(@"show index: %d",scoreNumber+1);
        return getScore;
        
    } else {
        
        // Create location of variable array
        NSArray* initDefault = @[@0,@0,@0,@0,@0];
        [defaults setObject:initDefault forKey:score];
        
        // Create variable arrayScore to variable defaults by key score
        arrayScore = [defaults objectForKey:score];
        
        // store index of variable getScore
        getScore = [arrayScore objectAtIndex:scoreNumber];
        
        //NSLog(@"show index: %d",scoreNumber+1);
        return getScore;
    }
}

- (void)initScore
{
    // Create object NSUserDefaults
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    // Create variable defineScore to init Score
    int defineScore = DEFINE_SCORE;
    
    // Create value first when start screen
    [defaults setInteger:defineScore forKey:CURRENT_SCORE_KEY];
    
    //NSLog(@"When we start screen init score: %d", defineScore);
}

- (void)runFutonGameScore:(int)scorePoint
{
    // Create object defaults
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    // Make change score when touch on coin, inset, boom follow by key
    [defaults setInteger:scorePoint forKey:CURRENT_SCORE_KEY];
    
    //NSLog(@"next game score %d", scorePoint);
}

+ (int)currentScore
{
    // Create object defaults
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    //Get the score that has been stored
    int score = [defaults integerForKey:CURRENT_SCORE_KEY];
    
    //NSLog(@"current score %d", score);
    return score;
}

- (void)sortedScore:(int)scoreNumber
{
    // Create object defaults
    NSUserDefaults* defaluts = [NSUserDefaults standardUserDefaults];
    
    // create variable score format for note to key
    NSString* score = [NSString stringWithFormat:RESULT_SCORE_KEY];
    
    // Create variable myScore so get the score that has been stored
    NSArray* myScore = [defaluts arrayForKey:score];
    
    if (myScore) {
        
        // Create object changeSocre for copy score from variable myScore
        NSMutableArray* changeScore = [myScore mutableCopy];
        
        // Add to current score
        [changeScore addObject:[NSNumber numberWithInt:scoreNumber]];
        
        // Using method sorted by class NSMutableArray by order descending
        NSArray* sortedArray = [changeScore sortedArrayUsingComparator:^NSComparisonResult(NSNumber* score1, NSNumber* score2){
            return score2.intValue - score1.intValue;
        }];
        
        // After sorted data then copy and change location of data
        changeScore = [sortedArray mutableCopy];
        [changeScore removeLastObject];
        
        // Cast variable changeScore to arrayScore
        NSArray* arrayScore = (NSArray*)changeScore;
        
        // Add new score into object of NSUserDefaults
        [defaluts setObject:arrayScore forKey:score];
        
        // Make variable ssnchronize
        [defaluts synchronize];
        
    }
    else {
        // Create variable then initlize 5 location
        NSArray* initDefault = @[@0,@0,@0,@0,@0];
        
        // When start screen display 5 value on screen
        [defaluts setObject:initDefault forKey:score];
        
        // Cast variable initDefault to changeScore
        NSMutableArray* changeScore = initDefault.mutableCopy;
        [changeScore addObject:[NSNumber numberWithInt:scoreNumber]];
        
        // Using method sorted by class NSMutableArray by order descending
        NSArray* sortedArray = [changeScore sortedArrayUsingComparator:^NSComparisonResult(NSNumber* score1, NSNumber* score2){
            return score2.intValue - score1.intValue;
        }];
        
        // After sorted data then copy and change location of data
        changeScore = [sortedArray mutableCopy];
        [changeScore removeLastObject];
        
        // Cast variable changeScore to arrayScore
        NSArray* arrayScore = (NSArray*)changeScore;
        
        // Add new score into object of NSUserDefaults
        [defaluts setObject:arrayScore forKey:score];
        
        // Make variable ssnchronize
        [defaluts synchronize];
    }
}

@end

