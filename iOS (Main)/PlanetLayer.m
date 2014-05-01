//
//  PlanetLayer.m
//  Universe Safari
//
//  Created by Andrew Morgan on 11/28/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "PlanetLayer.h"
#import "SimpleAudioEngine.h"
#import "TriviaLayer.h"

CCSprite *planetBackground;
CCSprite *explanationBackground;
CCSprite *explanationPicture;
CCLabelTTF *planetName;
CCLabelTTF *explanationText;
CCMenuItemImage *prevButton;
CCMenuItemImage *nextButton;
NSString *planetNameText;
NSString *explanationText1;
NSString *explanationText2;
NSString *explanationText3;
int currentExplanationScreen;

@implementation PlanetLayer

- (id) init
{
    // Should fade into Planet Explanation
    if ((self = [super init])) {
        currentLevel = 1;
        currentExplanationScreen = 1;
        
        // Set up UI...
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        // Read from Data.plist
        NSString *errorDesc = nil;
        NSPropertyListFormat format;
        NSString *plistPath;
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                  NSUserDomainMask, YES) objectAtIndex:0];
        plistPath = [rootPath stringByAppendingPathComponent:@"Data.plist"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
            plistPath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
        }
        NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
        NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                              propertyListFromData:plistXML
                                              mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                              format:&format
                                              errorDescription:&errorDesc];
        if (!temp) {
            NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
        }
        
        // Navigate through the Plist and pull the neccessary values to build the interface based on what level the user just came from.
        NSDictionary *levelsDict = [NSDictionary dictionaryWithDictionary:[temp objectForKey:@"Levels"]];
        NSDictionary *levelNumberDict = [NSDictionary dictionaryWithDictionary:[levelsDict objectForKey:[NSString stringWithFormat:@"%d", currentLevel]]];
        NSDictionary *planetInfoDict = [NSDictionary dictionaryWithDictionary:[levelNumberDict objectForKey:@"Planet Info"]];
        planetNameText = [planetInfoDict objectForKey:@"Name"];
        explanationText1 = [planetInfoDict objectForKey:@"Explanation 1"];
        explanationText2 = [planetInfoDict objectForKey:@"Explanation 2"];
        explanationText3 = [planetInfoDict objectForKey:@"Explanation 3"];
        
        // Add the background image
        planetBackground = [CCSprite spriteWithFile:[NSString stringWithFormat: @"planet-%@-background.png", planetNameText]];
        planetBackground.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:planetBackground z:-1];
        
        // Add general blue explanation background
        explanationBackground = [CCSprite spriteWithFile:@"explanation-background.png"];
        explanationBackground.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:explanationBackground z:0];
        
        // Add explanation picture sprite
        explanationPicture = [CCSprite spriteWithFile:[NSString stringWithFormat: @"planet-%@-explanation-picture-1.png", planetNameText]];
        explanationPicture.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:explanationPicture z:0];
        
        // Add the previous and next buttons
        prevButton = [CCMenuItemImage
                      itemWithNormalImage:@"prev-button-grey-cropped.png" selectedImage:@"prev-button-grey-cropped.png"
                      target:self selector:@selector(previousButtonPressed)];
        prevButton.position = ccp(230,55);

        nextButton = [CCMenuItemImage
                      itemWithNormalImage:@"next-button-cropped.png" selectedImage:@"next-button-cropped.png"
                      target:self selector:@selector(nextButtonPressed)];
        nextButton.position = ccp(480,55);
        
        CCMenu *buttonMenu = [CCMenu menuWithItems:nextButton, prevButton, nil];
        buttonMenu.position = CGPointZero;
        [self addChild:buttonMenu z:10];
        
        planetName = [CCLabelTTF labelWithString:[planetNameText uppercaseString]
                                      dimensions:CGSizeMake(360,220)
                                      hAlignment:kCCTextAlignmentLeft
                                   lineBreakMode:kCCLineBreakModeWordWrap
                                        fontName:@"AbadiMT-CondensedExtraBold"
                                        fontSize:40];
        planetName.position = ccp(223,179);
        planetName.color = ccc3(255, 255, 255);
        [self addChild: planetName z:2];
        
        explanationText = [CCLabelTTF labelWithString:explanationText1
                                           dimensions:CGSizeMake(335,180)
                                           hAlignment:kCCTextAlignmentLeft
                                        lineBreakMode:kCCLineBreakModeWordWrap
                                             fontName:@"AbadiMT-CondensedLight"
                                             fontSize:18];
        explanationText.position = ccp(355,160);
        explanationText.color = ccc3(255, 255, 255);
        [self addChild: explanationText z:10];
    }
    
    return self;
}

- (void)nextButtonPressed
{
    if(currentExplanationScreen == 1){
        [prevButton setNormalImage:[CCSprite spriteWithFile:@"prev-button-cropped.png"]];
        [prevButton setSelectedImage:[CCSprite spriteWithFile:@"prev-button-cropped.png"]];
        [explanationText setString:explanationText2];
        [explanationPicture setTexture:[[CCTextureCache sharedTextureCache] addImage:[NSString stringWithFormat: @"planet-%@-explanation-picture-2.png", planetNameText]]];
    }else if (currentExplanationScreen == 2) {
        [nextButton setNormalImage:[CCSprite spriteWithFile:@"done-button-cropped.png"]];
        [nextButton setSelectedImage:[CCSprite spriteWithFile:@"done-button-cropped.png"]];
        [explanationText setString:explanationText3];
        [explanationPicture setTexture:[[CCTextureCache sharedTextureCache] addImage:[NSString stringWithFormat: @"planet-%@-explanation-picture-3.png", planetNameText]]];
    }else if (currentExplanationScreen == 3){
        [self changeSceneLayer];
    }
    currentExplanationScreen++;
}

- (void)previousButtonPressed
{
    if (currentExplanationScreen == 3) {
        // Change Text and picture
        [nextButton setNormalImage:[CCSprite spriteWithFile:@"next-button-cropped.png"]];
        [nextButton setSelectedImage:[CCSprite spriteWithFile:@"next-button-cropped.png"]];
        [explanationText setString:explanationText2];
        [explanationPicture setTexture:[[CCTextureCache sharedTextureCache] addImage:[NSString stringWithFormat: @"planet-%@-explanation-picture-2.png", planetNameText]]];
    }else if (currentExplanationScreen == 2){
        [prevButton setNormalImage:[CCSprite spriteWithFile:@"prev-button-grey-cropped.png"]];
        [prevButton setSelectedImage:[CCSprite spriteWithFile:@"prev-button-grey-cropped.png"]];
        [explanationText setString:explanationText1];
        [explanationPicture setTexture:[[CCTextureCache sharedTextureCache] addImage:[NSString stringWithFormat: @"planet-%@-explanation-picture-1.png", planetNameText]]];
    }
    currentExplanationScreen--;
}

- (void) changeSceneLayer {
    [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
    
    // Layer to display planet information
    TriviaLayer *layer = [TriviaLayer node];
    
    CCScene *scene = [[CCDirector sharedDirector] runningScene];
    
    [scene removeAllChildrenWithCleanup:YES];
    [scene addChild:layer];
}


@end
