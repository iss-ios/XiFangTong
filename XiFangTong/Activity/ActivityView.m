//
//  ActivityView.m
//  XiFangTong
//
//  Created by issuser on 13-8-6.
//  Copyright (c) 2013年 YouYan. All rights reserved.
//

#import "ActivityView.h"
#import "JoinSuccessView.h"

@implementation ActivityView
@synthesize joinButton;
@synthesize activityImageView;
@synthesize activity;

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
        
        activityImageView = [[UIImageView alloc] init];
//        activityImageView.image = [UIImage imageNamed:@"activity_image"];
        activityImageView.frame = CGRectMake(5, 5, 280, 245+downHeight);
        [self addSubview:activityImageView];
        
        joinButton = [UIButton buttonWithType:UIButtonTypeCustom];
        joinButton.frame = CGRectMake(0, 265+downHeight, frame.size.width, 45);
        [joinButton setBackgroundImage:[UIImage imageNamed:@"activity_join"] forState:UIControlStateNormal];
        [joinButton addTarget:self action:@selector(joinButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:joinButton];
        
        phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        phoneButton.frame = CGRectMake(0, 325+downHeight, frame.size.width, 45);
        [phoneButton setBackgroundImage:[UIImage imageNamed:@"group_buy_phone2"] forState:UIControlStateNormal];
        [phoneButton addTarget:self action:@selector(phoneButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:phoneButton];
        request = [[SubmitActivityRequest alloc] init];
        request.delegate = self;
        
    }
    return self;
    
}
-(void)showActivity:(ActivityInfo *)info
{
    NSString *imgPath = [NSString stringWithFormat:@"%@%@",ImagePathURL,info.mbpic];
    NSURL *url = [NSURL URLWithString:imgPath];
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
//    if ([manager diskImageExistsForURL:url]) {
        NSLog(@"image exists in disk");
        NSString *key = [manager cacheKeyForURL:url];
        [manager.imageCache removeImageForKey:key fromDisk:YES];
//    }
    //    NSLog(@"%@",imgPath);
    if (IS_IPHONE_5) {
        [activityImageView setImageWithURL:[NSURL URLWithString:imgPath] placeholderImage:[UIImage imageNamed:BigLogoDefaultRetina]];
    }
    else{
        [activityImageView setImageWithURL:[NSURL URLWithString:imgPath] placeholderImage:[UIImage imageNamed:BigLogoDefault]];
    }
}
-(void)phoneButtonClicked:(id)sender
{
    [[CommonData Instance] phoneCall];
}
-(void)joinButtonClicked:(id)sender
{
    JoinView *joinView = [[JoinView alloc] initWithStyle:kSpecialStyle];
    joinView.delegate = self;
    [joinView showInView:[UIApplication sharedApplication].keyWindow];
}
-(void)joinView:(JoinView *)joinView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0) {

        [request requestSubmitActivityWithPara:[self generateParaDictionary:joinView]];
        [[[[UIApplication sharedApplication] delegate] window] makeToastActivity];

    }
}
-(NSDictionary *)generateParaDictionary:(JoinView *)joinView
{
    NSArray *keys = [NSArray arrayWithObjects:@"name",@"mobile",@"pNum",@"actCode", nil];
    NSArray *values = [NSArray arrayWithObjects:joinView.name,joinView.phone,[NSNumber numberWithInt:[joinView.count intValue]],activity.ztid, nil];
    if (keys.count == values.count) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjects:values forKeys:keys];

        return dic;
    }
    return nil;
}
-(void)submitActivityRequestSuccess:(BOOL)success
{
    if (success) {
        NSArray *array = [[DBOperation Instance] selectActiveWithActiveID:activity.activityID compareDate:NO];
        if (array.count == 0) {
            [[DBOperation Instance] insertMyActivity:activity];
        }
        NSString *text = [NSString stringWithFormat:@"恭喜您已成功报名此次活动，\n请至更多——我的预约中查看详细内容。"];
        JoinSuccessView *successView = [[JoinSuccessView alloc] initWithText:text];
        [successView show];
    }
    else{
        [self joinFailed];
    }
}
-(void)submitActivityRequestFailed:(NSString *)message
{
    [self joinFailed];
}
#pragma mark -
#pragma mark join failed
-(void)joinFailed
{
    [[[[UIApplication sharedApplication] delegate] window] makeToast:@"活动报名失败，请重新填写并提交" duration:2.0 position:@"center"];
    JoinView *joinView = [[JoinView alloc] initWithStyle:kSpecialStyle];
    joinView.delegate = self;
    [joinView showInView:[UIApplication sharedApplication].keyWindow];
}
@end
