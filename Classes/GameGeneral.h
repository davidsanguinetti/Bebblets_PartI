//
//  GameGeneral.h
//  Bebblets_PartI
//
//  Created by David Sanguinetti on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Box2D.h"
#import "CCLayer.h"
#import "Util.h"
#import "SimpleAudioEngine.h"
#define GRAVITY 9.8


@protocol GameDelegate <NSObject>

@required
-(void) spreadBubblets;
-(void) accelActivated:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration ;
-(void) touched:(NSSet *)touches withEvent:(UIEvent *)event;
-(void) tick: (ccTime) dt;

@end

@class GameGeneral;

@interface GameGeneral : NSObject {
    CGSize _winSize;
    CCLayer *_targetLayer;
}

-(id) init : (CCLayer *) target;
-(void) spreadBubblets;
-(void) accelActivated:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration ;
-(void) touched:(NSSet *)touches withEvent:(UIEvent *)event;
-(void) tick: (ccTime) dt;

@end
