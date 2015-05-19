//
//  ViewController.m
//  DailyRoutine
//
//  Created by Travis Delly on 5/13/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import "ViewController.h"
#import "EditCellViewController.h"


//For antimation this is considered a Macro
//Macros are good for one like instance codes.
//I call this in my function by typing RADIANS(-5) as if i was passing in a parameter
//Can not put double into RADIANS macro.
#define RADIANS(degrees) ((degrees * M_PI) / 180)

@interface ViewController ()
@property (nonatomic, retain) UIBarButtonItem *AddItemButton;
@property AppDelegate *sharedDelegate;
@property (nonatomic, retain) UIBarButtonItem *deleteItemButton;

-(void)processDoubleTap:(UITapGestureRecognizer *)sender;

-(void)deleteHighLightedItem:(UIBarButtonItem*)sender;
-(void)addItemsToSectionAtIndexPath:(UIButton*) sender;

-(void)startWobble:(NSIndexPath*)index;
-(void)stopWobble:(NSIndexPath*)index;

@end

@implementation ViewController

-(void)processDoubleTap:(UITapGestureRecognizer *)sender{
    
    NSArray *Section = [self.collectionView indexPathsForSelectedItems];
    
    if(Section.count != 0){
        
        EditCellViewController *editCell = [[EditCellViewController alloc] init];
        
        NSArray *Section = [self.collectionView indexPathsForSelectedItems];
        NSInteger itemSection = ((NSIndexPath *)Section[0]).section;
        NSInteger itemRow = ((NSIndexPath *)Section[0]).row;
        
        editCell.rowPath = itemRow;
        editCell.sectionPath = itemSection;
        editCell.presenter = self;
        [self.navigationController showViewController:editCell sender:self];
        
        NSLog(@"Gesture Recognized");
    }
}

-(void)addItemsToSectionAtIndexPath:(UIButton*) sender{
    NSArray *Section = [self.collectionView indexPathsForSelectedItems];
    
    
    if(Section.count > 0){
        NSInteger itemSection = ((NSIndexPath *)Section[0]).section;
        //NSInteger itemRow = ((NSIndexPath *)Section[0]).row;
        
        NSInteger size = [[_sharedDelegate.data objectAtIndex:itemSection] count];
        
        [[_sharedDelegate.data objectAtIndex:itemSection] addObject:@"Double tap to edit"];
        
        [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:size inSection:itemSection]]];
        
        for (NSIndexPath *indexPath in [self.collectionView indexPathsForSelectedItems]) {
            [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
        }
    }
    
    
    self.navigationItem.leftBarButtonItem = _addSectionButton;
    self.navigationItem.rightBarButtonItem = _deleteSectionButton;
}


-(void)deleteHighLightedItem:(UIButton *)sender {
    NSArray *Section = [self.collectionView indexPathsForSelectedItems];
    
    if(Section.count > 0){
        NSInteger itemSection = ((NSIndexPath *)Section[0]).section;
        NSInteger itemRow = ((NSIndexPath *)Section[0]).row;
        
        if([[_sharedDelegate.data objectAtIndex:itemSection] count] > 1){
            
            [[_sharedDelegate.data objectAtIndex:itemSection] removeObjectAtIndex:itemRow];
            
            [self.collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:itemRow inSection:itemSection]]];
        }
    
        for (NSIndexPath *indexPath in [self.collectionView indexPathsForSelectedItems]) {
            [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
        }
    }
    
    self.navigationItem.leftBarButtonItem = _addSectionButton;
    self.navigationItem.rightBarButtonItem = _deleteSectionButton;
}

//SettupingHeader/Footer
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return self.useFooter ? CGSizeMake(60.0f, 30.0) : CGSizeZero;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return self.useHeader ? CGSizeMake(60.0f, 45.0) : CGSizeZero;
}


#pragma mark Data Source

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[_sharedDelegate.data objectAtIndex:section] count];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [_sharedDelegate.data count];
}

//dequeCell


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.label.text = [[_sharedDelegate.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    return cell;
}




-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    //If Kind is HEADER
    if(kind == UICollectionElementKindSectionHeader){
        HeaderView *header = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        
        header.title.delegate = self;
        
        header.title.tag = indexPath.section;
        
        NSString *text = [NSString stringWithFormat:@"%@", _sharedDelegate.headers[header.title.tag]];
        header.title.text = text;
        
        return header;
    }//ELSE IF KIND IS FOOTER
    else if (kind == UICollectionElementKindSectionFooter){
        UICollectionReusableView *footer = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        footer.backgroundColor = [UIColor grayColor];
        return footer;
        
    }
    return nil;
}




#pragma mark delegate methods didSelectItems/HightLightItems

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.navigationItem.rightBarButtonItem = _deleteItemButton;
    self.navigationItem.leftBarButtonItem = _AddItemButton;
    
    [self startWobble:indexPath];
    
    //NSLog(@"Selected %@", indexPath);
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self stopWobble:indexPath];
}
#pragma setup

-(void)viewDidAppear:(BOOL)animated{
    [self.collectionView reloadData];
    self.navigationItem.leftBarButtonItem = _addSectionButton;
    self.navigationItem.rightBarButtonItem = _deleteSectionButton;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    _sharedDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    _deleteItemButton = [[UIBarButtonItem alloc]initWithTitle:@"Delete Item" style:UIBarButtonItemStylePlain target:self action:@selector(deleteHighLightedItem:)];
    _AddItemButton = [[UIBarButtonItem alloc]initWithTitle:@"Add Item" style:UIBarButtonItemStylePlain target:self action:@selector(addItemsToSectionAtIndexPath:)];
    _addSectionButton = [[UIBarButtonItem alloc]initWithTitle:@"Add Section" style:UIBarButtonItemStylePlain target:self action:@selector(addSection:)];
    _deleteSectionButton = [[UIBarButtonItem alloc]initWithTitle:@"Delete Section" style:UIBarButtonItemStylePlain target:self action:@selector(deleteSection:)];
    
    
    [self.collectionView registerClass:[CustomCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.collectionView registerClass:[HeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    self.collectionView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"woodback"]];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(processDoubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    [doubleTap setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:doubleTap];
    
}


-(void)deleteSection:(id)sender{
    NSLog(@"%lu", (unsigned long)[_sharedDelegate.headers count]);
    NSLog(@"%lu", (unsigned long)[_sharedDelegate.data count]);
    
    if([_sharedDelegate.data count] > 1){
        
        [_sharedDelegate.data removeLastObject];
        [_sharedDelegate.headers removeLastObject];
        NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:[_sharedDelegate.data count]];
        
        
        [self.collectionView deleteSections:set];
    }
    
    
    
}
-(void)addSection:(id)sender{
    NSLog(@"%lu", (unsigned long)[_sharedDelegate.headers count]);
    NSLog(@"%lu", (unsigned long)[_sharedDelegate.data count]);
    
    NSMutableArray *newSection = [[NSMutableArray alloc] initWithObjects:@"Dbl tap to edit", nil];
    
    //When adding sections don't forget you have a header;
    [_sharedDelegate.data addObject:newSection];
    [_sharedDelegate.headers addObject:@"New Section"];
    
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:([_sharedDelegate.data count]-1)];
    
    
    [self.collectionView insertSections:set];
    
    [self.collectionView reloadData];
    
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    
    
    [super setEditing:editing animated:animated];
    NSIndexPath *newPath;
    
    if(editing == YES){
        for(int d1 = 0; d1 < [_sharedDelegate.data count]; d1++){
            for(int d2 = 0; d2 < [[_sharedDelegate.data objectAtIndex:d1] count]; d2++){
                
                newPath = [NSIndexPath indexPathForRow:d2 inSection:d1];
                [self startWobble:newPath];
                [_cellsToAnimate addObject:[self.collectionView cellForItemAtIndexPath:newPath]];
                
            }
        }
    } else if (editing == NO){
        for(int d1 = 0; d1 < [_sharedDelegate.data count]; d1++){
            for(int d2 = 0; d2 < [[_sharedDelegate.data objectAtIndex:d1] count]; d2++){
                
                newPath = [NSIndexPath indexPathForRow:d2 inSection:d1];
                [self stopWobble:newPath];
                [_cellsToAnimate removeObject:[self.collectionView cellForItemAtIndexPath:newPath]];
            }
            
        }
        
    }
}
-(void)startWobble:(NSIndexPath*)index{
    
    
    UICollectionViewCell *cellToAnimate = [self.collectionView cellForItemAtIndexPath:index];
    
    cellToAnimate.transform = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(20));
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse)
                     animations:^ {
                         cellToAnimate.transform = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(-20));
                     }completion:NULL];
    
    [_cellsToAnimate addObject:cellToAnimate];
}

-(void)stopWobble:(NSIndexPath *)index{
    UICollectionViewCell *cellToAnimate = [self.collectionView cellForItemAtIndexPath:index];
    
    [UIView animateWithDuration:0.25
                          delay:0.0
                        options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveLinear)
                     animations:^ {
                         cellToAnimate.transform = CGAffineTransformIdentity;
                     }completion:NULL];
    
    [_cellsToAnimate removeObject:cellToAnimate];
}


-(instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithCollectionViewLayout:layout];
    
    if(self){
        self.useHeader = YES;
        self.useFooter = NO;
        self.NumberofItems = 1;
        self.numberOfSection = 1;
    }
    return self;
}


@end
