//
//  Bbl_Soldier.m
//  Bebblets_PartI
//
//  Created by David Sanguinetti on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Bbl_Soldier.h"

@implementation Bbl_Soldier

-(id) init:(b2World *)world {
    self = [super init:@"ball.png" : world : 0];
    
    self.race = normalBall;
            
    if (self) {
        return self;
    }
    else {
        return nil;
    }
}

@end
