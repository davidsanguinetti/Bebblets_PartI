//
//  Bebblet.m
//  Bebblets_PartI
//
//  Created by David Sanguinetti on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Bebblet.h"

@implementation Bebblet

@synthesize sp_face,
bd_Bebl,
body_Bebl,
fixd_Bebl,
race,
_world,
stamp;

-(id) init : (NSString *) face : (b2World *) world : (float) radius{
    if (self = [super init]) {
        sp_face = [CCSprite spriteWithFile:face];
        sp_face.tag = 1;
        
        bd_Bebl.type = b2_dynamicBody;
        bd_Bebl.userData = sp_face;

        bd_Bebl.type = b2_dynamicBody;
        bd_Bebl.userData = sp_face;
        
//        bd_Bebl.position.Set(100/PTM_RATIO, 450/PTM_RATIO);
        
        body_Bebl = world->CreateBody(&bd_Bebl);
        _world = world;
        
        b2CircleShape circle;
        circle.m_radius =(radius == 0) ? (sp_face.contentSize.width/2)/PTM_RATIO : radius;
        
        b2FixtureDef ballShapeDef;
        ballShapeDef.shape = &circle;
        ballShapeDef.density = 1.7f;
        ballShapeDef.friction = 0.2f;
        ballShapeDef.restitution = 0.4f;
        body_Bebl->CreateFixture(&ballShapeDef);

    }
    
    return self;
}

-(id) init : (b2World *) world {
    _world = world;
    
    return self;
}

-(void) setPosition:(CGPoint) where {
    sp_face.position = ccp(where.x, where.y);
    
    body_Bebl->SetTransform(b2Vec2(where.x/PTM_RATIO, where.y/PTM_RATIO), 180);
//    bd_Bebl.position.Set(where.x/PTM_RATIO, where.y/PTM_RATIO);
}

-(void) pop {
    
}

@end
