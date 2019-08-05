//
//  WXMenuCell.h
//  Demo
//
//  Created by Sivanwu on 2019/5/28.
//  Copyright © 2019年 HFY All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXMenuAction.h"

NS_ASSUME_NONNULL_BEGIN

//MARK: - WXMenuCell
@interface WXMenuCell : UITableViewCell

@property (nonatomic,assign) BOOL         isShowSeparator;
@property (nonatomic,strong) UIColor    * separatorColor;

@property (nonatomic, strong, readonly)UIImageView *mainImageView;
@property (nonatomic, strong, readonly)UILabel *albumLabel;
@property (nonatomic, strong, readonly)UILabel *countLabel;


- (void)configCell:(WXMenuAction *)action
          textFont:(UIFont *)font
         textColor:(UIColor *)textColor
highlightTextColor:(UIColor *)highlightTextColor;

@end

NS_ASSUME_NONNULL_END
