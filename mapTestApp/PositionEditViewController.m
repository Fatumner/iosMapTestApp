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
    
    self.latitudeTextField.text = [self.numberFormatter stringFromNumber:self.position.lat];
    self.longitudeTextField.text = [self.numberFormatter stringFromNumber:self.position.lon];
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

- (BOOL)saveChanges {
    self.position.lat = [self.numberFormatter numberFromString:self.latitudeTextField.text];
    self.position.lon = [self.numberFormatter numberFromString:self.longitudeTextField.text];
    
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

- (void)markInvalidTextField:(UITextField *)textField {
    textField.backgroundColor = [UIColor redColor];
}

- (void)markValidTextField:(UITextField *)textField {
    textField.backgroundColor = [UIColor whiteColor];
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
    NSString *pattern = @"[0-9]{1,3}(\\.[0-9]*)?";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL match = [predicate evaluateWithObject:textField.text];
    
    if(match) {
        if ([[self.numberFormatter numberFromString:textField.text] doubleValue] > -180.0 && [[self.numberFormatter numberFromString:textField.text] doubleValue] < 180.0) {
            return YES;
        }
    }
    
    return NO;
}

@end
