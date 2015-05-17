//
//  ViewController.h
//  DailyRoutine
//
//  Created by Travis Delly on 5/13/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "HeaderView.h"
#import "CustomCell.h"
#import "AppDelegate.h"

@interface ViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UITextFieldDelegate>

@property (nonatomic, retain) UIBarButtonItem *addSectionButton;
@property (nonatomic, retain) UIBarButtonItem *deleteSectionButton;

-(void)addSection:(id)sender;
-(void)deleteSection:(id)sender;

@property (nonatomic, assign) BOOL useHeader;
@property (nonatomic, assign) BOOL useFooter;

@property (nonatomic, assign) NSInteger numberOfSection;

@property (nonatomic, assign) NSInteger NumberofItems;

@end

