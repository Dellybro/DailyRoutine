//
//  AppDelegate.h
//  DailyRoutine
//
//  Created by Travis Delly on 5/13/15.
//  Copyright (c) 2015 Travis Delly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CustomLayout.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


//CoreDataAbove

@property(nonatomic, readonly) UICollectionViewLayout *collectionViewLayout;
-(void)setupRoot;

@property (nonatomic) NSMutableArray *data;
@property (nonatomic) NSMutableArray *headers;
-(void)setupData;


@end

