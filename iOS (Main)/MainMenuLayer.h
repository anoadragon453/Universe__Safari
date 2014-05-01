//
//  MainMenuLayer.h
//  Universe Safari
//
//  Created by Andrew Morgan on 12/15/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MainMenuLayer : CCLayer {
    CCSprite *bg1;
    CCSprite *bg2;
    
    CCMenuItemImage *playGameButton;
    CCMenuItemImage *optionsButton;
    CCMenuItemImage *creditsButton;
}

@end
