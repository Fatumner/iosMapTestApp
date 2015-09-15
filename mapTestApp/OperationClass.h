//
//  OperationClass.h
//  mapTestApp
//
//  Created by Mateusz Florczak on 15/09/15.
//  Copyright (c) 2015 Kainos Software Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomOperationViewCell.h"

@interface OperationClass : NSOperation

@property (nonatomic) NSInteger number;
@property (nonatomic, strong) CustomOperationViewCell *progressCell;

- (instancetype)initWithNumber:(NSInteger)number progressView:(CustomOperationViewCell *)progressCell;

@end
