//
//  Bbl_Nurse.m
//  Bebblets_PartI
//
//  Created by David Sanguinetti on 5/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Bbl_Nurse.h"

@implementation Bbl_Nurse

-(id) init: (b2World *) world {
    self = [super init:@"aqua.png" : world : 0];
    
    self.race = aqua;
    
    if (self) {
        return self;
    }
    else {
        return nil;
    }
}

@end