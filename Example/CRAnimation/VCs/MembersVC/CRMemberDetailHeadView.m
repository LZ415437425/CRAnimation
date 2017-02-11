//
//  CRMemberDetailHeadView.m
//  CRAnimation
//
//  Created by Bear on 17/2/11.
//  Copyright © 2017年 BearRan. All rights reserved.
//

#import "CRMemberDetailHeadView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CRMemberDetailHeadView ()
{
    UIImageView     *_headerImageV;
    
    UIView          *_nameAndProfessionView;
    UILabel         *_nameLabel;
    UILabel         *_professionLabel;
    
    UILabel         *_personalHomePageLabel;
    UIView          *_keyWordsView;
    
    CRMemberInfoModel   *_memberInfoModel;
    CGFloat             _off_x;
}

@end

@implementation CRMemberDetailHeadView

+ (CRMemberDetailHeadView *)commonHeadView
{
    CRMemberDetailHeadView *headView = [[CRMemberDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, YY_6N(550))];
    return headView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _off_x = XX_6N(40);
        [self createUI];
    }
    
    return self;
}

- (void)createUI
{
    CGFloat headerImageV_width = XX_6N(150);
    _headerImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, headerImageV_width, headerImageV_width)];
    _headerImageV.layer.cornerRadius = headerImageV_width / 2.0;
    _headerImageV.layer.masksToBounds = YES;
    [self addSubview:_headerImageV];
    
    _nameAndProfessionView = [UIView new];
    [self addSubview:_nameAndProfessionView];
    
    _nameLabel = [UILabel new];
    _nameLabel.font = BoldFont(18);
    _nameLabel.textColor = [UIColor whiteColor];
    [_nameAndProfessionView addSubview:_nameLabel];
    
    _professionLabel = [UILabel new];
    _professionLabel.font = SystemFont(14);
    _professionLabel.textColor = color_c5c5c5;
    [_nameAndProfessionView addSubview:_professionLabel];
    
    _personalHomePageLabel = [UILabel new];
    _personalHomePageLabel.font = FontSize(15);
    _personalHomePageLabel.textColor = color_5e67f7;
    _personalHomePageLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_personalHomePageLabel];
    
    _keyWordsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, YY_6N(55))];
    _keyWordsView.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.7];
    [self addSubview:_keyWordsView];
}


#pragma mark - relayUI

- (void)relayUI
{
    //  _nameLabel & _professionLabel
    [_nameLabel sizeToFit];
    [_professionLabel sizeToFit];
    [_nameAndProfessionView setHeight:MAX((CGFloat)_nameLabel.height, (CGFloat)_professionLabel.height)];
    [UIView BearAutoLayViewArray:(NSMutableArray *)@[_nameLabel, _professionLabel] layoutAxis:kLAYOUT_AXIS_X center:YES offStart:0 offEnd:0 gapDistance:XX_6N(20)];
    
    CGFloat labelMax_width = self.width - 2 * _off_x;
    [_personalHomePageLabel sizeToFit];
    [_personalHomePageLabel setWidth:labelMax_width];
    
    [UIView BearAutoLayViewArray:(NSMutableArray *)@[_headerImageV, _nameAndProfessionView, _personalHomePageLabel, _keyWordsView]
                      layoutAxis:kLAYOUT_AXIS_Y
                          center:YES gapAray:@[@160, @24, @28, @40, @44]
                       gapDisAll:YY_6N(160 + 24 + 28 + 40 + 44)];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self relayUI];
}


#pragma mark - Set Data

- (void)setDataWithMemberInfoModel:(CRMemberInfoModel *)model
{
    _memberInfoModel = model;
    
    UIImage *placeHolderHeaderImage = [UIImage imageNamed:@"tab_btn_control_n"];
    if ([_memberInfoModel.headURL length] > 0) {
        [_headerImageV sd_setImageWithURL:[NSURL URLWithString:_memberInfoModel.headURL] placeholderImage:placeHolderHeaderImage];
    }else{
        _headerImageV.image = placeHolderHeaderImage;
    }
    
    _nameLabel.text = _memberInfoModel.nickName;
    _professionLabel.text = [CRConstants convertProfessionType:_memberInfoModel.professionType];
    _personalHomePageLabel.text = _memberInfoModel.homePage;
    
    [self relayUI];
}

@end
