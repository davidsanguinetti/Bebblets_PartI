//
//  Bebblet.h
//  Bebblets_PartI
//
//  Created by David Sanguinetti on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Box2D.h"
#import "CCLayer.h"
#import "cocos2d.h"
#import "GLES-Render.h"
#define PTM_RATIO 32

typedef enum {
    normalBall = 1,
    aqua,
    soccer
} bbl_type;

@interface Bebblet : NSObject {
    
    @public
    CCSprite *sp_Face;
    
    bbl_type bbl_race;
    int     stamp;

    b2World *_world;
    b2BodyDef bd_Bebl;
    b2Body *body_Bebl;    
    b2FixtureDef fixd_Bebl;
}

@property (nonatomic, retain) CCSprite *sp_face;
@property (nonatomic, readwrite) b2BodyDef bd_Bebl;
@property (nonatomic, readwrite) b2Body *body_Bebl; 
@property (nonatomic, readwrite) b2FixtureDef fixd_Bebl;
@property (nonatomic, readwrite) b2World   *_world;
@property (nonatomic, readwrite) bbl_type race;
@property (nonatomic, readwrite) int stamp;

-(id) init : (NSString *) face : (b2World *) world : (float ) radius;
-(id) init : (b2World *) world;

-(void) setPosition : (CGPoint ) where;
-(void) pop;

@end
