//
//  OperationsViewController.m
//  mapTestApp
//
//  Created by Mateusz Florczak on 15/09/15.
//  Copyright (c) 2015 Kainos Software Ltd. All rights reserved.
//

#import "OperationsViewController.h"
#import "CustomOperationViewCell.h"
#import "OperationClass.h"

@interface OperationsViewController ()

@property (nonatomic, strong) OperationClass *firstOperation;
@property (nonatomic, strong) OperationClass *secondOperation;
@property (nonatomic, strong) OperationClass *thirdOperation;
@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation OperationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    self.tableView.dataSource = self;
}

- (IBAction)startButtonPressed:(id)sender {
    [self.tableView reloadData];
    
    self.firstOperation = [[OperationClass alloc] initWithNumber:1 progressView:(CustomOperationViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]];
    self.secondOperation = [[OperationClass alloc] initWithNumber:2 progressView:(CustomOperationViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]];
    self.thirdOperation = [[OperationClass alloc] initWithNumber:3 progressView:(CustomOperationViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]]];
    
    self.operationQueue = [[NSOperationQueue alloc] init];
    
    [self.secondOperation addDependency:self.firstOperation];
    [self.thirdOperation addDependency:self.secondOperation];
    
    [self.operationQueue addOperations:@[ self.firstOperation, self.secondOperation, self.thirdOperation ] waitUntilFinished:NO];
}

- (IBAction)stopButtonPressed:(id)sender {
    [self.operationQueue cancelAllOperations];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Operation";
    
    CustomOperationViewCell *cell = (CustomOperationViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomOperationViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.progressBar.progress = 0.0;
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}

@end
