//
//  FTICustomUIButton.m
//  FTIApp
//
//  Created by Daisy Hernandez on 2/18/14.
//  Copyright (c) 2014 FTI Consulting. All rights reserved.
//

#import "FTICustomUIButton.h"

@implementation FTICustomUIButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGSize rectSize = rect.size;
    NSLog(@" rectagle size %f %f", rectSize.width,rectSize.height);
    
    // Color Declarations
    UIColor *borderColor = [UIColor colorWithRed:0.14f green:0.38f blue:0.48f alpha:1.00f];
    UIColor *topColor = [UIColor colorWithRed:0.99f green:0.99f blue:0.99f alpha:1.00f];
    UIColor *bottomColor = [UIColor colorWithRed:0.99f green:0.99f blue:0.99f alpha:1.00f];
    //UIColor *innerGlow = [UIColor colorWithWhite:1.0 alpha:0.5];
    
    // Gradient Declarations
    NSArray *gradientColors = (@[
                                 (id)topColor.CGColor,
                                 (id)bottomColor.CGColor
                                 ]);
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)(gradientColors), NULL);
    
    NSArray *highlightedGradientColors = (@[
                                            (id)bottomColor.CGColor,
                                            (id)topColor.CGColor
                                            ]);
    
    CGGradientRef highlightedGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)(highlightedGradientColors), NULL);

    
    UIBezierPath *roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, rectSize.width, rectSize.height) cornerRadius: 15];
    // Use the bezier as a clipping path
    [roundedRectanglePath addClip];
    
    // Use one of the two gradients depending on the state of the button
    CGGradientRef background = self.highlighted? highlightedGradient : gradient;
    
    // Draw gradient within the path
    CGContextDrawLinearGradient(context, background, CGPointMake(140, 0), CGPointMake(140, rectSize.height), 0);
    
    // Draw border
    [borderColor setStroke];
    roundedRectanglePath.lineWidth = 6;
    [roundedRectanglePath stroke];
    
    
    // Cleanup
    CGGradientRelease(gradient);
    CGGradientRelease(highlightedGradient);
    CGColorSpaceRelease(colorSpace);
}

@end
