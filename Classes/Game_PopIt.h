//
//  Game_PopIt.h
//  Bebblets_PartI
//
//  Created by David Sanguinetti on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameGeneral.h"
#import "MyContactListener.h"
#import "BebbletMachine.h"

@interface Game_PopIt  : GameGeneral {
    b2World *_world;
    b2Body *_walls;
    MyContactListener *_contactListener;
    NSMutableArray *_arBubblets;
    NSMutableArray *_matches;
    float speedfactor;
}

-(NSMutableArray *) whereisbubblet : (Bebblet *) beb;
-(BOOL) existInGroup: (NSMutableArray *) group : (Bebblet *) beb;
-(void) contacted : (Bebblet *) bubA : (Bebblet *) bubB;
-(void) popBubblets  : (CGPoint) location ;
-(id) init : (CCLayer *) target;
-(void) checkMatches;

@end
