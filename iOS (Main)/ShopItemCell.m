//
//  ShopItemCell.m
//  Universe Safari
//
//  Created by Andrew Morgan on 1/11/14.
//
//

#import "ShopItemCell.h"

@implementation ShopItemCell
@synthesize backgroundImageView,itemLabel,itemImageView,ownedImageView,equippedImageView;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //itemLabel = [[UILabel alloc]init];
        itemLabel = [[SOLabel alloc]init];
        itemLabel.textAlignment = UITextAlignmentLeft;
        itemLabel.font = [UIFont systemFontOfSize:10];
        itemLabel.textColor = [UIColor whiteColor];
        itemLabel.lineBreakMode = NSLineBreakByWordWrapping;
        itemLabel.numberOfLines = 0;

        backgroundImageView = [[UIImageView alloc]init];
        backgroundImageView.image = [UIImage imageNamed:@"shop-item-background.png"];
        
        itemImageView = [[UIImageView alloc]init];
        
        ownedImageView = [[UIImageView alloc]init];
        equippedImageView = [[UIImageView alloc]init];
        
        [self.contentView addSubview:backgroundImageView];
        [self.contentView addSubview:itemLabel];
        [self.contentView addSubview:itemImageView];
        [self.contentView addSubview:ownedImageView];
        [self.contentView addSubview:equippedImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame;
    frame= CGRectMake(0, 0, 90, 90);
    backgroundImageView.frame = frame;
    
    // Image was off for some reason, had to reposition manually
    frame = CGRectMake(-3, -5, 90, 90);
    itemImageView.frame = frame;
    
    frame= CGRectMake(10, 75, 70, 40);
    itemLabel.frame = frame;
    
    frame = CGRectMake(20, 0, 25, 25);
    ownedImageView.frame = frame;
    
    frame = CGRectMake(0, 0, 25, 25);
    equippedImageView.frame = frame;
}

@end
