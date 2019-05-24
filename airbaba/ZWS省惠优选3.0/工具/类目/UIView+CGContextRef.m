//
//  UIView+CGContextRef.m
//  dongfeng
//
//  Created by apple on 16/7/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIView+CGContextRef.h"

#import "MyData.h"
@implementation UIView (CGContextRef)

/** 文字*/
-(void)text:(NSString*)text andDrawInRect:(CGRect)frame withAttributes:(NSDictionary*)dic
{
    [text drawInRect:frame withAttributes:dic];
}
#pragma mark 画圆
/**边框圆  point 圆心  radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。 weight宽度
*/
-(void)round1:(UIColor*)color and:(CGPoint)point andradius:(CGFloat)radius andstartAngle:(CGFloat)startAngle andendAngle:(CGFloat)endAngle andclockwise:(BOOL)clockwise andLineWeight:(CGFloat)weight
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSArray * arr=[color getColorRGBA];
    //边框圆
    CGContextSetRGBStrokeColor(context,[arr[0]floatValue],[arr[1]floatValue],[arr[2]floatValue],[arr[3]floatValue]);//画笔线的颜色
    CGContextSetLineWidth(context, weight);//线的宽度
    //void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
    // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
    CGContextAddArc(context, point.x, point.y, radius, startAngle, endAngle, clockwise); //添加一个圆
    CGContextDrawPath(context, kCGPathStroke); //绘制路径
}
/**填充圆 point 圆心  radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
 */
-(void)round2:(UIColor*)color and:(CGPoint)point andradius:(CGFloat)radius andstartAngle:(CGFloat)startAngle andendAngle:(CGFloat)endAngle andclockwise:(BOOL)clockwise
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //填充圆，无边框
    CGContextAddArc(context, point.x, point.y, radius, startAngle, endAngle, clockwise); //添加一个圆
    CGContextDrawPath(context, kCGPathFill);//绘制填充
    
    [self round3:color andColor:nil and:point andradius:radius andstartAngle:startAngle andendAngle:endAngle andclockwise:0 andLineWeight:0];
}
/**双圆  point 圆心  radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。 weight宽度 color圆填充色 color2 边框圆颜色
 */
-(void)round3:(UIColor*)color andColor:(UIColor*)color2 and:(CGPoint)point andradius:(CGFloat)radius andstartAngle:(CGFloat)startAngle andendAngle:(CGFloat)endAngle andclockwise:(BOOL)clockwise andLineWeight:(CGFloat)weight
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    //边框圆
    NSArray * arr=[color2 getColorRGBA];
    //边框圆
    CGContextSetRGBStrokeColor(context,[arr[0]floatValue],[arr[1]floatValue],[arr[2]floatValue],[arr[3]floatValue]);//画笔线的颜色
    //void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
    // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
    
    //画大圆并填充颜
    
    arr=[color2 getColorRGBA];
    //边框圆
    CGContextSetRGBStrokeColor(context,[arr[0]floatValue],[arr[1]floatValue],[arr[2]floatValue],[arr[3]floatValue]);
    
    CGContextSetFillColorWithColor(context, color.CGColor);//填充颜色
    CGContextSetLineWidth(context, weight);//线的宽度
    CGContextAddArc(context, point.x, point.y, radius, startAngle, endAngle, clockwise); //添加一个圆
    //kCGPathFill填充非零绕数规则,kCGPathEOFill表示用奇偶规则,kCGPathStroke路径,kCGPathFillStroke路径填充,kCGPathEOFillStroke表示描线，不是填充
    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径加填充
}
/** 渐变色 */
- (void)shadowAsInversestatrColor:(UIColor*)statrColor endColor:(UIColor*)endColor andStartPoint:(CGPoint)  startPoint andEndPoint:(CGPoint)endPoint
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = {0,1};
    NSArray *colors = @[(__bridge id)statrColor.CGColor, (__bridge id)endColor.CGColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef) colors, locations);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    CGGradientRelease(gradient);
    UIGraphicsPopContext();
}

- (void)shadowAsInversestatrColor:(UIColor*)statrColor endColor:(UIColor*)endColor
{
    [self.layer addSublayer:[UIColor shadowAsInverse:CGRectMake(0, 0, viewWidth, viewHeight) statrColor:statrColor endColor:endColor]];
}

/** 直线 连线 */
-(void)setLineStartPoint:(CGPoint)startPoint andEndPoint:(CGPoint)endPoint andColor:(UIColor*)color andLineWeight:(CGFloat)weight
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, weight);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    
//    CGContextSetFillColorWithColor(context, color.CGColor);//填充颜色
    CGContextSetStrokeColorWithColor(context, color.CGColor);
//    CGContextSetRGBStrokeColor(context, 70.0 / 255.0, 241.0 / 255.0, 241.0 / 255.0, 1.0);  //线的颜色
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);  //起点坐标
    CGContextAddLineToPoint(context,endPoint.x, endPoint.y);   //终点坐标
    
    CGContextStrokePath(context);
    
}

#pragma mark  CAShapeLayer：CAShapeLayer属于CoreAnimation框架，通过GPU来渲染图形，节省性能。动画渲染直接提交给手机GPU，不消耗内存

- (CAShapeLayer *)roundShapeLayer:(UIColor *)color and:(CGPoint)point andradius:(CGFloat)radius andstartAngle:(CGFloat)startAngle andendAngle:(CGFloat)endAngle  andLineWeight:(CGFloat)weight
{
    //创建出CAShapeLayer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0, 0, radius, radius);//设置shapeLayer的尺寸和位置
    shapeLayer.position = point;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
    
    //设置线条的宽度和颜色
    shapeLayer.lineWidth = weight;
    shapeLayer.strokeColor = color.CGColor;
    
    shapeLayer.strokeStart=startAngle;
    shapeLayer.strokeEnd=endAngle;
    
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath =
//    [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)];
    [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius/2, radius/2) radius:radius/2  startAngle:M_PI*2*0.25 endAngle:M_PI*2+M_PI*2*0.25 clockwise:YES];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    shapeLayer.path = circlePath.CGPath;
    
    //添加并显示
    [self.layer addSublayer:shapeLayer];
    
    return shapeLayer;
}

- (CAShapeLayer *)roundShapeLayer2:(UIColor *)color and:(CGPoint)point andradius:(CGFloat)radius andstartAngle:(CGFloat)startAngle andendAngle:(CGFloat)endAngle
{
    return [self roundShapeLayer:color andLineColor:[UIColor clearColor] and:point andradius:radius andstartAngle:startAngle andendAngle:endAngle andLineWeight:0];
}

- (CAShapeLayer *)roundShapeLayer:(UIColor *)color andLineColor:(UIColor *)lineColor and:(CGPoint)point andradius:(CGFloat)radius andstartAngle:(CGFloat)startAngle andendAngle:(CGFloat)endAngle  andLineWeight:(CGFloat)weight
{
    //创建出CAShapeLayer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0, 0, radius, radius);//设置shapeLayer的尺寸和位置
    shapeLayer.position = point;
    shapeLayer.fillColor = color.CGColor;//填充颜色为ClearColor
    
    //设置线条的宽度和颜色
    shapeLayer.lineWidth = weight;
    shapeLayer.strokeColor = lineColor.CGColor;
    
    shapeLayer.strokeStart=startAngle;
    shapeLayer.strokeEnd=endAngle;
    
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath =
    //    [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)];
    [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius/2, radius/2) radius:radius  startAngle:M_PI*2*startAngle endAngle:M_PI*2*endAngle clockwise:YES];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    shapeLayer.path = circlePath.CGPath;
    
    //添加并显示
    [self.layer addSublayer:shapeLayer];
    
    return shapeLayer;
}
/** 渐变色圆 */
- (CAShapeLayer *)roundShapeLayer:(UIColor *)beingColor andEndColor:(UIColor *)endColor and:(CGPoint)point andradius:(CGFloat)radius andstartAngle:(CGFloat)startAngle andendAngle:(CGFloat)endAngle
{
    
    CAShapeLayer* _shapeLayer = [CAShapeLayer layer];//创建一个track shape layer
    _shapeLayer.frame = self.bounds;
    [self.layer addSublayer:_shapeLayer];
    
    
    _shapeLayer.fillColor = [endColor CGColor];
    _shapeLayer.strokeColor = [beingColor CGColor];//指定path的渲染颜色
    _shapeLayer.opacity = 0.25; //背景同学你就甘心做背景吧，不要太明显了，透明度小一点
    _shapeLayer.lineCap = kCALineCapRound;//指定线的边缘是圆的
    _shapeLayer.lineWidth = 0;//线的宽度
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(40, 40) radius: radius/2 startAngle:2*M_PI*startAngle  endAngle:2*M_PI*endAngle clockwise:YES];//上面说明过了用来构建圆形
    _shapeLayer.path =[path CGPath]; //把path传递給layer，然后layer会处理相应的渲染，整个逻辑和CoreGraph是一致的。
    
    return _shapeLayer;
}

/**画 边框 虚线 lineColor 边框颜色 point圆心 radius半径 width 边框大小 lineDashPattern =@[@3, @1] 3=线的宽度 1=每条线的间距*/
- (CAShapeLayer *)roundShapeLayer:(UIColor *)lineColor and:(CGPoint)point andradius:(CGFloat)radius andstartAngle:(CGFloat)startAngle andendAngle:(CGFloat)endAngle andLineWeight:(CGFloat)weight andlineDashPattern:(NSArray*)lineDashPattern
{
    //创建出CAShapeLayer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(0, 0, radius, radius);//设置shapeLayer的尺寸和位置
    shapeLayer.position = point;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色为ClearColor
    
    //设置线条的宽度和颜色
    shapeLayer.lineWidth = weight;
    shapeLayer.strokeColor = lineColor.CGColor;
    shapeLayer.lineJoin=kCALineJoinRound;
    shapeLayer.lineDashPattern=lineDashPattern;
    
    shapeLayer.strokeStart=startAngle;
    shapeLayer.strokeEnd=endAngle;
    
    //创建出圆形贝塞尔曲线
    UIBezierPath *circlePath =
    //    [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)];
    [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius/2, radius/2) radius:radius  startAngle:M_PI*2*startAngle endAngle:M_PI*2*endAngle clockwise:YES];
    
    //让贝塞尔曲线与CAShapeLayer产生联系
    shapeLayer.path = circlePath.CGPath;
    
    //添加并显示
    [self.layer addSublayer:shapeLayer];
    
    return shapeLayer;
}


/**画 边框 虚线 color 边框颜色 width 边框大小 lineDashPattern =@[@3, @1] 3=线的宽度 1=每条线的间距 radius 圆角弧度*/
-(CAShapeLayer *)dottedLine:(UIColor*)color andWidth:(CGFloat)width andlineDashPattern:(NSArray*)lineDashPattern andCornerRadius:(CGFloat)radius
{
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius];

    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    
     shapeLayer.strokeColor = color.CGColor;
    
     shapeLayer.fillColor = nil;
    
     shapeLayer.path = bezierPath.CGPath;
        
    shapeLayer.frame = self.bounds;
    
     shapeLayer.lineWidth = width;
    
//     shapeLayer.lineCap = @"square";
    
     shapeLayer.lineDashPattern =lineDashPattern ;
    
    [self.layer addSublayer: shapeLayer];
    
    return  shapeLayer;
}

-(CAShapeLayer *)shapeLayer:(CGPoint)startPoint andEndPoint:(CGPoint)endPoint andColor:(UIColor*)color andLineWeight:(CGFloat)weight
{
    // 线的路径
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    // 起点
    [linePath moveToPoint:startPoint];
    // 其他点
    [linePath addLineToPoint:endPoint];
//    [linePath addLineToPoint:CGPointMake(180, 50)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    shapeLayer.lineWidth = weight;
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.path = linePath.CGPath;
    shapeLayer.fillColor = nil; // 默认为blackColor
    //添加并显示
    [self.layer addSublayer:shapeLayer];
    
    return shapeLayer;
}

-(CAShapeLayer *)shapeLayer:(NSArray*)linePathArr andColor:(UIColor*)color andLineWeight:(CGFloat)weight
{
    // 线的路径
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    CGPoint  point;
    for (int a=0; a<linePathArr.count; a++)
    {
        point=[linePathArr[a] CGPointValue];

        if (a)
        {
            [linePath addLineToPoint:point];

        }else
        // 起点
        [linePath moveToPoint:point];
    }
//    // 起点
//    [linePath moveToPoint:startPoint];
//    // 其他点
//    [linePath addLineToPoint:endPoint];
    //    [linePath addLineToPoint:CGPointMake(180, 50)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    shapeLayer.lineWidth = weight;
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.path = linePath.CGPath;
    shapeLayer.fillColor = nil; // 默认为blackColor
    //添加并显示
    [self.layer addSublayer:shapeLayer];
    
    return shapeLayer;
}



-(CAShapeLayer *)shapeLayerCurve:(CGPoint)startPoint andEndPoint:(CGPoint)endPoint andColor:(UIColor*)color andLineWeight:(CGFloat)weight
{
    // 线的路径
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    
    // 起点
    [linePath moveToPoint:startPoint];
    
    [linePath addQuadCurveToPoint:endPoint controlPoint:CGPointMake((startPoint.x+endPoint.x)/2,(endPoint.y-startPoint.y)*0.05+endPoint.y)]; // 二次贝塞尔曲线
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    shapeLayer.lineWidth = weight;
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.path = linePath.CGPath;
    shapeLayer.fillColor = nil; // 默认为blackColor
    //添加并显示
    [self.layer addSublayer:shapeLayer];
    
    return shapeLayer;
}
-(CAShapeLayer *)shapeLayerCurve:(NSArray*)linePathArr andColor:(UIColor*)color andLineWeight:(CGFloat)weight
{
    // 线的路径
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    CGPoint  beingPoint=[linePathArr[0] CGPointValue];
    CGPoint  endPoint;
    for (int a=0; a<linePathArr.count; a++)
    {
        endPoint=[linePathArr[a] CGPointValue];
        if (a)
        {

            [linePath addQuadCurveToPoint:endPoint controlPoint:CGPointMake((beingPoint.x+endPoint.x)/2,(endPoint.y-beingPoint.y)*0.05+endPoint.y)]; // 二次贝塞尔曲线
            beingPoint=endPoint;
            
        }else
            // 起点
            [linePath moveToPoint:beingPoint];
    }
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    shapeLayer.lineWidth = weight;
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.path = linePath.CGPath;
    shapeLayer.fillColor = nil; // 默认为blackColor
    //添加并显示
    [self.layer addSublayer:shapeLayer];
    
    return shapeLayer;
}

-(CABasicAnimation *)shapeLayerAddAnimation:(CAShapeLayer *)shapeLayer andTime:(CGFloat)time
{
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];

    basicAnimation.duration = time;
    basicAnimation.fromValue = @(0.0f);
    basicAnimation.toValue = @(1.0f);
    
    
    [shapeLayer addAnimation:basicAnimation forKey:@"checkAnimation"];
    
    return basicAnimation;
}

/** 创建椭圆  */
- (CAShapeLayer *)roundShapeLayer:(UIColor *)color  andCenter:(CGPoint)point andradius:(CGFloat)radius andstartAngle:(CGFloat)startAngle andendAngle:(CGFloat)endAngle  andLineWeight:(CGFloat)weight
{
    //  创建椭圆一个路径
    UIBezierPath *path =[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, point.x, point.y) cornerRadius:radius];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    shapeLayer.lineWidth = weight;
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor=[UIColor clearColor].CGColor;
    
    shapeLayer.strokeStart=startAngle;
    shapeLayer.strokeEnd=endAngle;
    shapeLayer.position = point;
//    圆角
    shapeLayer.lineCap = kCALineCapRound;

    [self.layer addSublayer:shapeLayer];
    
    return shapeLayer;
}

//- (void)drawRect:(CGRect)rect
//{
//    //An opaque type that represents a Quartz 2D drawing environment.
//    //一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    /*写文字*/
//    CGContextSetRGBFillColor (context,  1, 0, 0, 1.0);//设置填充颜色
//    UIFont  *font = [UIFont boldSystemFontOfSize:15.0];//设置
//    [@"画圆：" drawInRect:CGRectMake(10, 20, 80, 20) withFont:font];
//    [@"画线及孤线：" drawInRect:CGRectMake(10, 80, 100, 20) withFont:font];
//    [@"画矩形：" drawInRect:CGRectMake(10, 120, 80, 20) withFont:font];
//    [@"画扇形和椭圆：" drawInRect:CGRectMake(10, 160, 110, 20) withFont:font];
//    [@"画三角形：" drawInRect:CGRectMake(10, 220, 80, 20) withFont:font];
//    [@"画圆角矩形：" drawInRect:CGRectMake(10, 260, 100, 20) withFont:font];
//    [@"画贝塞尔曲线：" drawInRect:CGRectMake(10, 300, 100, 20) withFont:font];
//    [@"图片：" drawInRect:CGRectMake(10, 340, 80, 20) withFont:font];
//    
//    /*画圆*/
//    //边框圆
//    CGContextSetRGBStrokeColor(context,1,1,1,1.0);//画笔线的颜色
//    CGContextSetLineWidth(context, 1.0);//线的宽度
//    //void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
//    // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
//    CGContextAddArc(context, 100, 20, 15, 0, 2*M_PI, 0); //添加一个圆
//    CGContextDrawPath(context, kCGPathStroke); //绘制路径
//    
//    //填充圆，无边框
//    CGContextAddArc(context, 150, 30, 30, 0, 2*M_PI, 0); //添加一个圆
//    CGContextDrawPath(context, kCGPathFill);//绘制填充
//    
//    //画大圆并填充颜
//    UIColor*aColor = [UIColor colorWithRed:1 green:0.0 blue:0 alpha:1];
//    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
//    CGContextSetLineWidth(context, 3.0);//线的宽度
//    CGContextAddArc(context, 250, 40, 40, 0, 2*M_PI, 0); //添加一个圆
//    //kCGPathFill填充非零绕数规则,kCGPathEOFill表示用奇偶规则,kCGPathStroke路径,kCGPathFillStroke路径填充,kCGPathEOFillStroke表示描线，不是填充
//    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径加填充
//    
//    /*画线及孤线*/
//    //画线
//    CGPoint aPoints[2];//坐标点
//    aPoints[0] =CGPointMake(100, 80);//坐标1
//    aPoints[1] =CGPointMake(130, 80);//坐标2
//    //CGContextAddLines(CGContextRef c, const CGPoint points[],size_t count)
//    //points[]坐标数组，和count大小
//    CGContextAddLines(context, aPoints, 2);//添加线
//    CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
//    
//    //画笑脸弧线
//    //左
//    CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);//改变画笔颜色
//    CGContextMoveToPoint(context, 140, 80);//开始坐标p1
//    //CGContextAddArcToPoint(CGContextRef c, CGFloat x1, CGFloat y1,CGFloat x2, CGFloat y2, CGFloat radius)
//    //x1,y1跟p1形成一条线的坐标p2，x2,y2结束坐标跟p3形成一条线的p3,radius半径,注意, 需要算好半径的长度,
//    CGContextAddArcToPoint(context, 148, 68, 156, 80, 10);
//    CGContextStrokePath(context);//绘画路径
//    
//    //右
//    CGContextMoveToPoint(context, 160, 80);//开始坐标p1
//    //CGContextAddArcToPoint(CGContextRef c, CGFloat x1, CGFloat y1,CGFloat x2, CGFloat y2, CGFloat radius)
//    //x1,y1跟p1形成一条线的坐标p2，x2,y2结束坐标跟p3形成一条线的p3,radius半径,注意, 需要算好半径的长度,
//    CGContextAddArcToPoint(context, 168, 68, 176, 80, 10);
//    CGContextStrokePath(context);//绘画路径
//    
//    //右
//    CGContextMoveToPoint(context, 150, 90);//开始坐标p1
//    //CGContextAddArcToPoint(CGContextRef c, CGFloat x1, CGFloat y1,CGFloat x2, CGFloat y2, CGFloat radius)
//    //x1,y1跟p1形成一条线的坐标p2，x2,y2结束坐标跟p3形成一条线的p3,radius半径,注意, 需要算好半径的长度,
//    CGContextAddArcToPoint(context, 158, 102, 166, 90, 10);
//    CGContextStrokePath(context);//绘画路径
//    //注，如果还是没弄明白怎么回事，请参考：http://donbe.blog.163.com/blog/static/138048021201052093633776/
//    
//    /*画矩形*/
//    CGContextStrokeRect(context,CGRectMake(100, 120, 10, 10));//画方框
//    CGContextFillRect(context,CGRectMake(120, 120, 10, 10));//填充框
//    //矩形，并填弃颜色
//    CGContextSetLineWidth(context, 2.0);//线的宽度
//    aColor = [UIColor blueColor];//blue蓝色
//    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
//    aColor = [UIColor yellowColor];
//    CGContextSetStrokeColorWithColor(context, aColor.CGColor);//线框颜色
//    CGContextAddRect(context,CGRectMake(140, 120, 60, 30));//画方框
//    CGContextDrawPath(context, kCGPathFillStroke);//绘画路径
//    
//    //矩形，并填弃渐变颜色
//    //关于颜色参考http://blog.sina.com.cn/s/blog_6ec3c9ce01015v3c.html
//    //http://blog.csdn.net/reylen/article/details/8622932
//    //第一种填充方式，第一种方式必须导入类库quartcore并#import <QuartzCore/QuartzCore.h>，这个就不属于在context上画，而是将层插入到view层上面。那么这里就设计到Quartz Core 图层编程了。
//    CAGradientLayer *gradient1 = [CAGradientLayer layer];
//    gradient1.frame = CGRectMake(240, 120, 60, 30);
//    gradient1.colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor,
//                        (id)[UIColor grayColor].CGColor,
//                        (id)[UIColor blackColor].CGColor,
//                        (id)[UIColor yellowColor].CGColor,
//                        (id)[UIColor blueColor].CGColor,
//                        (id)[UIColor redColor].CGColor,
//                        (id)[UIColor greenColor].CGColor,
//                        (id)[UIColor orangeColor].CGColor,
//                        (id)[UIColor brownColor].CGColor,nil];
//    [self.layer insertSublayer:gradient1 atIndex:0];
//    //第二种填充方式
//    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
//    CGFloat colors[] =
//    {
//        1,1,1, 1.00,
//        1,1,0, 1.00,
//        1,0,0, 1.00,
//        1,0,1, 1.00,
//        0,1,1, 1.00,
//        0,1,0, 1.00,
//        0,0,1, 1.00,
//        0,0,0, 1.00,
//    };
//    CGGradientRef gradient = CGGradientCreateWithColorComponents
//    (rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));//形成梯形，渐变的效果
//    CGColorSpaceRelease(rgb);
//    //画线形成一个矩形
//    //CGContextSaveGState与CGContextRestoreGState的作用
//    /*
//     CGContextSaveGState函数的作用是将当前图形状态推入堆栈。之后，您对图形状态所做的修改会影响随后的描画操作，但不影响存储在堆栈中的拷贝。在修改完成后，您可以通过CGContextRestoreGState函数把堆栈顶部的状态弹出，返回到之前的图形状态。这种推入和弹出的方式是回到之前图形状态的快速方法，避免逐个撤消所有的状态修改；这也是将某些状态（比如裁剪路径）恢复到原有设置的唯一方式。
//     */
//    CGContextSaveGState(context);
//    CGContextMoveToPoint(context, 220, 90);
//    CGContextAddLineToPoint(context, 240, 90);
//    CGContextAddLineToPoint(context, 240, 110);
//    CGContextAddLineToPoint(context, 220, 110);
//    CGContextClip(context);//context裁剪路径,后续操作的路径
//    //CGContextDrawLinearGradient(CGContextRef context,CGGradientRef gradient, CGPoint startPoint, CGPoint endPoint,CGGradientDrawingOptions options)
//    //gradient渐变颜色,startPoint开始渐变的起始位置,endPoint结束坐标,options开始坐标之前or开始之后开始渐变
//    CGContextDrawLinearGradient(context, gradient,CGPointMake
//                                (220,90) ,CGPointMake(240,110),
//                                kCGGradientDrawsAfterEndLocation);
//    CGContextRestoreGState(context);// 恢复到之前的context
//    
//    //再写一个看看效果
//    CGContextSaveGState(context);
//    CGContextMoveToPoint(context, 260, 90);
//    CGContextAddLineToPoint(context, 280, 90);
//    CGContextAddLineToPoint(context, 280, 100);
//    CGContextAddLineToPoint(context, 260, 100);
//    CGContextClip(context);//裁剪路径
//    //说白了，开始坐标和结束坐标是控制渐变的方向和形状
//    CGContextDrawLinearGradient(context, gradient,CGPointMake
//                                (260, 90) ,CGPointMake(260, 100),
//                                kCGGradientDrawsAfterEndLocation);
//    CGContextRestoreGState(context);// 恢复到之前的context
//    
//    //下面再看一个颜色渐变的圆
//    CGContextDrawRadialGradient(context, gradient, CGPointMake(300, 100), 0.0, CGPointMake(300, 100), 10, kCGGradientDrawsBeforeStartLocation);
//    
//    /*画扇形和椭圆*/
//    //画扇形，也就画圆，只不过是设置角度的大小，形成一个扇形
//    aColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:1];
//    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
//    //以10为半径围绕圆心画指定角度扇形
//    CGContextMoveToPoint(context, 160, 180);
//    CGContextAddArc(context, 160, 180, 30,  -60 * M_PI / 180, -120 * M_PI / 180, 1);
//    CGContextClosePath(context);
//    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径
//    
//    //画椭圆
//    CGContextAddEllipseInRect(context, CGRectMake(160, 180, 20, 8)); //椭圆
//    CGContextDrawPath(context, kCGPathFillStroke);
//    
//    /*画三角形*/
//    //只要三个点就行跟画一条线方式一样，把三点连接起来
//    CGPoint sPoints[3];//坐标点
//    sPoints[0] =CGPointMake(100, 220);//坐标1
//    sPoints[1] =CGPointMake(130, 220);//坐标2
//    sPoints[2] =CGPointMake(130, 160);//坐标3
//    CGContextAddLines(context, sPoints, 3);//添加线
//    CGContextClosePath(context);//封起来
//    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
//    
//    /*画圆角矩形*/
//    float fw = 180;
//    float fh = 280;
//    
//    CGContextMoveToPoint(context, fw, fh-20);  // 开始坐标右边开始
//    CGContextAddArcToPoint(context, fw, fh, fw-20, fh, 10);  // 右下角角度
//    CGContextAddArcToPoint(context, 120, fh, 120, fh-20, 10); // 左下角角度
//    CGContextAddArcToPoint(context, 120, 250, fw-20, 250, 10); // 左上角
//    CGContextAddArcToPoint(context, fw, 250, fw, fh-20, 10); // 右上角
//    CGContextClosePath(context);
//    CGContextDrawPath(context, kCGPathFillStroke); //根据坐标绘制路径
//    
//    /*画贝塞尔曲线*/
//    //二次曲线
//    CGContextMoveToPoint(context, 120, 300);//设置Path的起点
//    CGContextAddQuadCurveToPoint(context,190, 310, 120, 390);//设置贝塞尔曲线的控制点坐标和终点坐标
//    CGContextStrokePath(context);
//    //三次曲线函数
//    CGContextMoveToPoint(context, 200, 300);//设置Path的起点
//    CGContextAddCurveToPoint(context,250, 280, 250, 400, 280, 300);//设置贝塞尔曲线的控制点坐标和控制点坐标终点坐标
//    CGContextStrokePath(context);
//    
//    
//    /*图片*/
//    UIImage *image = [UIImage imageNamed:@"apple.jpg"];
//    [image drawInRect:CGRectMake(60, 340, 20, 20)];//在坐标中画出图片
//    //    [image drawAtPoint:CGPointMake(100, 340)];//保持图片大小在point点开始画图片，可以把注释去掉看看
//    CGContextDrawImage(context, CGRectMake(100, 340, 20, 20), image.CGImage);//使用这个使图片上下颠倒了，参考http://blog.csdn.net/koupoo/article/details/8670024
//    
//    //    CGContextDrawTiledImage(context, CGRectMake(0, 0, 20, 20), image.CGImage);//平铺图
//    
//}
@end
