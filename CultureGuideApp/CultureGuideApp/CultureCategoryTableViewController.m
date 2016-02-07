//
//  PlaceViewController.m
//  CultureGuideApp
//
//  Created by Elena Andonova on 2/3/16.
//  Copyright © 2016 EA. All rights reserved.
//

#import "CultureCategoryTableViewController.h"
#import "PlacesTableViewController.h"
#import "AppDelegate.h"
#import "CultureCategory.h"
#import "Place.h"
#import "CategoryCell.h"

@implementation CultureCategoryTableViewController

-(void)viewDidLoad{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self loadCategories];
}

-(void)loadCategories{
    EVDataStore *dataStore = [EVDataStore sharedInstance];
    [dataStore fetchAll:[CultureCategory class] block:^(NSArray *result, NSError *error) {
        if (error != nil) {
            NSLog(@"Unfortunately an error occurred: %@", error.domain);
        } else {
            
            NSMutableArray *categories = [NSMutableArray array];
            for (int index = 0; index < [result count]; index++)
            {
                CultureCategory *categ= [result objectAtIndex:index];
                [categories addObject:categ];
                NSLog(@"Category is: %@, id: %@", categ.name, categ.id);
            }
            self.cultureCategories = categories;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableView reloadData];
                
            });
            
            NSLog(@"%lu", categories.count);
        }
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"categoryCell";
    
    UITableViewCell *originalCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (![originalCell isKindOfClass:[CategoryCell class]] || originalCell == nil) {
        //Loading custom cell
        originalCell = [[[NSBundle mainBundle] loadNibNamed:@"CategoryCell" owner:self options:nil] objectAtIndex:0];
    }
    
    CategoryCell *cell = (CategoryCell*)originalCell;
    CultureCategory *categ = [self.cultureCategories objectAtIndex:indexPath.row];
    
    UIImage *img = [UIImage imageNamed: categ.image];

    cell.categoryImage.image = img;
    cell.categoryLabel.text = categ.name;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cultureCategories.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CultureCategory *categ = [self.cultureCategories objectAtIndex:indexPath.row];
    NSString *storyBoardID = @"placesScene";
    
    PlacesTableViewController *placesVC = [self.storyboard instantiateViewControllerWithIdentifier:storyBoardID];
    
    placesVC.cultureCategoryId = categ.id;
    placesVC.cultureCategoryName = categ.name;
    
    [self.navigationController pushViewController:placesVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}


@end
