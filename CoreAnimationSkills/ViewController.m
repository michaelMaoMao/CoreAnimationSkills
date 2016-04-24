//
//  ViewController.m
//  CoreAnimationSkills
//
//  Created by MichaelMao on 16/4/8.
//  Copyright © 2016年 MichaelMao. All rights reserved.
//


#import "ViewController.h"
#import "ReflectionView.h"

//这是利用core animation来实现图像拼接的一个小demo
//主要是计算一个小图拼合后的坐标
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *topLeftView;
@property (weak, nonatomic) IBOutlet UIView *topRightView;
@property (weak, nonatomic) IBOutlet UIView *bottomLeftView;
@property (weak, nonatomic) IBOutlet UIView *bottomRightView;
@property (weak, nonatomic) IBOutlet UIImageView *reflectionVIew;
@property (strong, nonatomic)  CALayer *blueLayer;

@end

CGAffineTransform CGAffineTransformMakeShear(CGFloat x, CGFloat y) {
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform.c = -x;
    transform.b = y;
    return transform;
}
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self layoutSmallImages];
}


- (void)layoutSmallImages{
    
    UIImage *image = [UIImage imageNamed:@"house"];
    //set igloo sprite
    [self addSpriteImage:image withContentRect:CGRectMake(0, 0, 0.5, 0.5) toLayer:self.topLeftView.layer];
    //set cone sprite
    [self addSpriteImage:image withContentRect:CGRectMake(0.5, 0, 0.5, 0.5) toLayer:self.topRightView.layer];
    //set anchor sprite
    [self addSpriteImage:image withContentRect:CGRectMake(0, 0.5, 0.5, 0.5) toLayer:self.bottomLeftView.layer];
    //set spaceship sprite
    [self addSpriteImage:image withContentRect:CGRectMake(0.5, 0.5, 0.5, 0.5) toLayer:self.bottomRightView.layer];
}

- (void)addSpriteImage:(UIImage *)image withContentRect:(CGRect)rect toLayer:(CALayer *)layer{
    
    layer.contents = (__bridge id)image.CGImage;
    
    //scale contents to fit
    layer.contentsGravity = kCAGravityResizeAspect;
    
    //set contentsRect
    layer.contentsRect = rect;
}


- (void)drawAnStickFigure{
    //create path
    //    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    //define path parameters
    CGRect rect = CGRectMake(50, 50, 100, 100);
    CGSize radii = CGSizeMake(50, 50);
    UIRectCorner corners = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
    //create path
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    
    [path moveToPoint:CGPointMake(175, 100)];
    
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(150, 125)];
    [path addLineToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    //add it to our view
    [self.view.layer addSublayer:shapeLayer];
}


- (void)showlayerHitTestFunction{
    
    _blueLayer = [CALayer layer];
    _blueLayer.frame = CGRectMake(0.0f, 0.0f, 50, 50);
    _blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.topLeftView.layer addSublayer:_blueLayer];
}

- (void)addTransform{
    //frame是相对于父视图坐标系的矩形区域位置大小，bounds是相对于自身坐标系的位置大小，在辩护
    self.topLeftView.transform = CGAffineTransformRotate(self.topLeftView.transform, -M_1_PI);
    NSLog(@"self.topLeftView.frame = %@", NSStringFromCGRect(self.topLeftView.frame));
    NSLog(@"self.topLeftView.bounds = %@", NSStringFromCGRect(self.topLeftView.bounds));
}


- (void)swichLayerWithZPosizion{
    
    //create sublayer
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(0.0f, 0.0f, 50, 50);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.topLeftView.layer addSublayer:blueLayer];
    
    CALayer *redLayer = [CALayer layer];
    redLayer.frame = CGRectMake(25.0f, 25.0f, 50, 50);
    redLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.topLeftView.layer addSublayer:redLayer];
    
    CALayer *greenLayer = [CALayer layer];
    greenLayer.frame = CGRectMake(50, 50, 50, 50);
    greenLayer.backgroundColor = [UIColor greenColor].CGColor;
    [self.topLeftView.layer addSublayer:greenLayer];
    
    //    blueLayer.zPosition = 1;
    //    redLayer.zPosition = 0.5;
    //
    redLayer.zPosition = -0.5;
    greenLayer.zPosition = -1;
    
    
    NSLog(@"blueLayer.zPosition = %f", blueLayer.zPosition);
    NSLog(@"redLayer.zPosition = %f", redLayer.zPosition);
    NSLog(@"greenLayer.zPosition = %f", greenLayer.zPosition);
}

- (void)drawCustomLayer{
    
    //create sublayer
    CALayer *blueLayer = [CALayer layer];
    //    blueLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    blueLayer.frame = CGRectMake(0.0f, 0.0f, 100.0f, 100.0f);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    //set controller as layer delegate
    blueLayer.delegate = self;
    //    blueLayer.anchorPoint = CGPointMake(0, 0);
    
    //ensure that layer backing image uses correct scale
    blueLayer.contentsScale = [UIScreen mainScreen].scale; //add layer to our view
    [self.topLeftView.layer addSublayer:blueLayer];
    NSLog(@"blueLayer.position = %@", NSStringFromCGPoint(blueLayer.position));
    NSLog(@"blueLayer.anchorPoint = %@", NSStringFromCGPoint(blueLayer.anchorPoint));
    NSLog(@"blueLayer.anchorPointZ = %f", blueLayer.anchorPointZ);
    //force layer to redraw
    [blueLayer display];
}




#pragma mark - CALayerDelegate

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    //draw a thick red circle
    CGContextSetLineWidth(ctx, 10.0f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGRect drawRect = CGRectMake(10.0f/2, 10.0f/2, layer.bounds.size.width - 10.0f, layer.bounds.size.height - 10.0f);
    CGContextStrokeEllipseInRect(ctx, drawRect);
}

#pragma mark - touchesEvent


//-hitTest:方法同样接受一个CGPoint类型参数，而不是BOOL类型，它返回图层本身，或者包含这个坐标点的叶子节点图层。
//这意味着不再需要像使用-containsPoint:那样，人工地在每个子图层变换或者测试点击的坐标。如果这个点在最外面图层的
//范围之外，则返回nil。

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //get touch position
    CGPoint point = [[touches anyObject] locationInView:self.view];
    //get touched layer
    CALayer *layer = [self.topLeftView.layer hitTest:point];
    //get layer using hitTest
    if (layer == self.blueLayer) {
        [[[UIAlertView alloc] initWithTitle:@"Inside Blue Layer"
                                    message:nil
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    } else if (layer == self.topLeftView.layer) {
        [[[UIAlertView alloc] initWithTitle:@"Inside White Layer"
                                    message:nil
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
