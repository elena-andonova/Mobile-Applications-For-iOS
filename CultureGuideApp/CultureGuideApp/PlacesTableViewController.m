//
//  PlacesTableViewController.m
//  CultureGuideApp
//
//  Created by Elena Andonova on 2/6/16.
//  Copyright © 2016 EA. All rights reserved.
//

#import "PlacesTableViewController.h"
#import "Place.h"
#import "EventsTableViewController.h"
#import "LocalDatabase.h"

@interface PlacesTableViewController ()

@end

@implementation PlacesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.title = [NSString stringWithFormat:@"%@", self.cultureCategoryName];
    
    [self.parentViewController.navigationItem setTitle:self.cultureCategoryName];
    //[self loadPlaces];
    
    UIEdgeInsets adjustForTabbarInsets = UIEdgeInsetsMake(CGRectGetHeight(self.navigationController.navigationBar.frame) + 20, 0, 0, 0);
    self.tableView.contentInset = adjustForTabbarInsets;
    self.tableView.scrollIndicatorInsets = adjustForTabbarInsets;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([self.cultureCategoryName  isEqual: @"Favorites"]) {
        LocalDatabase *db = [LocalDatabase database];
        
        NSArray *favPlacesArray = [NSArray arrayWithArray:[db favoritePlaces]];
        NSLog(@"%lu", favPlacesArray.count);
        if(favPlacesArray.count == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Favorites"
                                                            message:@"You haven't added any favorites yet ;("
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        
        self.places = favPlacesArray;
    }
    else
    {
       [self loadPlaces];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.tableView reloadData];
        
    });
};

-(void)loadPlaces{
    EVDataStore *dataStore = [EVDataStore sharedInstance];
    EVFetchRequest *request = [EVFetchRequest fetchRequestWithKindOfClass:[Place class]];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"CultureCategoryId == %@",self.cultureCategoryId]];
    
    [dataStore executeFetchRequest:request block:^(NSArray *result, NSError *error) {
        //here result will contain the fetched Activities
        NSMutableArray *places = [NSMutableArray array];
        for (int index = 0; index < [result count]; index++)
        {
            Place *place = [result objectAtIndex:index];
            [places addObject:place];
            NSLog(@"Place is: %@, id: %@", place.name, place.id);
        }
        self.places = places;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            
        });
        
        NSLog(@"%lu", places.count);
    }];
}

//-(void) tryingToFilterGeoLocations{
//    NSString *urlString = @"http://api.everlive.com/v1/x3wwm8ba0hobfymk/Place";
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//
//    [request setHTTPMethod:@"GET"];
//
//    NSDictionary *location = @{
//                               @"longitude": @"23.34744000000001",
//                               @"latitude": @"42.696629"
//                               };
//
//    NSDictionary *nearSphere = @{
//                                 @"$nearSphere": location
//                                 };
//
//    //@"Location":nearSphere
//    NSDictionary *filter= @{
//                            @"Text":@"Test"
//                            };
//    NSError *error;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:filter options:NSJSONReadingAllowFragments error:&error];
//
//
//    NSString *jsonStringFilter;
//    if (!jsonData) {
//        NSLog(@"Got an error: %@", error);
//    } else {
//        jsonStringFilter = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//        NSLog(@"jsonized string: %@", jsonStringFilter);
//    }
//
//    NSDictionary *headers = @{@"Authorization": @"Bearer your-access-token-here zeue5vt2qgcw3n48ifa1ob8gzrec899n",
//                              @"X-Everlive-Filter":jsonStringFilter};
//
//    for(id key in headers){
//        [request addValue:[headers objectForKey:key]
//       forHTTPHeaderField:key];
//    }
//
//
//    [[[NSURLSession sharedSession] dataTaskWithRequest:request
//                                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//
//                                         if (error) {
//                                             NSLog(@"Error:%@", error);
//                                             return;
//                                         }
//                                         NSError *err;
//                                         NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
//
//                                         NSLog(@"Data: %@",dict);
//
//                                     }]
//     resume];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.places.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"placesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Place *place = [self.places objectAtIndex:indexPath.row];
    
    cell.textLabel.text = place.name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Place *place = [self.places objectAtIndex:indexPath.row];
    NSString *storyBoardID = @"eventsScene";
    
    EventsTableViewController *eventsVC = [self.storyboard instantiateViewControllerWithIdentifier:storyBoardID];
    
    eventsVC.placeId = place.id;
    eventsVC.placeName = place.name;
    
    [self.navigationController pushViewController:eventsVC animated:YES];
}


- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *favAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"+Fav" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        // maybe show an action sheet with more options
        
        
        LocalDatabase *db = [LocalDatabase database];
        
        Place *favplace = [self.places objectAtIndex:indexPath.row];
        [db addFavoritePlace:favplace];        
        
        [self.tableView setEditing:NO];
    }];
    
    favAction.backgroundColor = [UIColor purpleColor];
    //[UIColor colorWithPatternImage:[UIImage imageNamed:@"star-32"]];

    
    return @[favAction];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellFocusStyleCustom) {
        //[_objects removeObjectAtIndex:indexPath.row];
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        NSLog(@"Unhandled editing style! %d", editingStyle);
    }
}

//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
//{
//    self.placeViewController = (PlacesLocationViewController *) [tabBarController.viewControllers objectAtIndex:1];
//    //In our example here, we only have 2 view controllers (A and B)
//    //So, index 1 is where controller B resides.
//
//    self.placeViewController.testString = @"Hello!";
//    //This will change the text of the label in controller B
//}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



@end
