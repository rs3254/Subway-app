//
//  ViewController.h
//  Subway app
//
//  Created by Ray Sabbineni on 3/21/16.
//  Copyright © 2016 Ray Sabbineni. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property(nonatomic, strong) NSMutableArray * mutableArrayWithObjects;
@property(nonatomic, strong)NSArray * arrayFromDictionary;

@end

