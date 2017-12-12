//
//  SLCustomToolBar.h
//  Granular
//
//  Created by Laurentiu Daisoreanu on 27/09/2016.
//  Copyright © 2016 Solum. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kConstantHeight 44.0

@interface SLCustomToolBar : UIToolbar

@property (weak, nonatomic) id passedDelegate;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *middleButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightButton;

- (instancetype)initWithLeftButtonTitle:(NSString *)leftButtonTitle
                     andLeftButtonAction:(SEL)leftButtonSelector
                    andMiddleButtonTitle:(NSString *)middleButtonTitle
                   andMiddleButtonAction:(SEL)middleButtonAction
                     andRightButtonTitle:(NSString *)rightButtonTitle
                    andRightButtonAction:(SEL)rightButtonSelector
                             andDelegate:(id)passedDelegate;

- (instancetype)initWithLeftButtonTitle:(NSString *)leftButtonTitle
                    andLeftButtonAction:(SEL)leftButtonSelector
                    andRightButtonTitle:(NSString *)rightButtonTitle
                   andRightButtonAction:(SEL)rightButtonSelector
                            andDelegate:(id)passedDelegate;

@end
