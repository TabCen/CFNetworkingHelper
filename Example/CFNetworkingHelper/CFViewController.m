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
    
    [[CFNetworking jsonRequestHttpResponseManager] POST:@"http://api.avatardata.cn/Drug/Code?key=a8fb7a894e7f4ed5ace0cea359990c7e&code=6923842900380" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    } showHUD:YES atView:self.view];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
