//
//  ViewController.m
//  OpenCV-01
//
//  Created by Evren Yortuçboylu on 25/03/16.
//  Copyright © 2016 Evren Yortuçboylu. All rights reserved.
//

#import "ViewController.h"
#import <opencv2/opencv.hpp>
#import <opencv2/videoio/cap_ios.h>
#import <opencv2/core/core.hpp>

@implementation ViewController

CvVideoCamera* camera;
cv::Mat prevFrame(352,288, CV_8UC1);


- (void)viewDidLoad {
    [super viewDidLoad];
    
    camera = [[CvVideoCamera alloc] initWithParentView: self.imgView];
    camera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
    camera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
    camera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    camera.defaultFPS = 30;
    camera.grayscaleMode = NO;
    camera.delegate = self;
}

- (IBAction)startCamera:(id)sender {
    NSLog(@"starting camera");
    [camera start];
}

-(void)processImage:(cv::Mat&)image{
    // process image here
    
    cv::Mat imageCopy;
    cvtColor(image, imageCopy, CV_BGRA2BGR);
    
    // invert image
    //cv::bitwise_not(imageCopy, imageCopy);
    
    // take one pixel at x,y
    //cv::Vec3b color = imageCopy.at<cv::Vec3b>(cv::Point(1,5));
    // set image.at<Vec3b>(Point(x,y)) = color;
    
    for(int y=0; y<imageCopy.rows; y++)
    {
        for(int x=0; x<imageCopy.cols; x++)
        {
            // get pixel
            cv::Vec3b currentColor = image.at<cv::Vec3b>(cv::Point(x,y));
            cv::Vec3b prevColor = prevFrame.at<cv::Vec3b>(cv::Point(x,y));
            
            // ... do something to the color ....
            currentColor[0] = (currentColor[0] + prevColor[0])/2;
            
            // set pixel
            imageCopy.at<cv::Vec3b>(cv::Point(x,y)) = currentColor;
        }
    }
    
    cvtColor(imageCopy, image, CV_BGR2BGRA);
    
    prevFrame = image;
}
@end
