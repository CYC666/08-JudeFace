//
//  ViewController.m
//  JudgeFace
//
//  Created by mac on 16/7/27.
//  Copyright © 2016年 CYC. All rights reserved.
//

#import "ViewController.h"
#import <CoreImage/CoreImage.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //带人脸的照片
    UIImage *image=[UIImage imageNamed:@"face.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 375, 667)];
    imageView.image = image;
    [self.view addSubview:imageView];
    NSArray *results=[self detectFaceWithImage:image];
    //可能会存在多个脸部，这里只考虑一张脸的情况
    if(results.count>0)
    {
        CIFaceFeature *face=[results firstObject];
        if(face.hasSmile)
            NSLog(@"有微笑");
        if(face.leftEyeClosed)
            NSLog(@"左眼闭着的");
        if(face.rightEyeClosed)
            NSLog(@"右眼闭着的");
        if(face.hasLeftEyePosition)
            NSLog(@"左眼位置：%@",NSStringFromCGPoint(face.leftEyePosition));
        if(face.hasRightEyePosition)
            NSLog(@"右眼位置：%@",NSStringFromCGPoint(face.rightEyePosition));
        if(face.hasMouthPosition)
            NSLog(@"嘴巴位置：%@",NSStringFromCGPoint(face.mouthPosition));
        NSLog(@"脸部区域：%@",NSStringFromCGRect(face.bounds));
        if(face.bounds.size.width==face.bounds.size.height)
            NSLog(@"脸蛋是圆的-.-");
    }
    
}


/**识别脸部*/
-(NSArray *)detectFaceWithImage:(UIImage *)faceImage
{
    NSDictionary *opts = [NSDictionary dictionaryWithObject:
                          CIDetectorAccuracyHigh forKey:CIDetectorAccuracy];
    CIDetector *detectoer=[CIDetector detectorOfType:CIDetectorTypeFace context:nil options:opts];
    CIImage *ciimage=[CIImage imageWithCGImage:faceImage.CGImage];
    NSArray *featrues=[detectoer featuresInImage:ciimage];
    if(featrues.count>0)
        return featrues;
    return nil;
}



































@end
