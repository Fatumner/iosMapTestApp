//
//  FlickerCollectionViewController.m
//  mapTestApp
//
//  Created by Mateusz Florczak on 14/09/15.
//  Copyright (c) 2015 Kainos Software Ltd. All rights reserved.
//

#import "FlickerCollectionViewController.h"
#import "FlickrCollectionViewCell.h"
#import "FlickrManager.h"

@interface FlickerCollectionViewController ()

@property (nonatomic) __block NSInteger itemCounter;
@property (nonatomic, strong) __block NSMutableArray *images;

@end

@implementation FlickerCollectionViewController

static NSString * const reuseIdentifier = @"FlickrCollectionViewCell";

void (^insertIntoCollectionViewImage)(FlickerCollectionViewController *, UIImage *) = ^(FlickerCollectionViewController *self, UIImage *image) {
    NSLog(@"inserting image");
    
    self.itemCounter++;
    [self.images addObject:image];
    
};

- (void)loadImage {
    NSLog(@"invoked");
    [self.collectionView reloadData];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.images = [[NSMutableArray alloc] init];
    self.itemCounter = 0;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(concurrentQueue, ^{
//        [FlickrManager loadImagesForPosition:self.position withBlock:insertIntoCollectionViewImage forView:self];
        [FlickrManager loadImagesForPosition:self.position withBlock:^(FlickerCollectionViewController *self, UIImage *image) {
            self.itemCounter++;
            [self.images addObject:image];
            NSLog(@"%@ - %@", [self.images lastObject], image);
            [self performSelectorOnMainThread:@selector(loadImage) withObject:nil waitUntilDone:NO];
        } forView:self];
    });
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"FlickrCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemCounter;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    FlickrCollectionViewCell *cell = (FlickrCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.image.image = [self.images objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>


@end
