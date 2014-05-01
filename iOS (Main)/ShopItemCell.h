//
//  ShopItemCell.h
//  Universe Safari
//
//  Created by Andrew Morgan on 1/11/14.
//
//

#import <UIKit/UIKit.h>
#import "SOLabel.h"

@interface ShopItemCell : UICollectionViewCell{
    UIImageView *backgroundImageView;
    UIImageView *itemImageView;
    //UILabel *itemLabel;
    SOLabel *itemLabel;
}

- (id)initWithFrame:(CGRect)frame;

@property (nonatomic,retain) UIImageView *backgroundImageView;
@property (nonatomic,retain) UIImageView *itemImageView;
@property (nonatomic,retain) SOLabel     *itemLabel;
@property (nonatomic)        UIImageView *equippedImageView;
@property (nonatomic)        UIImageView *ownedImageView;
@end
