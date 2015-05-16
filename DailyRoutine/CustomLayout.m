//
//  CustomLayout.m
//  DailyRoutine
//
//  Created by Travis Delly on 5/15/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import "CustomLayout.h"

@interface CustomLayout ()
@property (nonatomic, assign) NSMutableArray* indexPathsToAnimate;
@end

@implementation CustomLayout

-(id)init{
    self = [super init];
    if (self){
        //Layout.
        self.itemSize = CGSizeMake(65.f, 65.f);
        self.sectionInset = UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.minimumInteritemSpacing = 10.f;
        self.minimumLineSpacing = 10.f;
    }
    return self;
}


@end
