//
//  ViewController.m
//  MedianFilter
//
//  Created by Svitlana Moiseyenko on 11/25/16.
//  Copyright © 2016 Svitlana Moiseyenko. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURL *imageURL = [[NSBundle mainBundle] URLForResource:@"median" withExtension:@"jpg"];
    CIImage *inputImage = [CIImage imageWithContentsOfURL:imageURL];

    
    CIFilter *filter = [CIFilter filterWithName:@"CIMedianFilter"];
    [filter setDefaults];
    [filter setValue:inputImage forKey:@"inputImage"];
    
    CIImage *outputImage = [filter outputImage];
    self.imageView.image = [UIImage imageWithCIImage:outputImage];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
