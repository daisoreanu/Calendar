//
//  SLCustomToolBar.m
//  Granular
//
//  Created by Laurentiu Daisoreanu on 27/09/2016.
//  Copyright © 2016 Solum. All rights reserved.
//

#import "SLCustomToolBar.h"
#import "UIApplication+AppDimensions.h"

@implementation SLCustomToolBar

- (instancetype)initWithLeftButtonTitle:(NSString *)leftButtonTitle
                    andLeftButtonAction:(SEL)leftButtonSelector
                   andMiddleButtonTitle:(NSString *)middleButtonTitle
                  andMiddleButtonAction:(SEL)middleButtonAction
                    andRightButtonTitle:(NSString *)rightButtonTitle
                   andRightButtonAction:(SEL)rightButtonSelector
                            andDelegate:(id)passedDelegate
{
    
    self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    
    if (self) {
        self.frame = CGRectMake(0, 0, [UIApplication currentSize].width, kConstantHeight);
        [self layoutIfNeeded];
        
        [self setBackgroundImage:[UIImage new]
                      forToolbarPosition:UIBarPositionAny
                              barMetrics:UIBarMetricsDefault];
//        [self setShadowImage:[UIImage new]
//                  forToolbarPosition:UIBarPositionAny];
        
        if (!leftButtonTitle) {
            leftButtonTitle = @"Cancel";
        }
        
        if (!rightButtonTitle) {
            rightButtonTitle = @"Done";
        }
        
        self.passedDelegate = passedDelegate;
        
        [self.leftButton setTarget:passedDelegate];
        [self.leftButton setAction:leftButtonSelector];
        
        [self.middleButton setTarget:passedDelegate];
        [self.middleButton setAction:middleButtonAction];
        
        [self.rightButton setTarget:passedDelegate];
        [self.rightButton setAction:rightButtonSelector];
        
        [self.leftButton setTitle:leftButtonTitle];
        [self.middleButton setTitle:middleButtonTitle];
        [self.rightButton setTitle:rightButtonTitle];
    }
    
    
    return self;
    
}

- (instancetype)initWithLeftButtonTitle:(NSString *)leftButtonTitle
                    andLeftButtonAction:(SEL)leftButtonSelector
                    andRightButtonTitle:(NSString *)rightButtonTitle
                   andRightButtonAction:(SEL)rightButtonSelector
                            andDelegate:(id)passedDelegate
{


    return [self initWithLeftButtonTitle:leftButtonTitle
                      andLeftButtonAction:leftButtonSelector
                     andMiddleButtonTitle:nil
                    andMiddleButtonAction:nil
                      andRightButtonTitle:rightButtonTitle
                     andRightButtonAction:rightButtonSelector
                              andDelegate:passedDelegate];


}

@end
