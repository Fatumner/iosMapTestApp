//
//  CoordsTableViewController.m
//  mapTestApp
//
//  Created by Mateusz Florczak on 11/09/15.
//  Copyright (c) 2015 Kainos Software Ltd. All rights reserved.
//

#import "CoordsTableViewController.h"
#import "CoreDataHelper.h"
#import "CustomViewCell.h"
#import "FlickerCollectionViewController.h"
#import "PositionManager.h"
#import "MyAnnotation.h"
#import "MapViewController.h"

@interface CoordsTableViewController ()

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation CoordsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.fetchedResultsController = [CoreDataHelper fetchedResultsControllerWithEntityName:@"Position"];
    self.fetchedResultsController.delegate = self;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Fetched results controller

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    switch (type) {
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[ newIndexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView insertRowsAtIndexPaths:@[ newIndexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[ indexPath ] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.fetchedResultsController fetchedObjects] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Position";
    Position *position = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    CustomViewCell *cell = (CustomViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.longitude.text = [position.lon stringValue];
    cell.latitude.text = [position.lat stringValue];
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    FlickerCollectionViewController *flickerViewController = [[FlickerCollectionViewController alloc] initWithNibName:@"FlickerCollectionViewController" bundle:nil];
    
    [self.navigationController pushViewController:flickerViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 68;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FlickerCollectionViewController *flickerViewController = [[FlickerCollectionViewController alloc] initWithNibName:@"FlickerCollectionViewController" bundle:nil];
    
    [self.navigationController pushViewController:flickerViewController animated:YES];
}

@end
