//
//  OWSpaceDataViewController.h
//  Out of this World
//
//  Created by jim Veneskey on 4/2/15.
//  Copyright (c) 2015 Jim Veneskey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWSpaceObject.h"


@interface OWSpaceDataViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) OWSpaceObject *spaceObject;



@end
