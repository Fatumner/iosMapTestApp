//
//  PositionEditViewController.m
//  mapTestApp
//
//  Created by Mateusz Florczak on 14/09/15.
//  Copyright (c) 2015 Kainos Software Ltd. All rights reserved.
//

#import "PositionEditViewController.h"
#import "CoreDataHelper.h"

@interface PositionEditViewController ()

@end

@implementation PositionEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.latitudeTextField.text = [self.position.lat stringValue];
    self.longitudeTextField.text = [self.position.lon stringValue];
}

- (IBAction)saveButtonPressed:(id)sender {
    if ([self checkTextFields]) {
        
        if ([self saveChanges]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self cancelChanges];
}

- (void)markInvalidTextField:(UITextField *)textField {
    
}

- (BOOL)checkTextFields {
    for (id subview in [self.view subviews]) {
        if ([subview isKindOfClass:[UITextField class]]) {
            if (![self isTextFieldValid:(UITextField *)subview]) {
                [self markInvalidTextField:(UITextField *)subview];
                
                return NO;
            }
        }
    }
    
    return YES;
}

- (BOOL)saveChanges {
    self.position.lat = [NSNumber numberWithFloat:[self.latitudeTextField.text floatValue]];
    self.position.lon = [NSNumber numberWithFloat:[self.longitudeTextField.text floatValue]];
    
    NSError *savingError = nil;
    
    if ([[CoreDataHelper managedObjectContext] save:&savingError]) {
        NSLog(@"Successfully saved the context");
        
        return YES;
    } else {
        NSLog(@"Failed to save the context. Error = %@", savingError);
        
        return NO;
    }
}

- (void)cancelChanges {
    [self.navigationController popViewControllerAnimated:YES];
}


- (BOOL)isTextFieldValid:(UITextField *)textField {
    return YES;
}

@end
