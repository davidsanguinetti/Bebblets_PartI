//
//  Bbl_Doc.m
//  Bebblets_PartI
//
//  Created by David Sanguinetti on 5/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Bbl_Doc.h"

@implementation Bbl_Doc

-(id) init:(b2World *)world {
    self = [super init:@"soccer.png" : world : 0];
    
    self.race = soccer;
    
    if (self) {
        return self;
    }
    else {
        return nil;
    }
}

@end
