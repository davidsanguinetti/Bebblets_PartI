//
//  Util.m
//  Bebblets_PartI
//
//  Created by David Sanguinetti on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Util.h"

@implementation Util


+(b2Vec2) toMeters : (CGPoint) point {
    return b2Vec2(point.x / PTM_RATIO, point.y / PTM_RATIO);
}

+(CGPoint) toPixels : (b2Vec2) vec {
    return ccpMult(CGPointMake(vec.x, vec.y), PTM_RATIO);
}

+(CGRect) rectmakeFromSprite : (CCSprite *) sprite {
    float x = sprite.position.x - (sprite.contentSize.width /2);
    float y = sprite.position.y - sprite.contentSize.height /2;
    float width = sprite.contentSize.width;
    float height = sprite.contentSize.height;
    
    
    return CGRectMake(x, y,
                      width, height);   
}

@end
