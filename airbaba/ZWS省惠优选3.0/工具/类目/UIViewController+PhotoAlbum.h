//
//  UIViewController+PhotoAlbum.h
//  shantingdaren
//
//  Created by apple on 2017/6/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (PhotoAlbum)<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

/** --------- 本地相册上传 --------- */
-(void)re_election;
//相册
-(void)localPhoto;
//拍照
- (void)takePhoto;

/** 获取图片后 */
-(void)updateImage:(UIImage*)image;

@end
