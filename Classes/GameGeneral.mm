//
//  GameGeneral.m
//  Bebblets_PartI
//
//  Created by David Sanguinetti on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameGeneral.h"

@implementation GameGeneral

-(id) init : (CCLayer *) target {
    if (self= [super init]){
        _targetLayer = target;
        
        return self;
    } else
        return nil;
}
@end
