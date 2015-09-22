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

@property (nonatomic, strong) NSNumberFormatter *numberFormatter;

@end

@implementation PositionEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    
    self.numberFormatter = [[NSNumberFormatter alloc] init];
    self.numberFormatter.positiveFormat = @"0.##";
    self.numberFormatter.negativeFormat = @"-0.##";
    
    self.latitudeTextField.text = [self.numberFormatter stringFromNumber:self.position.lat];// [self.position.lat stringValue];
    self.longitudeTextField.text = [self.numberFormatter stringFromNumber:self.position.lon];// [self.position.lon stringValue];
}

- (IBAction)saveButtonPressed:(id)sender {
    //validation not finished
    //if ([self checkTextFields]) {
        
        if ([self saveChanges]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    //}
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self cancelChanges];
}

- (BOOL)saveChanges {
    self.position.lat = [self.numberFormatter numberFromString:self.latitudeTextField.text];// [NSNumber numberWithFloat:[self.latitudeTextField.text floatValue]];
    self.position.lon = [self.numberFormatter numberFromString:self.longitudeTextField.text];// [NSNumber numberWithFloat:[self.longitudeTextField.text floatValue]];
    
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

//validation not finished
/*- (void)markInvalidTextField:(UITextField *)textField {
    
}

- (void)markValidTextField:(UITextField *)textField {
    
}

- (BOOL)checkTextFields {
    for (id subview in [self.view subviews]) {
        if ([subview isKindOfClass:[UITextField class]]) {
            if (![self isTextFieldValid:(UITextField *)subview]) {
                [self markInvalidTextField:(UITextField *)subview];
                
                return NO;
            } else {
                [self markValidTextField:(UITextField *)subview];
            }
        }
    }
    
    return YES;
}


- (BOOL)isTextFieldValid:(UITextField *)textField {
    return YES;
}*/

@end
