//
//  DrawTestView.m
//  LiftDemo
//
//  Created by apple on 2019/3/28.
//  Copyright © 2019 lostifor. All rights reserved.
//

#import "DrawTestView.h"

@implementation DrawTestView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 必须清空背景色，不然绘制出来的区域之外有黑色背景
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:NO];
    }
    return self;
}

//重写drawRect，drawRect方法不能手动直接调用，我们可以通过调用其他方法来实现drawRect方法的调用。如：在子类初始化时调用- (instancetype)initWithFrame:(CGRect)frame方法，且frame不为CGRectZero时。
- (void)drawRect:(CGRect)rect {
    float x = rect.origin.x;
    float y = rect.origin.y;
    float w = rect.size.width;
    float h = rect.size.height - 30;
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 画笔线的颜色
    CGContextSetRGBStrokeColor(context,1,0,0,0);
    // 线的宽度
    CGContextSetLineWidth(context, 1.0);
    // 填充颜色
    UIColor *fullColor = HexColorInt32_t(ff2c20);
    CGContextSetFillColorWithColor(context, fullColor.CGColor);
    // 绘制路径  点到点，点到点（带弧线，半径参数）
    CGContextMoveToPoint(context,x,y);
    CGContextAddLineToPoint(context,x,h);
    CGContextAddArcToPoint(context,w/2.0,h + 30,w,h,w*2.4);
    CGContextAddLineToPoint(context,w,h);
    CGContextAddLineToPoint(context,w,y);
    //    CGContextAddArcToPoint(context,w/2.0,30,x,y,w*2);
    CGContextAddLineToPoint(context,x,y);
    // CGContextStrokePath(context);
    // 绘制路径加填充
    CGContextDrawPath(context, kCGPathFillStroke);
}

@end


@implementation DashLineView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 必须清空背景色，不然绘制出来的区域之外有黑色背景
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:NO];
    }
    return self;
}

//重写drawRect，drawRect方法不能手动直接调用，我们可以通过调用其他方法来实现drawRect方法的调用。如：在子类初始化时调用- (instancetype)initWithFrame:(CGRect)frame方法，且frame不为CGRectZero时。
- (void)drawRect:(CGRect)rect {
    // 上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 线的宽度
    CGContextSetLineWidth(context, 3.0);
    // 线的颜色
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    // dash
    CGFloat dashArr[] = {3,1};
//    通过CGContextSetLineDash来设置虚线点的大小以及虚线点间隔大小。其中{3, 1}表示先画3个实点再画1个虚点，即实点多虚点少表示虚线点大且间隔小，实点少虚点多表示虚线点小且间隔大。最后的参数1代表排列的个数。
    CGContextSetLineDash(context, 1, dashArr, 1);
//    然后设置虚线的起点和终点坐标，并且有两种方法。第一种是通过CGContextMoveToPoint设置线条的起点坐标(CGFloat x1, CGFloat y1)，通过CGContextAddLineToPoint设置线条的终点坐标(CGFloat x2, CGFloat y2)。第二种设置坐标点数组，通过CGContextAddLines添加坐标点数组。
    CGContextMoveToPoint(context, 20, 50);
    CGContextAddLineToPoint(context, rect.size.width - 20, 50);
    CGContextStrokePath(context);
    
}


@end


@implementation DrawImageView

//绘制图片的基本思路：
//
//通过UIGraphicsGetCurrentContext来获取需要处理的上下文线条。
//CGContextRef context = UIGraphicsGetCurrentContext();
//通过CGContextSaveGState来保存初始状态。
//CGContextSaveGState(context);
//利用CGContextTranslateCTM来移动图形上下文。
//CGContextTranslateCTM(context, 50.0, 80.0);
//利用CGContextScaleCTM来缩放图形上下文。
//CGContextScaleCTM(context, 0.9, 0.9);
//利用CGContextRotateCTM来进行旋转操作。
//CGContextRotateCTM(context, M_PI_4 / 4);
//设置绘制图片的尺寸大小。
//UIImage *image = [UIImage imageNamed:@"512”];
//                  CGRect rectImage = CGRectMake(0.0, 0.0, rect.size.width, (rect.size.width*image.size.height/image.size.width));

//设置绘制图片展示的三种状态：
//在rect范围内完整显示图片:
//[image drawInRect:rectImage];
//图片上下颠倒：
//CGContextDrawImage(context, rectImage, image.CGImage);
//图片上下颠倒并拼接填充：
//CGContextDrawTiledImage(context, rectImage, image.CGImage);
//最后恢复到初始状态。
//CGContextRestoreGState(context);

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:NO];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    //保存初始状态（压栈操作，保存一份当前图形上下文）
    CGContextSaveGState(context);
    //移动
    CGContextTranslateCTM(context, 0.0, 0.0);
    //缩放
    CGContextScaleCTM(context, 0.7, 0.7);
    //旋转
    CGContextRotateCTM(context, M_PI_4);
    //需要绘制的图片
    UIImage *image = [UIImage imageNamed:@"面无表情"];
    CGRect rectImage = CGRectMake(0.0, 0.0, rect.size.width, (rect.size.width*image.size.height/image.size.width));
    //三种方式绘制图片
    // 1、在rect范围内完整显示图片-正常使用
//    [image drawInRect:rectImage];
    // 2、图片上下颠倒
//    CGContextDrawImage(context, rectImage, image.CGImage);
    // 3、图片上下颠倒并拼接填充
    CGContextDrawTiledImage(context, rectImage, image.CGImage);
    //恢复到初始状态（出栈操作，恢复一份当前图形上下文）
    CGContextRestoreGState(context);
}

@end

@implementation EllipseView

#define Height    100.0
#define padding  10.0
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:NO];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    //背景颜色设置
    [[UIColor whiteColor] set];
    CGContextFillRect(context, rect);
    
    //实线椭圆
    CGRect rectRing = CGRectMake(padding, padding, (rect.size.width - padding * 2), Height);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextAddEllipseInRect(context, rectRing);
    CGContextDrawPath(context, kCGPathStroke);
    
    //虚线椭圆
    rectRing = CGRectMake(padding, Height+padding*2, (rect.size.width - padding * 2), Height);
    CGFloat dashArray[] = {2, 6};
    CGContextSetLineDash(context, 1, dashArray, 2);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    //填充颜色
    CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
    CGContextAddEllipseInRect(context, rectRing);
    CGContextDrawPath(context, kCGPathStroke);
    CGContextFillPath(context);
    
    //填充椭圆
    rectRing = CGRectMake(padding, Height*2+padding*3, (rect.size.width - padding * 2), Height);
    CGContextSetLineWidth(context, 1.0);
    //填充颜色
    CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
    CGContextAddEllipseInRect(context, rectRing);
    CGContextFillPath(context);
}

@end

@implementation FanView

//扇形是圆形的一部分，所以在绘制的时候可以利用CGContextAddArc方法来设置扇形的圆弧显示范围，并添加原点为起始点开始绘制。
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:NO];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGFloat R = (CGRectGetWidth(self.frame)-padding*2)/2;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //背景颜色设置
    [[UIColor whiteColor] set];
    CGContextFillRect(context, rect);
    
    //实线扇形-顺时针-有边框，有填充
    //边框宽度
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextMoveToPoint(context, R, R);
    //填充颜色
    CGContextSetFillColorWithColor(context, [UIColor purpleColor].CGColor);
    CGContextAddArc(context, R, R, R/2, (-60 * M_PI / 180), (-120 * M_PI / 180), 1);//如果圆弧是顺时针画的，“clockwise”是1，否则是0;
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    //实线扇形-逆时针-有边框，有填充
    //边框宽度
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextMoveToPoint(context, R, R*2);
    //填充颜色
    CGContextSetFillColorWithColor(context, [UIColor purpleColor].CGColor);
    CGContextAddArc(context, R, R*2, R/2, (-60 * M_PI / 180), (-120 * M_PI / 180), 0);//如果圆弧是顺时针画的，“clockwise”是1，否则是0;
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
}

@end

@implementation CircleView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:NO];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextFillRect(context, rect);
    CGContextSetLineWidth(context, 2.0);
    [[UIColor whiteColor] set];
    CGContextFillRect(context, rect);
    //画虚线
    CGFloat dashArray[] = {3, 1};
    CGContextSetLineDash(context, 1, dashArray, 1);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
    //上下文_圆,其中参数(x, y)是圆弧的中心；radius是它的半径；startAngle是与圆弧第一个端点的夹角；endAngle是到弧的第二个端点的角度；startAngle和endAngle用弧度表示；如果圆弧是顺时针画的，clockwise是1，否则是0；
    CGContextAddArc(context,rect.size.width/2, rect.size.height/2, 150/2, 0, 2 * M_PI, 0);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
}


@end

@implementation ArcView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:NO];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    //背景颜色设置
    [[UIColor whiteColor] set];
    CGContextFillRect(context, rect);
    
    //弧线
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor orangeColor].CGColor);
    //起点
    CGContextMoveToPoint(context, 50, 50);
    //设置贝塞尔曲线的控制点坐标{cp1x,cp1y} 终点坐标{x,y}
    CGContextAddQuadCurveToPoint(context, (rect.size.width/2), 50*4, (rect.size.width - 50), 50*2);
    //绘制前设置边框和填充颜色
    [[UIColor greenColor] setStroke];
    [[UIColor lightGrayColor] setFill];
    CGContextDrawPath(context, kCGPathFillStroke);
    
    //曲线
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    //起点坐标
    CGContextMoveToPoint(context, 50, 50*8);
    //设置贝塞尔曲线的控制点坐标{cp1x,cp1y} 控制点坐标{cp2x,cp2y} 终点坐标{x,y}
    CGContextAddCurveToPoint(context, 100.0, 100.0, 200.0, 500.0, (rect.size.width - 10.0), 50*6);
    //绘制前设置边框和填充颜色
    [[UIColor greenColor] setStroke];
    [[UIColor lightGrayColor] setFill];
    CGContextDrawPath(context, kCGPathFillStroke);
}


@end
