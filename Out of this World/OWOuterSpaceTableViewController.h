//
//  OWOuterSpaceTableViewController.h
//  Out of this World
//
//  Created by jim Veneskey on 3/23/15.
//  Copyright (c) 2015 Jim Veneskey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWAddSpaceObjectViewController.h"

@interface OWOuterSpaceTableViewController : UITableViewController <OWAddSpaceObjectViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *planets;

@property (strong, nonatomic) NSMutableArray *addedSpaceObjects;



@end
