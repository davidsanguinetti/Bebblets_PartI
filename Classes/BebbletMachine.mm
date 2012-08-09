//
//  BebbletMachine.m
//  Bebblets_PartI
//
//  Created by David Sanguinetti on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BebbletMachine.h"

@implementation BebbletMachine

+(Bebblet *) generateRandomBebblet : (b2World *) world {
    Bebblet *newbeb;
    
    
    int randbeb = 0;
    while (!(randbeb >=1 && randbeb <= 3))
        randbeb = arc4random() % 4;
    
//    randbeb = 2;
    
    switch (randbeb) {
        case normalBall: {
            newbeb = [[Bbl_Soldier alloc] init:world];
            [newbeb setRace:normalBall];
            break;
        }
        case aqua : {
            newbeb = [[Bbl_Nurse alloc] init:world] ;
            [newbeb setRace:aqua];
            break;
        }
        case soccer : {
            newbeb = [[Bbl_Doc alloc] init:world];
            [newbeb setRace:soccer];
            break;
        }
            
        default:
            break;
    }
    
    return newbeb;
}

@end
