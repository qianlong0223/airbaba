//
//  UIViewController+PhotoAlbum.m
//  shantingdaren
//
//  Created by apple on 2017/6/16.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "UIViewController+PhotoAlbum.h"

@implementation UIViewController (PhotoAlbum)


#pragma mark  ************* 本地相册上传 *****************
-(void)re_election
{
    UIActionSheet * actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"本地相册上传" otherButtonTitles:@"拍照上传", nil];
    [actionSheet showInView:self.view];
   
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0:
            [self localPhoto];
            break;
        case 1:
            [self takePhoto];
            break;
            
        default:
            break;
    }
    
}


-(void)localPhoto
{
    UIImagePickerController*  _pickerController=[UIImagePickerController new];
    _pickerController.delegate=self;
    //设置拍照后的图片可被编辑
    
    _pickerController.allowsEditing=YES;
    _pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:_pickerController animated:YES completion:nil];
    
}

//拍照
- (void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController*  _pickerController=[UIImagePickerController new];
        _pickerController.delegate=self;
        //设置拍照后的图片可被编辑
        
        _pickerController.allowsEditing=YES;
        _pickerController.sourceType=sourceType;
        
        _pickerController.showsCameraControls=YES;
        
        [self presentViewController:_pickerController animated:YES completion:nil];
        
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
    
}
#pragma mark 当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type;
    type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage * image;
        
        image= [info objectForKey:@"UIImagePickerControllerEditedImage"];
        dispatch_async(dispatch_get_main_queue(), ^{
        [self updateImage:image];
        });
        //        [self setImage:image];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)updateImage:(UIImage*)image
{
}



@end
