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

@end
