//
//  TitleAndImageProtocol.h
//  Calendar
//
//  Created by Laurentiu Daisoreanu on 06/12/2017.
//  Copyright © 2017 DaisoreanuLaurentiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SLTitleAndImageProtocol <NSObject>

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *imageName;
@property (assign, nonatomic) BOOL isSelected;
@property (assign, nonatomic) BOOL isTopSeparatorVisible;
@property (assign, nonatomic) BOOL isBottomSeparatorVisible;

@end

