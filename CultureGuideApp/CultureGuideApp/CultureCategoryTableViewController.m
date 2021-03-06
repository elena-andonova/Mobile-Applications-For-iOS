//
//  PlaceViewController.m
//  CultureGuideApp
//
//  Created by Elena Andonova on 2/3/16.
//  Copyright © 2016 EA. All rights reserved.
//

#import "CultureCategoryTableViewController.h"
#import "PlacesTableViewController.h"
#import "PlacesLocationViewController.h"
#import "AppDelegate.h"
#import "CultureCategory.h"
#import "Place.h"
#import "CategoryCell.h"
#import "LocalDatabase.h"

#import "CultureCategorySwift-Swift.h"


@interface CultureCategoryTableViewController()

@property (strong, nonatomic) UITabBarController *eventsTabBarController;

@property (strong, nonatomic) PlacesTableViewController *placesTableView;

@property (strong, nonatomic) PlacesLocationViewController *placesLocationView;

@end

@implementation CultureCategoryTableViewController

-(void)viewDidLoad{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.title = @"Culture Guide";
    [self loadCategories];
}

-(void)loadCategories{
    EVDataStore *dataStore = [EVDataStore sharedInstance];
    //[dataStore fetchAll:[CultureCategoryObjC class] block:^(NSArray *result, NSError *error) {
    NSLog(@"obj c: %@", [CultureCategory class]);
    NSLog(@"swift: %@", [[CultureCategorySwift self] description]);
    //id class = CultureCategory.bridge;
    //NSLog(@"swift 2: %@", class);
    
    __weak id weakSelf = self;
    
    [CultureCategory fetchAll:^(NSArray *result, NSError *error) {
        if (error != nil) {
            NSLog(@"Unfortunately an error occurred: %@", error.domain);
        } else {
            
            NSMutableArray *categories = [NSMutableArray array];
            for (int index = 0; index < [result count]; index++)
            {
                //CultureCategoryObjC *categ= [result objectAtIndex:index];
                CultureCategorySwift *categ= [result objectAtIndex:index];
                [categories addObject:categ];
                NSLog(@"Category is: %@, id: %@", categ.name, categ.id);
            }
            self.cultureCategories = categories;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[weakSelf tableView] reloadData];
                
            });
            
            NSLog(@"%lu", categories.count);
        }
    }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"categoryCell";
    
//    UITableViewCell *originalCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    
//    if (![originalCell isKindOfClass:[CategoryCell class]] || originalCell == nil) {
//        //Loading custom cell
//        originalCell = [[[NSBundle mainBundle] loadNibNamed:@"CategoryCell" owner:self options:nil] objectAtIndex:0];
//    }
//  CategoryCell *cell = (CategoryCell*)originalCell;
    
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
    
    //CultureCategoryObjC *categ = [self.cultureCategories objectAtIndex:indexPath.row];
    CultureCategorySwift *categ = [self.cultureCategories objectAtIndex:indexPath.row];
    
    UIImage *img = [UIImage imageNamed: categ.image];

    cell.categoryImageView.image = img;
    cell.categoryNameLabel.text = categ.name;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cultureCategories.count;
}


//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    CultureCategory *categ = [self.cultureCategories objectAtIndex:indexPath.row];
//    NSString *storyBoardID = @"placesScene";
//    
//    PlacesTableViewController *placesVC = [self.storyboard instantiateViewControllerWithIdentifier:storyBoardID];
//    
//    placesVC.cultureCategoryId = categ.id;
//    placesVC.cultureCategoryName = categ.name;
//    
//    [self.navigationController pushViewController:placesVC animated:YES];
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%lu", selectedIndexPath.row);
    
    //CultureCategoryObjC *categ = [self.cultureCategories objectAtIndex:selectedIndexPath.row];
    CultureCategorySwift *categ = [self.cultureCategories objectAtIndex:selectedIndexPath.row];
 
    self.eventsTabBarController = (UITabBarController*) [segue destinationViewController];
    self.placesTableView = [self.eventsTabBarController.viewControllers objectAtIndex:0];
    self.placesTableView.cultureCategoryId = categ.id;
    self.placesTableView.cultureCategoryName = categ.name;
    
    self.placesLocationView = [self.eventsTabBarController.viewControllers objectAtIndex:1];
    self.placesLocationView.categoryId = categ.id;
}


@end
