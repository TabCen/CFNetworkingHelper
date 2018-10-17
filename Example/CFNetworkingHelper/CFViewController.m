//
//  CFViewController.m
//  CFNetworkingHelper
//
//  Created by chenfeigogo@gmail.com on 10/17/2018.
//  Copyright (c) 2018 chenfeigogo@gmail.com. All rights reserved.
//

#import "CFViewController.h"

//#import <CFNetworkingHelper/CFNetworking.h>
#import <CFNetworkingHelper/CFNetworkingHelper.h>


@interface CFViewController ()

@end

@implementation CFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[CFNetworking jsonRequestHttpResponseManager] POST:@"http://114.55.236.18:8070/api/tangba/scan/test1.action" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        UIImage *portrait = [UIImage imageNamed:@"IMG_0375"];
        if (portrait!=nil) {
            //            NSData *data = UIImageJPEGRepresentation(portrait, 0.9);
            NSData *data = UIImagePNGRepresentation(portrait);
            NSString *fileName = [NSString stringWithFormat:@"cf%@.jpg", [NSDate new]];
            [formData appendPartWithFileData:data name:@"img" fileName:fileName mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull progress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    } showHUD:YES atView:self.view];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
