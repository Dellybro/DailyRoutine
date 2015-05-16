//
//  EditCellViewController.h
//  DailyRoutine
//
//  Created by Travis Delly on 5/15/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface EditCellViewController : UIViewController


@property (assign, nonatomic) AppDelegate *sharedDelegate;
@property (nonatomic, assign) NSInteger rowPath;
@property (nonatomic, assign) NSInteger sectionPath;


@property (nonatomic) UIButton *submit;
@property (nonatomic) UITextField *message;

@end
