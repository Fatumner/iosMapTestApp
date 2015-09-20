//
//  FlickrManager.m
//  mapTestApp
//
//  Created by Mateusz Florczak on 20/09/15.
//  Copyright (c) 2015 Kainos Software Ltd. All rights reserved.
//

#import "FlickrManager.h"

@implementation FlickrManager

static NSString *api_key = @"9d0caed89e044d5d9e9131f5a7f1b8a0";
static NSInteger accuracy = 16;
static NSInteger maxImages = 5;

+ (void)loadImagesForPosition:(Position *)position withBlock:(void (^)(FlickerCollectionViewController *, UIImage *))block forView:(FlickerCollectionViewController *)view {
    NSArray *filesData = [self getImagesDataForPosition:position];
    
    if (filesData == nil) {
        return;
    }
    NSInteger imageCount = ([filesData count] < maxImages) ? [filesData count] : maxImages;
    for (NSInteger i = 0; i < imageCount; ++i) {
        
        [self loadImageWithFarm:filesData[i][@"farm"] serverId:filesData[i][@"server"] imageId:filesData[i][@"id"] secret:filesData[i][@"secret"] withBlock:block forView:view];
    }
    NSLog(@"images loaded");
}

+ (NSArray *)getImagesDataForPosition:(Position *)position {
    
    NSString *queryString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&lat=%.2f&lon=%.2f&accuracy=%ld&per_page=5&format=json&nojsoncallback=1", api_key, [position.lat floatValue], [position.lon floatValue], (long)accuracy];
    
    NSLog(@"%@", queryString);
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:queryString] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:5];
    
    NSError *requestError = nil;
    NSData *imagesData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&requestError];
    
    if (requestError != nil) {
        NSLog(@"%@", requestError);
        return nil;
    }
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:imagesData options:0 error:nil];
    return dict[@"photos"][@"photo"];
}

+ (void)loadImageWithFarm:(NSString *)farm serverId:(NSString *)serverId imageId:(NSString *)imageId secret:(NSString *)secret withBlock:(void (^)(FlickerCollectionViewController *, UIImage *))block forView:(FlickerCollectionViewController *)view {
    NSString *queryString = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", farm, serverId, imageId, secret];
    
    NSLog(@"%@", queryString);
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:queryString] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:5];
    
    NSError *requestError = nil;
    NSData *imageData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&requestError];
    
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    
    block(view, image);
}

@end
