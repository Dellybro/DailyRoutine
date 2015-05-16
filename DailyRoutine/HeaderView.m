//
//  HeaderView.m
//  DailyRoutine
//
//  Created by Travis Delly on 5/15/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import "HeaderView.h"
#import "AppDelegate.h"

@interface HeaderView()

@property (nonatomic, retain) UIImageView *backgroundImage;

@end

@implementation HeaderView



- (id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor grayColor];
        //    cell.backgroundColor = [UIColor whiteColor];
        
        
        self.title = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.textColor = [UIColor orangeColor];
        self.title.font = [UIFont boldSystemFontOfSize:15.0];

        [self.viewForBaselineLayout addSubview:self.title];
    }
    return self;
}

-(void)prepareForReuse{
    self.backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    UIImage *headerImage = [UIImage imageNamed:@"headerset"];
    self.backgroundImage.image = headerImage;
    
    [self.viewForBaselineLayout addSubview:self.backgroundImage];
    [self.viewForBaselineLayout sendSubviewToBack:_backgroundImage];
}


@end
