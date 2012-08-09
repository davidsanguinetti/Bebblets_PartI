//
//  BebbletMachine.h
//  Bebblets_PartI
//
//  Created by David Sanguinetti on 5/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bebblet.h"
#import "Bbl_Soldier.h"
#import "Bbl_Nurse.h"
#import "Bbl_Doc.h"

@interface BebbletMachine : NSObject


+(Bebblet *) generateRandomBebblet : (b2World *) world;

@end
