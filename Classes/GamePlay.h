//
//  GamePlay.h
//  Bebblets_PartI
//
//  Created by David Sanguinetti on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "Box2D.h"
#import "GLES-Render.h"
#import "BebbletMachine.h"
#import "Bebblet.h"
#import "MyContactListener.h"
#import "GameGeneral.h"

#import "Game_PopIt.h"


@interface GamePlay : CCLayer {
    b2World *_world;
//    b2Body *_walls;
//    MyContactListener *_contactListener;
//    NSMutableArray *_arBubblets;
//    NSMutableArray *_matches;
    
    GameGeneral *_currentGame;

}

+(CCScene *) scene;
//-(NSMutableArray *) whereisbubblet : (Bebblet *) beb;
//-(BOOL) existInGroup: (NSMutableArray *) group : (Bebblet *) beb;
//-(void) contacted : (Bebblet *) bubA : (Bebblet *) bubB;
//-(void) popBubblets;

@end
