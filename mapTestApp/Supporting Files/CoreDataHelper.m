//
//  CoreDataHelper.m
//  mapTestApp
//
//  Created by Mateusz Florczak on 14/09/15.
//  Copyright (c) 2015 Kainos Software Ltd. All rights reserved.
//

#import "CoreDataHelper.h"
#import "AppDelegate.h"

@implementation CoreDataHelper

+ (NSManagedObjectContext *)managedObjectContext {
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    return app.managedObjectContext;
}

+ (NSArray *)fetchDataWithEntityName:(NSString *)EntityName {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:EntityName];
    
    return [[self managedObjectContext] executeFetchRequest:fetchRequest error:nil];
}

+ (NSFetchedResultsController *)fetchedResultsControllerWithEntityName:(NSString *)entityName {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entityName];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lon" ascending:YES];
    
    fetchRequest.sortDescriptors = @[ sortDescriptor ];
    
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc]
                                                            initWithFetchRequest:fetchRequest
                                                            managedObjectContext:[self managedObjectContext]
                                                            sectionNameKeyPath:nil
                                                            cacheName:nil];
    
    if ([fetchedResultsController performFetch:nil]) {
        NSLog(@"Data fetched successfully.");
    } else {
        NSLog(@"Cannot fetch data");
    }
    
    return fetchedResultsController;
}
@end
