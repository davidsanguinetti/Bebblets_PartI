//
//  GamePlay.m
//  Bebblets_PartI
//
//  Created by David Sanguinetti on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GamePlay.h"

@implementation GamePlay

+(CCScene *) scene {
    CCScene *scene = [CCScene node];
    GamePlay *gplay = [GamePlay node];
    
    CCSprite *bkg = [CCSprite spriteWithFile:@"wallpaper.jpg"];
    [bkg setPosition:
     ccp([[CCDirector sharedDirector] winSize].width/2, [[CCDirector sharedDirector] winSize].height/2)];
    
    [scene addChild:bkg z:0];
    [scene addChild:gplay];
    
    return scene;
}

-(id) init {
    if (self = [super init]){
        
        self.isAccelerometerEnabled = YES;
        self.isTouchEnabled = YES;
        
        _currentGame = [[Game_PopIt alloc] initLayer:self];
                
        [self schedule:@selector(tick:)];

    }
    
    return self;
}

-(void) tick: (ccTime) dt {
    [_currentGame tick:dt];
    
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    
    [_currentGame accelActivated:accelerometer didAccelerate:acceleration];    
}



- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [_currentGame touched:touches withEvent:event];
}

@end
