//
//  ViewController.m
//  Subway app
//
//  Created by Ray Sabbineni on 3/21/16.
//  Copyright © 2016 Ray Sabbineni. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import "Data.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.mutableArrayWithObjects = [[NSMutableArray alloc]init];
    NSString * filePath = [[NSBundle mainBundle]pathForResource:@"subway-info.json" ofType:@"txt"];
    
    if(filePath == NULL)
    {
        NSLog(@"JSON file not found");
        return;
    }
    
    NSData * data = [NSData dataWithContentsOfFile:filePath];
    NSError * error = nil;
    
    NSDictionary * jsonDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if(error != nil)
    {
        NSLog(@"Error parsing json %@", error.localizedDescription);
    }
    else
    {
        self.arrayFromDictionary = [jsonDic objectForKey:@"lines"];
        
        if(self.arrayFromDictionary == NULL)
        {
            NSLog(@"Invalid json or no lines key found");
        }
        
        
        for(id dictionaryObject in self.arrayFromDictionary)
        {
            Data * dataObject = [[Data alloc]init];
            dataObject.name = [dictionaryObject objectForKey:@"name"];
            dataObject.desc = [dictionaryObject objectForKey:@"desc"];
            dataObject.hexColor =[dictionaryObject objectForKey:@"hexcolor"];
            dataObject.letter = [dictionaryObject objectForKey:@"letter"];
            [self.mutableArrayWithObjects addObject:dataObject]; 
        }
    }
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.arrayFromDictionary.count; 
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    
    NSString * cellIdentifier = @"TableCell";
    
    CustomCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    Data * dataObj = [self.mutableArrayWithObjects objectAtIndex:indexPath.row];
    
    cell.heading.text = dataObj.name;
    cell.descriptionText.text = dataObj.desc;
    
    
    long c = cell.color.layer.sublayers.count;
    
    if(c==0){
        CAShapeLayer *circleLayer = [CAShapeLayer layer];
        circleLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, cell.subwayLetter.bounds.size.width,  cell.subwayLetter.bounds.size.width)].CGPath;
        
        circleLayer.strokeColor = [UIColor clearColor].CGColor;
        circleLayer.lineWidth = 1;
        [cell.color.layer addSublayer:circleLayer];
    }
    ((CAShapeLayer*)cell.color.layer.sublayers[0]).fillColor = [self uiColorFromHex:dataObj.hexColor].CGColor;
    
    
    cell.subwayLetter.text = dataObj.letter;
    cell.subwayLetter.textColor = [UIColor whiteColor];
    
    return cell;
    
    
}


- (UIColor *)uiColorFromHex:(NSString *)hex {
    NSScanner *scanHex = [NSScanner scannerWithString:hex];
    unsigned rgb = 0;
    [scanHex scanHexInt:&rgb];
    return [UIColor colorWithRed:((rgb & 0xFF0000) >> 16)/255.0 green:((rgb & 0xFF00) >> 8)/255.0 blue:(rgb & 0xFF)/255.0 alpha:1.0];
}

@end
