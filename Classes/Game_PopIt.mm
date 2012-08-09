//
//  Game_PopIt.m
//  Bebblets_PartI
//
//  Created by David Sanguinetti on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Game_PopIt.h"

@implementation Game_PopIt 

-(id) init:(CCLayer *)target {
    return  self;
}

-(id) initLayer : (CCLayer *) target {
    if (self = [super init:target]) {
        _winSize = [[CCDirector sharedDirector] winSize];
        
        _contactListener = new MyContactListener();
        _arBubblets = [[NSMutableArray alloc] init];
        _matches = [[NSMutableArray alloc] init];
        
        /*
         * Create the World
         */
        b2Vec2 gravity = b2Vec2(0.0f, GRAVITY);
        _world = new b2World(gravity, false);   
        
        _world->SetContactListener(_contactListener);
        
        /*
         * Create the walls
         */
        b2BodyDef groundBodyDef;
		groundBodyDef.position.Set(0, 0); // bottom-left corner
        _walls = _world->CreateBody(&groundBodyDef);
        
        
        b2FixtureDef fixWalls;
        b2PolygonShape box;
        box.SetAsBox(_winSize.width/PTM_RATIO, _winSize.height/PTM_RATIO); 
        
        float32 margin = 0.0f;
        b2Vec2 lowerLeft = b2Vec2(margin/PTM_RATIO, margin/PTM_RATIO);
        b2Vec2 lowerRight = b2Vec2((_winSize.width-margin)/PTM_RATIO,margin/PTM_RATIO);
        b2Vec2 upperRight = b2Vec2((_winSize.width-margin)/PTM_RATIO, (_winSize.height-margin)/PTM_RATIO);
        b2Vec2 upperLeft = b2Vec2(margin/PTM_RATIO, (_winSize.height-margin)/PTM_RATIO);
        
        fixWalls.shape = &box;
        fixWalls.density = 1.0f;
		
        box.SetAsEdge(lowerLeft, lowerRight);
        _walls->CreateFixture(&fixWalls);
        
        box.SetAsEdge(lowerRight, upperRight);
        _walls->CreateFixture(&fixWalls);
        
        box.SetAsEdge(upperRight, upperLeft);
        _walls->CreateFixture(&fixWalls);
        
        box.SetAsEdge(upperLeft, lowerLeft);
        _walls->CreateFixture(&fixWalls);
        
        speedfactor = 1.5;
        
        [self spreadBubblets];
    }
    return self;
}

-(void) spreadBubblets {
    const int NUMBUBBLETS = 7;
    //        static const int rows = 2;
    
//    float heightbeb = _winSize.height;
//    float howmanybebs = heightbeb / 25;
    
    int sumWidth = 0, 
        i = -1;
    int sumHeight = 0, 
        bottomHeight = 0,
        maxHeight = 0;
    
    while (sumHeight < _winSize.height) {
        while (sumWidth < _winSize.width) {
            Bebblet *newBubblet = [BebbletMachine generateRandomBebblet:_world];  
            newBubblet.stamp = ++i;
            newBubblet.sp_face.tag = i;
            
            
            maxHeight = (newBubblet.sp_face.contentSize.height > maxHeight) ? 
                newBubblet.sp_face.contentSize.height : 
                maxHeight;
            
//            [newBubblet setPosition:CGPointMake(((x+1)*(newBubblet.sp_face.contentSize.width+3)), (_winSize.height*0.90))];
            [newBubblet setPosition:CGPointMake(sumWidth, bottomHeight)];
            
            [_arBubblets addObject:newBubblet];
            [_targetLayer addChild:newBubblet.sp_face];   
            
            sumWidth += newBubblet.sp_face.contentSize.width;
        }
        sumWidth = 0;
        bottomHeight += maxHeight;
        sumHeight += maxHeight;
    }
    
//    for (int x=0; x < NUMBUBBLETS; x++) {
//        Bebblet *newBubblet = [BebbletMachine generateRandomBebblet:_world];  
//        newBubblet.stamp = x;
//        newBubblet.sp_face.tag = x;
//        
//        
//        [newBubblet setPosition:CGPointMake(((x+1)*(newBubblet.sp_face.contentSize.width+3)), (_winSize.height*0.90))];
//        
//        [_arBubblets addObject:newBubblet];
//        [_targetLayer addChild:newBubblet.sp_face];
//    }
}


-(void) tick: (ccTime) dt {
    _world->Step(dt, 10, 10);
    
    for(b2Body *b = _world->GetBodyList(); b; b=b->GetNext()) {
        if(b->GetUserData() != NULL) {
            CCSprite *balldata = (CCSprite *) b->GetUserData();
            balldata.position = [Util toPixels:b->GetPosition()];
            balldata.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
            
        }
    }
}

-(void) checkMatches {
    [_matches removeAllObjects];
    
    std::vector<b2Body *>toDestroy;
    std::vector<MyContact>::iterator pos;
    for(pos = _contactListener->_contacts.begin(); 
        pos != _contactListener->_contacts.end(); ++pos) {
        MyContact contact = *pos;
        
        
        b2Body *bodyA = contact.fixtureA->GetBody();
        b2Body *bodyB = contact.fixtureB->GetBody();
        
        if (bodyA->GetUserData() != NULL && bodyB->GetUserData() != NULL) {
            CCSprite *spriteA = (CCSprite *) bodyA->GetUserData();
            CCSprite *spriteB = (CCSprite *) bodyB->GetUserData();
            
            int numBebblets = [_arBubblets count];
            if ((spriteA.tag < 0 || spriteA.tag > numBebblets) ||
                (spriteB.tag < 0 || spriteB.tag > numBebblets))
                continue;
            
            //            NSLog(@"NumBubs: %d\n bubtagA: %d\n bubtagB: %d", [_arBubblets count], spriteA.tag, spriteB.tag);
            
            Bebblet *bubA = (Bebblet *) [_arBubblets objectAtIndex:spriteA.tag];
            Bebblet *bubB = (Bebblet *) [_arBubblets objectAtIndex:spriteB.tag];
            
            NSLog(@"bubArace: %d;\nbubBrace = %d", bubA.race, bubB.race);
            
            // Sprite A = ball, Sprite B = Block
            if (bubA.race == bubB.race && 
                bubA.stamp != bubB.stamp) {
                                NSLog(@"Race %d touched themselves, with ids %d and %d", bubA.race, 
                                      bubA.stamp, 
                                      bubB.stamp);
                
                [self contacted:bubA :bubB];
            } 
        }
    }
}

-(void) accelActivated:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    
    b2Vec2 gravity(-acceleration.y * GRAVITY * speedfactor, acceleration.x *GRAVITY * speedfactor);
    _world->SetGravity(gravity);
    
}

-(void) touched:(NSSet *)touches withEvent:(UIEvent *)event  {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    [self checkMatches];
    
    [self popBubblets : location];
}


-(void) popBubblets  : (CGPoint) location {
    for (int i=0; i < [_matches count]; i++) {
        NSMutableArray *group = [_matches objectAtIndex:i];
        
        BOOL popGroup = NO;
        
        for (Bebblet *beb in group) {
            
            if([group count] >= 3) {
                
                for (Bebblet *beb in group) {
                    b2Vec2 pos =  beb->body_Bebl->GetPosition();
                    
                    CGPoint point = [Util toPixels:pos];
                    
                    CGRect rectbubble = [Util rectmakeFromSprite:(CCSprite *) beb->body_Bebl->GetUserData()];
                    
                    const int sizeFinger = 10;
                    CGPoint convertfinger = ccp(location.x, location.y);
                    CGRect recttouch = CGRectMake(convertfinger.x, convertfinger.y, sizeFinger, sizeFinger);
                    //                recttouch = ccp(recttouch.origin.x, location.y);
                    
                    
                    if (CGRectIntersectsRect(rectbubble, recttouch))
                        popGroup = YES;
                    
                }
                
                /*
                 * Apply some force to adjacent balls
                 */
                //            const int MAXSTRENGHT = 10;
                //            for(Bebblet *beb in group) {
                //                int xdir = arc4random() % MAXSTRENGHT;
                //                int ydir = arc4random() % MAXSTRENGHT;
                //                
                //                 beb.body_Bebl->ApplyLinearImpulse(b2Vec2(xdir, ydir), beb.bd_Bebl.position);
                //            }
            }
        }
        if (popGroup) {
            for (Bebblet *beb in group) {
                CCSprite *sprite = (CCSprite *) beb->body_Bebl->GetUserData();
                
                [_targetLayer removeChild:sprite cleanup:YES];
                _world->DestroyBody(beb->body_Bebl);  
            }
            [[SimpleAudioEngine sharedEngine] playEffect:@"drip.mp3"];
        }
    }    
}



-(void) contacted : (Bebblet *) bubA : (Bebblet *) bubB {
    NSMutableArray *groupA = [self whereisbubblet: bubA];
    NSMutableArray *groupB = [self whereisbubblet: bubB];
    
    if (groupA == groupB && groupA != nil )
        return;
    else
        if (groupA != nil && groupB != nil &&
            [groupA count] > 1 && [groupB count] > 1) {
            [_matches removeAllObjects];
            
            /*
             * Concatenate the groups
             */
            NSMutableArray *groupAB = [[NSMutableArray alloc] initWithArray:groupA];
            [groupAB addObjectsFromArray:groupB];
            [_matches addObject:groupAB]; 
        }
        if (groupA != nil && ![self existInGroup:groupA :bubB])
            [groupA addObject:bubB ];
        else if(groupB != nil && ![self existInGroup:groupB :bubA])
            [groupB addObject:bubA ];
        else if (groupA == nil &&
                 groupB == nil) // If it doesn't exists
            [_matches addObject:[[NSMutableArray alloc] 
                                 initWithObjects: bubA, bubB, nil]];            
}


-(BOOL) existInGroup: (NSMutableArray *) group : (Bebblet *) beb {
    for (Bebblet *bebgroup in group) {
        //        NSLog(@"tags to compare: %d and %d", beb.stamp, bebgroup.stamp);
        if (beb.stamp == bebgroup.stamp)
            return YES;
    }
    
    return NO;
    
}

-(NSMutableArray *) whereisbubblet : (Bebblet *) beb {
    for (NSMutableArray *glued in _matches) {
        if ([self existInGroup:glued :beb])
            return glued;        
    }
    
    return nil;
}

@end
