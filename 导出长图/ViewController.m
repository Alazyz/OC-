//
//  ViewController.m
//  导出长图
//
//  Created by xhkj on 2018/4/4.
//  Copyright © 2018年 xhkj. All rights reserved.
//

#import "ViewController.h"

#define  ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewHeight;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *imgArray = [[NSArray alloc] initWithObjects:
                         [UIImage imageNamed:@"1.jpg"],
                         [UIImage imageNamed:@"2.jpg"],
                         [UIImage imageNamed:@"3.jpg"],
                         [UIImage imageNamed:@"4.jpg"],
                         [UIImage imageNamed:@"5.jpg"],
                         [UIImage imageNamed:@"1.jpg"],
                         [UIImage imageNamed:@"2.jpg"],
                         [UIImage imageNamed:@"3.jpg"],
                         [UIImage imageNamed:@"4.jpg"],
                         [UIImage imageNamed:@"5.jpg"],
                         [UIImage imageNamed:@"1.jpg"],
                         [UIImage imageNamed:@"2.jpg"],
                         [UIImage imageNamed:@"3.jpg"],
                         [UIImage imageNamed:@"4.jpg"],
                         [UIImage imageNamed:@"5.jpg"],
                         [UIImage imageNamed:@"1.jpg"],
                         [UIImage imageNamed:@"2.jpg"],
                         [UIImage imageNamed:@"3.jpg"],
                         [UIImage imageNamed:@"4.jpg"],
                         [UIImage imageNamed:@"5.jpg"],
                         [UIImage imageNamed:@"1.jpg"],
                         [UIImage imageNamed:@"2.jpg"],
                         [UIImage imageNamed:@"3.jpg"],
                         [UIImage imageNamed:@"4.jpg"],
                         [UIImage imageNamed:@"5.jpg"],
                         [UIImage imageNamed:@"1.jpg"],
                         [UIImage imageNamed:@"2.jpg"],
                         [UIImage imageNamed:@"3.jpg"],
                         [UIImage imageNamed:@"4.jpg"],
                         [UIImage imageNamed:@"5.jpg"],
                         [UIImage imageNamed:@"1.jpg"],
                         [UIImage imageNamed:@"2.jpg"],
                         [UIImage imageNamed:@"3.jpg"],
                         [UIImage imageNamed:@"4.jpg"],
                         [UIImage imageNamed:@"5.jpg"],
                         [UIImage imageNamed:@"1.jpg"],
                         [UIImage imageNamed:@"2.jpg"],
                         [UIImage imageNamed:@"3.jpg"],
                         [UIImage imageNamed:@"4.jpg"],
                         [UIImage imageNamed:@"5.jpg"],
                         [UIImage imageNamed:@"1.jpg"],
                         [UIImage imageNamed:@"2.jpg"],
                         [UIImage imageNamed:@"3.jpg"],
                         [UIImage imageNamed:@"4.jpg"],
                         [UIImage imageNamed:@"5.jpg"],
                         [UIImage imageNamed:@"1.jpg"],
                         [UIImage imageNamed:@"2.jpg"],
                         [UIImage imageNamed:@"3.jpg"],
                         [UIImage imageNamed:@"4.jpg"],
                         [UIImage imageNamed:@"5.jpg"],
                         [UIImage imageNamed:@"1.jpg"],
                         [UIImage imageNamed:@"2.jpg"],
                         [UIImage imageNamed:@"3.jpg"],
                         [UIImage imageNamed:@"4.jpg"],
                         [UIImage imageNamed:@"5.jpg"],
                         [UIImage imageNamed:@"1.jpg"],
                         [UIImage imageNamed:@"2.jpg"],
                         [UIImage imageNamed:@"3.jpg"],
                         [UIImage imageNamed:@"4.jpg"],
                         [UIImage imageNamed:@"5.jpg"],
                         nil];
    
    BOOL suc = [self mergedImageOnImageArray:imgArray];
    
    if (suc == YES) {
        NSLog(@"Images Successfully Mearged & Saved to Album");
    }
    else {
        NSLog(@"Images not Mearged & not Saved to Album");
    }
    
    
}


#pragma -mark -functions
//多张图片合成一张
- (BOOL) mergedImageOnImageArray:(NSArray *)imgArray
{
    CGFloat height = 0;
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *tempArray = [NSMutableArray array];

    for (int i = 0; i<imgArray.count; i++) {
        UIImage *img = imgArray[i];
        img = [self scaleImage:img withNewSize:CGSizeMake(ScreenWidth, ScreenWidth*(img.size.height/img.size.width))];
        height = [[tempArray valueForKeyPath:@"@sum.floatValue"] floatValue];
        NSLog(@"%f",height);
        [tempArray addObject:@(img.size.height)];
        [array addObject:@(height)];
        if (i == imgArray.count-1) {
            height = [[tempArray valueForKeyPath:@"@sum.floatValue"] floatValue];
        }
    }

    UIGraphicsBeginImageContext(CGSizeMake(ScreenWidth, height));
    
    for (int i = 0; i<imgArray.count; i++) {
        UIImage *img = imgArray[i];
        CGFloat y = [array[i] floatValue];
        img = [self scaleImage:img withNewSize:CGSizeMake(ScreenWidth, ScreenWidth*(img.size.height/img.size.width))];
        [img drawInRect:CGRectMake(0,y,img.size.width,img.size.height)];
    }
    
    UIImage *NewMergeImg = UIGraphicsGetImageFromCurrentImageContext();
    //CGImageCreateWithImageInRect(UIGraphicsGetImageFromCurrentImageContext().CGImage,CGRectMake(0, 0, mainImg.size.width, mainImg.size.height));
    
    UIGraphicsEndImageContext();
    if (NewMergeImg == nil) {
        return NO;
    }
    else {
        _imageView.image = NewMergeImg;
        _imageViewHeight.constant = NewMergeImg.size.height;
//        [self saveImagePhotoFinished:_imageView.image];

        return YES;
    }
}

- (UIImage *) scaleImage:(UIImage *) image withNewSize:(CGSize) newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark 保存图片到相册中
- (void)saveImagePhotoFinished:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image,self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(NSString *)contextInfo
{
    if (error != NULL) {
        NSLog(@"保存失败");
    } else {
        NSLog(@"保存成功");
    }
    
}


@end
