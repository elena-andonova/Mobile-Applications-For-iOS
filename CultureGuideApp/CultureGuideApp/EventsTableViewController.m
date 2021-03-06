//
//  EventsTableViewController.m
//  CultureGuideApp
//
//  Created by Elena Andonova on 2/6/16.
//  Copyright © 2016 EA. All rights reserved.
//

#import "EventsTableViewController.h"
#import "Event.h"
#import "EventDetailsViewController.h"
#import "EventTicketViewController.h"
#import "EventCell.h"

@interface EventsTableViewController ()

@property (strong, nonatomic) UITabBarController *myTabbarController;

@property (strong, nonatomic) EventDetailsViewController *eventDetailsView;

@property (strong, nonatomic) EventTicketViewController *eventTicketView;

@end

@implementation EventsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@", self.placeName];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self loadEvents];
}

-(void)loadEvents{
    EVDataStore *dataStore = [EVDataStore sharedInstance];
    EVFetchRequest *request = [EVFetchRequest fetchRequestWithKindOfClass:[Event class]];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"PlaceId == %@",self.placeId]];
    
    __weak id weakSelf = self;
    [dataStore executeFetchRequest:request block:^(NSArray *result, NSError *error) {
        //here result will contain the fetched Activities
        NSMutableArray *events = [NSMutableArray array];
        for (int index = 0; index < [result count]; index++)
        {
            Event *event = [result objectAtIndex:index];
            [events addObject:event];
            NSLog(@"Event is: %@, id: %@", event.name, event.id);
        }
        self.events = events;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[weakSelf tableView] reloadData];
            
        });
        
        NSLog(@"%lu", events.count);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.events.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = @"eventsCell";
    
    EventCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[EventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Event *event = [self.events objectAtIndex:indexPath.row];
    
    //cell.textLabel.text = event.name;
    cell.eventCellName.text = event.name;
    cell.eventCellDate.text = [event formatedDate];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    NSLog(@"%lu", indexPath.row);
//
//    Event *event = [self.events objectAtIndex:indexPath.row];
//
//    //NSString *storyBoardID = @"eventDetailsScene";
//    NSString *storyBoardID = @"eventBarScene";
//
//    EventDetailsViewController *eventDetailsVC = [self.storyboard instantiateViewControllerWithIdentifier:storyBoardID];
//
//    eventDetailsVC.event = event;
//
//    [self.navigationController pushViewController:eventDetailsVC animated:YES];
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"%lu", selectedIndexPath.row);
    
    Event *event = [self.events objectAtIndex: selectedIndexPath.row];
    
    self.myTabbarController = (UITabBarController*) [segue destinationViewController];
    self.eventDetailsView = [self.myTabbarController.viewControllers objectAtIndex:0];
    self.eventDetailsView.event = event;
    
    self.eventTicketView = [self.myTabbarController.viewControllers objectAtIndex:1];
    self.eventTicketView.event = event;
}


@end
