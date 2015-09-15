//
//  OperationClass.m
//  mapTestApp
//
//  Created by Mateusz Florczak on 15/09/15.
//  Copyright (c) 2015 Kainos Software Ltd. All rights reserved.
//

#import "OperationClass.h"

@implementation OperationClass

- (instancetype)initWithNumber:(NSInteger)number progressView:(CustomOperationViewCell *)progressCell {
    self = [super init];
    
    if (self != nil) {
        _number = number;
        _progressCell = progressCell;
    }
    
    return self;
}

- (void)main {
    int length = 50;
    
    if ([self isCancelled]) {
        NSLog(@"** operation cancelled **");
    }
    [self performSelectorOnMainThread:@selector(changeProgressStateWithColor:) withObject:[UIColor yellowColor] waitUntilDone:NO];
    
    for (int i = 0; i < length; ++i) {
        [NSThread sleepForTimeInterval:0.1];
        
        [self performSelectorOnMainThread:@selector(updateProgressWithValue:) withObject:@((i + 1.0) / length) waitUntilDone:NO];
        
        if (self.isCancelled) {
            NSLog(@"operation cancelled");
            return;
        }
    }
    
    NSLog(@"Operation finished");
    [self performSelectorOnMainThread:@selector(changeProgressStateWithColor:) withObject:[UIColor greenColor] waitUntilDone:NO];
}

- (void)updateProgressWithValue:(NSNumber *)value {
    self.progressCell.progressBar.progress = [value floatValue];
}

- (void)changeProgressStateWithColor:(UIColor *)color {
    self.progressCell.backgroundColor = color;
}

@end
