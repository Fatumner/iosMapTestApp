//
//  CoreDataHelper.h
//  mapTestApp
//
//  Created by Mateusz Florczak on 14/09/15.
//  Copyright (c) 2015 Kainos Software Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataHelper : NSObject

+ (NSManagedObjectContext *)managedObjectContext;
+ (NSArray *)fetchDataWithEntityName:(NSString *)EntityName;
+ (NSFetchedResultsController *)fetchedResultsControllerWithEntityName:(NSString *)entityName;
+ (void)removeObject:(NSManagedObject *)object;

@end
