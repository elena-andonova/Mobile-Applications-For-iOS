//
//  PlaceViewController.m
//  CultureGuideApp
//
//  Created by Elena Andonova on 2/3/16.
//  Copyright © 2016 EA. All rights reserved.
//

#import "PlaceTableViewController.h"
#import "AppDelegate.h"
#import "Place.h"
#import "PlaceCell.h"

@implementation PlaceTableViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"Places";
    self.places = [NSArray arrayWithObjects:@"Theathre", @"Opera", @"Concerts", nil];
//    
//    UIBarButtonItem *addBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
//                                                                                  target:self
//                                                                                  action:@selector(showAdd)];
//    
//    self.navigationItem.rightBarButtonItem = addBarButton;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
//AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//    
//    self.places = [delegate.data places];
//    [self.tableView reloadData];
}

//-(void) showAdd{
//    NSString *storyBoardID = @"addGsmScene";
//    
//    AddGsmViewController *detailsVC = [self.storyboard instantiateViewControllerWithIdentifier:storyBoardID];
//    [self.navigationController pushViewController:detailsVC animated:YES];
//}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"placeCell";
    
    UITableViewCell *originalCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (![originalCell isKindOfClass:[PlaceCell class]] || originalCell == nil) {
        
        //Loading custom cell
        originalCell = [[[NSBundle mainBundle] loadNibNamed:@"PlaceCell" owner:self options:nil] objectAtIndex:0];
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    PlaceCell *cell = (PlaceCell*)originalCell;
    
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://cdn2.iconfinder.com/data/icons/ballicons-2-free/100/theatre-512.png"]]];
    NSLog(@"%f", img.size.height);
    cell.placeImageView.image = img;
    cell.nameLabel.text =[[self.places objectAtIndex:indexPath.row] description];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.places.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //Place *place = [self.places objectAtIndex:indexPath.row];
    //NSString *storyBoardID = @"detailsScene";
    
    //GsmDetailsViewController *detailsVC = [self.storyboard instantiateViewControllerWithIdentifier:storyBoardID];
    
    //detailsVC.gsm = gsm;
    
    //[self.navigationController pushViewController:detailsVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}


@end
