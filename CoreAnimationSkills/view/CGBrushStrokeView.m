//
//  CGBrushStrokeView.m
//  CoreAnimationSkills
//
//  Created by MichaelMao on 16/4/9.
//  Copyright © 2016年 MichaelMao. All rights reserved.
//

#import "CGBrushStrokeView.h"

#define BRUSH_SIZE 32
@interface CGBrushStrokeView ()

@property (nonatomic, strong) NSMutableArray *strokes;

@end

@implementation CGBrushStrokeView

#pragma mark - touch event

- (void)awakeFromNib
{    //create array
    self.strokes = [NSMutableArray array];
}

- (void)addBrushStrokeAtPoint:(CGPoint)point
{
    //add brush stroke to array
    [self.strokes addObject:[NSValue valueWithCGPoint:point]];
    
    //needs redraw
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    //redraw strokes
    for (NSValue *value in self.strokes) {
        //get point
        CGPoint point = [value CGPointValue];
        
        //get brush rect
        CGRect brushRect = CGRectMake(point.x - BRUSH_SIZE/2, point.y - BRUSH_SIZE/2, BRUSH_SIZE, BRUSH_SIZE);
        
        //draw brush stroke    ￼
        [[UIImage imageNamed:@"house"] drawInRect:brushRect];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //get the touch point
    CGPoint point = [[touches anyObject] locationInView:self];
    
    //add brush stroke
    [self addBrushStrokeAtPoint:point];
}

@end
