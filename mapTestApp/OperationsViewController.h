//
//  OperationsViewController.h
//  mapTestApp
//
//  Created by Mateusz Florczak on 15/09/15.
//  Copyright (c) 2015 Kainos Software Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OperationsViewController : UIViewController <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)startButtonPressed:(id)sender;
- (IBAction)stopButtonPressed:(id)sender;

@end
