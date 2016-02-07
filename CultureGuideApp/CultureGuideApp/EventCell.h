//
//  EventTableViewCell.h
//  CultureGuideApp
//
//  Created by Elena Andonova on 2/7/16.
//  Copyright © 2016 EA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *eventCellName;

@property (weak, nonatomic) IBOutlet UILabel *eventCellDate;


@end
