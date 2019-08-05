//
//  WXMenuCell.m
//  Demo
//
//  Created by Sivanwu on 2019/5/28.
//  Copyright © 2019年 HFY All rights reserved.
//

#import "WXMenuCell.h"

@implementation WXMenuCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _isShowSeparator = YES;
        
        UIImageView *mainImageView = [[UIImageView alloc] init];
        mainImageView.frame = CGRectMake(24, 20, 24, 24);
        [self.contentView addSubview:mainImageView];
        _mainImageView = mainImageView;
        
        UILabel *albumLabel = [UILabel new];
        albumLabel.frame = CGRectMake(64, 22, 92, 22);
        albumLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.contentView addSubview:albumLabel];
        _albumLabel = albumLabel;
        
        UILabel *countLabel = [UILabel new];
        countLabel.frame = CGRectMake(162, 22, 40, 22);
        countLabel.textAlignment = NSTextAlignmentRight;
        countLabel.textColor = [UIColor colorWithWhite:1 alpha:0.7];
        countLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:countLabel];
        _countLabel = countLabel;
    }
    return self;
}

- (void)configCell:(WXMenuAction *)action
          textFont:(UIFont *)font
         textColor:(UIColor *)textColor
highlightTextColor:(UIColor *)highlightTextColor{
    if (action.isHighlighted){
        self.mainImageView.image = action.highlightImage;
        self.albumLabel.textColor = highlightTextColor;
    }else{
        self.mainImageView.image = action.image;
        self.albumLabel.textColor = textColor;
    }
    
    
    self.albumLabel.font = font;
    self.albumLabel.text = action.title;
    
    self.countLabel.text = [NSString stringWithFormat:@"%li", (long)action.count];
}

- (void)setSeparatorColor:(UIColor *)separatorColor{
    _separatorColor = separatorColor;
    
    [self setNeedsDisplay];
}
- (void)setIsShowSeparator:(BOOL)isShowSeparator{
    _isShowSeparator = isShowSeparator;
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect{
    if (!_isShowSeparator)return;

    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(24, rect.size.height - 0.5)];
    [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height - 0.5)];
    path.lineWidth = 0.5;
    [path stroke];

    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.lineWidth = 0.5;
    lineLayer.strokeColor = _separatorColor.CGColor;
    lineLayer.path = path.CGPath;

    [self.layer addSublayer:lineLayer];
}
@end
