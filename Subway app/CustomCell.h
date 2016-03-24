//
//  CustomCell.h
//  Subway app
//
//  Created by Ray Sabbineni on 3/21/16.
//  Copyright © 2016 Ray Sabbineni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *heading;

@property (strong, nonatomic) IBOutlet UILabel *subwayLetter;

@property (strong, nonatomic) IBOutlet UITextView *descriptionText;


@property (strong, nonatomic) IBOutlet UIView *color;


@end
