//
//  GroupBuyView.m
//  XiFangTong
//
//  Created by issuser on 13-8-5.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "GroupBuyView.h"
#import "DBOperation.h"
#import "JoinSuccessView.h"

@implementation GroupBuyView

//@synthesize contentImageView;
@synthesize groupBuy;

-(id)initWithFrame:(CGRect)frame contentImage:(UIImage *)image andPhone:(NSString *)phoneString
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat downHeight = 0.0;
        if (IS_IPHONE_5) {
            downHeight = 75.0;
        }

        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        backgroundImageView.image = [UIImage imageNamed:@"web_bg.png"];
        [self addSubview:backgroundImageView];
        
        contentImageView = [[UIImageView alloc] init];
        //        activityImageView.image = [UIImage imageNamed:@"activity_image"];
        contentImageView.frame = CGRectMake(5, 5, 280, 245+downHeight);
        [self addSubview:contentImageView];
        
        joinButton = [UIButton buttonWithType:UIButtonTypeCustom];
        joinButton.frame = CGRectMake(0, 265+downHeight, frame.size.width, 44);
        [joinButton setBackgroundImage:[UIImage imageNamed:@"group_buy_join2"] forState:UIControlStateNormal];
        [joinButton addTarget:self action:@selector(joinButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:joinButton];
        
        phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        phoneButton.frame = CGRectMake(0, 325+downHeight, frame.size.width, 44);
        [phoneButton setBackgroundImage:[UIImage imageNamed:@"group_buy_phone2"] forState:UIControlStateNormal];
        [phoneButton addTarget:self action:@selector(phoneButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:phoneButton];
        
        request = [[SubmitGroupBuyRequest alloc] init];
        [request setDelegate:self];
    }
    return self;

}
-(void)showGroupBuy:(GroupBuyInfo *)info
{
    NSString *imgPath = [NSString stringWithFormat:@"%@%@",ImagePathURL,info.mb_logo];
    NSURL *url = [NSURL URLWithString:imgPath];
   
    
    manager = [SDWebImageManager sharedManager];
    
//    if ([manager diskImageExistsForURL:url]) {
//        NSLog(@"image exists in disk");
        NSString *key = [manager cacheKeyForURL:url];
        [manager.imageCache removeImageForKey:key fromDisk:YES];
//    }
//    NSLog(@"%@",imgPath);
    if (IS_IPHONE_5) {
        [contentImageView setImageWithURL:[NSURL URLWithString:imgPath] placeholderImage:[UIImage imageNamed:BigLogoDefaultRetina]];
    }
    else{
        [contentImageView setImageWithURL:[NSURL URLWithString:imgPath] placeholderImage:[UIImage imageNamed:BigLogoDefault]];
    }

}
-(void)phoneButtonClicked:(id)sender
{
    [[CommonData Instance] phoneCall];
}
-(void)joinButtonClicked:(id)sender
{
    JoinView *joinView = [[JoinView alloc] initWithStyle:kDefaultStyle];
    joinView.delegate = self;
    [joinView showInView:[UIApplication sharedApplication].keyWindow];
}
-(void)joinView:(JoinView *)joinView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"tag========%i",self.tag);
    if (buttonIndex != 0) {

        [request requestSubmitGroupBuyWithPara:[self generateParaDictionary:joinView]];
        [[[[UIApplication sharedApplication] delegate] window] makeToastActivity];

    }
    
}
-(NSDictionary *)generateParaDictionary:(JoinView *)joinView
{
    NSArray *keys = [NSArray arrayWithObjects:@"name",@"mobile",@"houseID", nil];
    NSArray *values = [NSArray arrayWithObjects:joinView.name,joinView.phone,groupBuy.houseID, nil];
    if (keys.count == values.count) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjects:values forKeys:keys];
        
        return dic;
    }
    return nil;
}
-(void)submitGroupBuyRequestSuccess:(BOOL)success
{
    if (success) {
        NSArray *array = [[DBOperation Instance] selectGroupWithGroupID:groupBuy.houseID compareDate:NO];
        if (array.count == 0) {
            [[DBOperation Instance] insertMyGroupBuy:groupBuy];
        }
        NSString *text = [NSString stringWithFormat:@"恭喜您已成功报名此项团购，\n请至更多——我的预约中查看详细内容。"];
        JoinSuccessView *successView = [[JoinSuccessView alloc] initWithText:text];
        [successView show];
//        [[[[UIApplication sharedApplication] delegate] window] makeToast:@"恭喜您已成功报名此次活动，请至更多——我的预约中查看详细内容。" duration:3.0 position:@"center"];
    }
    else{
        [self joinFailed];
    }
}
-(void)submitGroupBuyRequestFailed:(NSString *)message
{
    [self joinFailed];
}
-(void)joinFailed
{
    [[[[UIApplication sharedApplication] delegate] window] makeToast:@"团购报名失败，请重新填写并提交" duration:2.0 position:@"center"];
    JoinView *joinView = [[JoinView alloc] initWithStyle:kSpecialStyle];
    joinView.delegate = self;
    [joinView showInView:[UIApplication sharedApplication].keyWindow];
}

@end
