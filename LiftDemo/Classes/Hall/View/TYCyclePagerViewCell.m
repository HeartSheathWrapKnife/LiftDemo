//
//  TYCyclePagerViewCell.m
//  TYCyclePagerViewDemo
//
//  Created by tany on 2017/6/14.
//  Copyright © 2017年 tany. All rights reserved.
//

#import "TYCyclePagerViewCell.h"

@interface TYCyclePagerViewCell ()
//@property (nonatomic, weak) UILabel *label;
@end

@implementation TYCyclePagerViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.cornerRadius = Fit(20);
        
//        [self addImgView];
        [self addLabel];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
        
//        [self addImgView];
        [self addLabel];
    }
    return self;
}


- (void)addLabel {
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:18];

    [self addSubview:label];
    _label = label;
}

//- (void)addImgView {
//    UIImageView *image = [[UIImageView alloc] init];
//    image.frame = self.frame;
//    [self addSubview:image];
//    _image = image;
//}


- (void)layoutSubviews {
    [super layoutSubviews];
    _label.frame = self.bounds;
//    _image.frame = self.bounds;
}

//- (void)setImageUrl:(NSString *)imageUrl {
//    _imageUrl = imageUrl;
//    [self.image sd_setImageWithURL:UrlWithString(imageUrl)];
//}

@end
