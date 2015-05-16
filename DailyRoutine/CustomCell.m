//
//  CustomCell.m
//  DailyRoutine
//
//  Created by Travis Delly on 5/15/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import "CustomCell.h"


@interface  CustomCell ()

@end


@implementation CustomCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circle"]];
        [self setFrame:CGRectMake(self.frame.origin.x , self.frame.origin.y, 65, 65)];
        self.layer.cornerRadius = self.frame.size.width / 2.0;
        self.layer.borderWidth = 3.0;
        self.clipsToBounds = YES;
        self.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        self.selectedBackgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.5f];
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.textColor = [UIColor blackColor];
        self.label.text = @"Travis";
        self.label.font = [UIFont boldSystemFontOfSize:15.0];
        
        [self.contentView addSubview:self.label];;
        
        
    }
    return self;
}



@end
