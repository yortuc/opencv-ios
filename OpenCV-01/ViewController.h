//
//  ViewController.h
//  OpenCV-01
//
//  Created by Evren Yortuçboylu on 25/03/16.
//  Copyright © 2016 Evren Yortuçboylu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "opencv2/videoio/cap_ios.h"
#import "opencv2/core/core.hpp"

@interface ViewController : UIViewController<CvVideoCameraDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
- (IBAction)startCamera:(id)sender;

@end

