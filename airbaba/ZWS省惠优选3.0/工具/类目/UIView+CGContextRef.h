//
//  UIView+CGContextRef.h
//  dongfeng
//
//  Created by apple on 16/7/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (CGContextRef)

#warning 画版 只能在 - (void)drawRect:(CGRect)rect

/** 文字*/
-(void)text:(NSString*)text andDrawInRect:(CGRect)frame withAttributes:(NSDictionary*)dic;
/**边框圆  point 圆心  radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。 weight宽度
 */
-(void)round1:(UIColor*)color and:(CGPoint)point andradius:(CGFloat)radius andstartAngle:(CGFloat)startAngle andendAngle:(CGFloat)endAngle andclockwise:(BOOL)clockwise andLineWeight:(CGFloat)weight;

/**填充圆 point 圆心  radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
 */
-(void)round2:(UIColor*)color and:(CGPoint)point andradius:(CGFloat)radius andstartAngle:(CGFloat)startAngle andendAngle:(CGFloat)endAngle andclockwise:(BOOL)clockwise;

/**双圆  point 圆心  radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。 weight宽度 color圆填充色 color2 边框圆颜色
 */
-(void)round3:(UIColor*)color andColor:(UIColor*)color2 and:(CGPoint)point andradius:(CGFloat)radius andstartAngle:(CGFloat)startAngle andendAngle:(CGFloat)endAngle andclockwise:(BOOL)clockwise andLineWeight:(CGFloat)weight;


/** 直线 连线 */
-(void)setLineStartPoint:(CGPoint)startPoint andEndPoint:(CGPoint)endPoint andColor:(UIColor*)color andLineWeight:(CGFloat)weight;

/** 渐变色 背景颜色*/
- (void)shadowAsInversestatrColor:(UIColor*)statrColor endColor:(UIColor*)endColor andStartPoint:(CGPoint)  startPoint andEndPoint:(CGPoint)endPoint;

/** 渐变色 整体*/
- (void)shadowAsInversestatrColor:(UIColor*)statrColor endColor:(UIColor*)endColor;

#pragma mark /**CAShapeLayer：CAShapeLayer属于CoreAnimation框架，通过GPU来渲染图形，节省性能。动画渲染直接提交给手机GPU，不消耗内存*/

/** 边框圆*/
- (CAShapeLayer *)roundShapeLayer:(UIColor *)color and:(CGPoint)point andradius:(CGFloat)radius andstartAngle:(CGFloat)startAngle andendAngle:(CGFloat)endAngle  andLineWeight:(CGFloat)weight;
/**  无边框 圆*/
- (CAShapeLayer *)roundShapeLayer2:(UIColor *)color and:(CGPoint)point andradius:(CGFloat)radius andstartAngle:(CGFloat)startAngle andendAngle:(CGFloat)endAngle;
/** 实线 圆  */
- (CAShapeLayer *)roundShapeLayer:(UIColor *)color andLineColor:(UIColor *)lineColor and:(CGPoint)point andradius:(CGFloat)radius andstartAngle:(CGFloat)startAngle andendAngle:(CGFloat)endAngle  andLineWeight:(CGFloat)weight;

/** 渐变色圆 */
- (CAShapeLayer *)roundShapeLayer:(UIColor *)beingColor andEndColor:(UIColor *)endColor and:(CGPoint)point andradius:(CGFloat)radius andstartAngle:(CGFloat)startAngle andendAngle:(CGFloat)endAngle;


/**画 边框 虚线 lineColor 边框颜色 point圆心 radius半径 width 边框大小 lineDashPattern =@[@3, @1] 3=线的宽度 1=每条线的间距*/
- (CAShapeLayer *)roundShapeLayer:(UIColor *)lineColor and:(CGPoint)point andradius:(CGFloat)radius andstartAngle:(CGFloat)startAngle andendAngle:(CGFloat)endAngle andLineWeight:(CGFloat)weight andlineDashPattern:(NSArray*)lineDashPattern;
/** 直线 */
-(CAShapeLayer *)shapeLayer:(CGPoint)startPoint andEndPoint:(CGPoint)endPoint andColor:(UIColor*)color andLineWeight:(CGFloat)weight;

/** 直线 多点连线*/
-(CAShapeLayer *)shapeLayer:(NSArray*)linePathArr andColor:(UIColor*)color andLineWeight:(CGFloat)weight;


/** 曲线 */
-(CAShapeLayer *)shapeLayerCurve:(CGPoint)startPoint andEndPoint:(CGPoint)endPoint andColor:(UIColor*)color andLineWeight:(CGFloat)weight;

/** 曲线 多点连线*/
-(CAShapeLayer *)shapeLayerCurve:(NSArray*)linePathArr andColor:(UIColor*)color andLineWeight:(CGFloat)weight;

/**画 边框 虚线 color 边框颜色 width 边框大小 lineDashPattern =@[@3, @1] 3=线的宽度 1=每条线的间距 radius 圆角弧度*/
-(CAShapeLayer *)dottedLine:(UIColor*)color andWidth:(CGFloat)width andlineDashPattern:(NSArray*)lineDashPattern andCornerRadius:(CGFloat)radius;
/** CAShapeLayer 动画 **/
-(CABasicAnimation *)shapeLayerAddAnimation:(CAShapeLayer *)shapeLayer andTime:(CGFloat)time;
/**创建椭圆*/
- (CAShapeLayer *)roundShapeLayer:(UIColor *)color andCenter:(CGPoint)point andradius:(CGFloat)radius andstartAngle:(CGFloat)startAngle andendAngle:(CGFloat)endAngle  andLineWeight:(CGFloat)weight;

@end
