//
//  MainMenuLayer.m
//  Universe Safari
//
//  Created by Andrew Morgan on 12/15/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "MainMenuLayer.h"
#import "SimpleAudioEngine.h"
#import "HelloWorldLayer.h"
#import "CCControlExtension.h"

@implementation MainMenuLayer

- (id) init
{
    
    if ((self = [super init])) {
        // Get update: method running every frame
        [self scheduleUpdate];
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:1];
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"shop-theme.mp3"];
        
        // Display logo at the top
        CCSprite *logo = [CCSprite spriteWithFile:@"universe-safari-logo.png"];
        logo.position = ccp(winSize.width/2,winSize.height/2 + 100);
        [self addChild: logo z:10];
        
        // Display play game, options and credits buttons
        playGameButton = [CCMenuItemImage itemWithNormalImage:@"play-game-button.png" selectedImage:@"play-game-button-selected.png" target:self selector:@selector(playGameButtonPressed)];
        playGameButton.position = ccp(winSize.width/2,winSize.height/2 + 20);
        
        optionsButton = [CCMenuItemImage itemWithNormalImage:@"options-button.png" selectedImage:@"options-button-selected.png" target:self selector:@selector(optionsButtonPressed)];
        optionsButton.position = ccp(winSize.width/2,winSize.height/2 - 35);
        
        creditsButton = [CCMenuItemImage itemWithNormalImage:@"credits-button.png" selectedImage:@"credits-button-selected.png" target:self selector:@selector(creditsButtonPressed)];
        creditsButton.position = ccp(winSize.width/2,winSize.height/2 - 90);
        
        CCMenu *buttonMenu = [CCMenu menuWithItems:playGameButton, optionsButton, creditsButton, nil];
        buttonMenu.position = CGPointZero;
        [self addChild:buttonMenu z:2];
        
        
        // Add the background images
        bg1 = [CCSprite spriteWithFile:@"space-background.png"];
        [self addChild:bg1 z:0];
        bg2 = [CCSprite spriteWithFile:@"space-background.png"];
        [self addChild:bg2 z:0];
    }
    return self;
}

- (void)update:(ccTime)dt {
    
    // Background handling
    int kScrollSpeed = 8;
    
    CGPoint bg1Pos = bg1.position;
    CGPoint bg2Pos = CGPointMake(bg1.position.x+bg1.boundingBox.size.width - 5, bg1.position.y);
    bg1Pos.x -= kScrollSpeed;
    bg2Pos.x -= kScrollSpeed;
    
    // move scrolling background back by one screen width to achieve "endless" scrolling
    if (bg1Pos.x < -(bg1.contentSize.width))
    {
        bg1Pos.x += bg1.contentSize.width;
        bg2Pos.x += bg2.contentSize.width;
    }
    
    // remove any inaccuracies by assigning only int values
    // (prevents floating point rounding errors accumulating over time)
    bg1Pos.x = (int)bg1Pos.x;
    bg2Pos.x = (int)bg2Pos.x;
    bg1.position = bg1Pos;
    bg2.position = bg2Pos;
}

-(void)playGameButtonPressed{
    CCScene *scene = [[CCDirector sharedDirector] runningScene];
    
    [scene removeAllChildrenWithCleanup:YES];
    
    // Layer to display planet information
    HelloWorldLayer *layer = [HelloWorldLayer node];
    
    [scene addChild:layer];
}

-(void)optionsButtonPressed{
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    // Create the volume slider
    CCControlSlider *slider = [CCControlSlider sliderWithBackgroundFile:@"slider-bar-track.png" progressFile:@"slider-bar-progress.png" thumbFile:@"slider-bar-thumb.png"];
    slider.minimumValue = 0.0f; // Sets the min value of range
    slider.maximumValue = 1.0f; // Sets the max value of range
    
    slider.value = 1.0f;
    
    slider.position = ccp(winSize.width/2 + 500, winSize.height/2);
    
    // When the value of the slider will change, the given selector will be call
    [slider addTarget:self action:@selector(valueChanged:) forControlEvents:CCControlEventValueChanged];
    
    [self addChild:slider];
    
    // Display the volume text
    CCLabelTTF *volumeLabel = [CCLabelTTF labelWithString:@"Volume:"
                                  dimensions:CGSizeMake(360,220)
                                  hAlignment:kCCTextAlignmentRight
                               lineBreakMode:kCCLineBreakModeWordWrap
                                    fontName:@"AbadiMT-CondensedExtraBold"
                                    fontSize:25];
    volumeLabel.position = ccp(winSize.width/2,winSize.height/2);
    volumeLabel.color = ccc3(255, 255, 255);
    [self addChild: volumeLabel z:10];
    
    // Push main menu buttons off to the left, and have the options push in from right.
    [playGameButton runAction:[CCMoveBy actionWithDuration:.5f position:ccp(-400,0)]];
    [optionsButton runAction:[CCSequence actions:[CCDelayTime actionWithDuration:.2],[CCMoveBy actionWithDuration:.5f position:ccp(-400,0)],nil]];
    [creditsButton runAction:[CCSequence actions:[CCDelayTime actionWithDuration:.4],[CCMoveBy actionWithDuration:.5f position:ccp(-400,0)],nil]];
    
    [slider runAction:[CCSequence actions:[CCDelayTime actionWithDuration:.6], [CCMoveBy actionWithDuration:.5f position:ccp(-500,0)], nil]];
    
    
}



-(void)creditsButtonPressed{
    // Push main menu buttons off to the right, and have the credits push in from left.
}

- (void)valueChanged:(CCControlSlider *)sender
{
    // Change volume of your sounds
    [[SimpleAudioEngine sharedEngine] setEffectsVolume:sender.value];
    [[SimpleAudioEngine sharedEngine] setBackgroundMusicVolume:sender.value];
}

@end
