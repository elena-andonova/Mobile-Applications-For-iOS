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
    self.cultureCategories = [NSArray arrayWithObjects:
                              [CultureCategory cultureCategoryWithName:@"Theatre" andImage:@"theatre-128"],
                              [CultureCategory cultureCategoryWithName:@"Concerts" andImage:@"concert-128"],nil];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
//AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//    
//    self.places = [delegate.data places];
//    [self.tableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"categoryCell";
    
    UITableViewCell *originalCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (![originalCell isKindOfClass:[CategoryCell class]] || originalCell == nil) {
        //Loading custom cell
        originalCell = [[[NSBundle mainBundle] loadNibNamed:@"CategoryCell" owner:self options:nil] objectAtIndex:0];
    }
    
//    if (originalCell == nil) {
//        originalCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    }
    
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
    
    placesVC.places = categ.places;
    
    [self.navigationController pushViewController:placesVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}


@end
