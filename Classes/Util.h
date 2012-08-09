//
//  Util.h
//  Bebblets_PartI
//
//  Created by David Sanguinetti on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Box2D.h"
#import "CCLayer.h"
#import "cocos2d.h"

#define PTM_RATIO 32

@interface Util : NSObject


+(b2Vec2) toMeters : (CGPoint) point;
+(CGPoint) toPixels : (b2Vec2) vec;
+(CGRect) rectmakeFromSprite : (CCSprite *) sprite;
@end
