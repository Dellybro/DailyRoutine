//
//  EditCellViewController.m
//  DailyRoutine
//
//  Created by Travis Delly on 5/15/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import "EditCellViewController.h"
@interface EditCellViewController()


@property (nonatomic, retain) UIImageView *backgroundImage;
-(void) saveChanges:(UIButton*)sender;

@end

@implementation EditCellViewController

-(void) saveChanges:(UIButton*)sender{
    
    if(_message.text.length > 0){
        [[_sharedDelegate.data objectAtIndex:_sectionPath] replaceObjectAtIndex:_rowPath withObject:_message.text];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert!" message:@"About to update with null" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *Cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            nil;
        }];
        UIAlertAction *OK = [UIAlertAction actionWithTitle:@"OK!" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [[_sharedDelegate.data objectAtIndex:_sectionPath] replaceObjectAtIndex:_rowPath withObject:_message.text];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        
        [alert addAction:OK];
        [alert addAction:Cancel];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
    }
    
    
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    NSLog(@"%ld, %ld", (long)_rowPath, (long)_sectionPath);
    self.sharedDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    UIImage *headerImage = [UIImage imageNamed:@"background"];
    self.backgroundImage.image = headerImage;
    
    [self.view addSubview:self.backgroundImage];
    [self.view sendSubviewToBack:_backgroundImage];
  
    self.view.backgroundColor = [UIColor whiteColor];
    
    _submit = [[UIButton alloc] initWithFrame:CGRectMake(135, 400, 100, 30)];
    [_submit setTitle:@"submit" forState:UIControlStateNormal];
    [_submit addTarget:self action:@selector(saveChanges:) forControlEvents:UIControlEventTouchUpInside];
    [_submit setBackgroundColor:[UIColor grayColor]];
    [_submit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _message = [[UITextField alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 100)];
    _message.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _message.textAlignment = NSTextAlignmentCenter;
    _message.placeholder = @"Fill in new message here";
//    UIColor *color = [UIColor grayColor];
//    _message.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"" attributes:@{NSForegroundColorAttributeName: color}];


    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 100)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:24];
    NSString* messages = [[_sharedDelegate.data objectAtIndex:_sectionPath] objectAtIndex:_rowPath];
    titleLabel.text = messages;
    
    
    
    
//
    [self.view addSubview:titleLabel];
    [self.view addSubview:_message];
    [self.view addSubview:_submit];
//    
    self.navigationItem.title = @"Edit Cell";
    
}
@end
