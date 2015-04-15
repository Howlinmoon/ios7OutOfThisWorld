//
//  OWOuterSpaceTableViewController.m
//  Out of this World
//
//  Created by jim Veneskey on 3/23/15.
//  Copyright (c) 2015 Jim Veneskey. All rights reserved.
//

#import "OWOuterSpaceTableViewController.h"
#import "AstronomicalData.h"
#import "OWSpaceObject.h"
#import "OWSpaceImageViewController.h"
#import "OWSpaceDataViewController.h"

@interface OWOuterSpaceTableViewController ()

@end

@implementation OWOuterSpaceTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    //self.planets = [[NSMutableArray alloc] init];
/*
    NSString *planet1 = @"Mercury";
    NSString *planet2 = @"Venus";
    NSString *planet3 = @"Earth";
    NSString *planet4 = @"Mars";
    NSString *planet5 = @"Jupiter";
    NSString *planet6 = @"Saturn";
    NSString *planet7 = @"Uranus";
    NSString *planet8 = @"Neptune";
    

    [self.planets addObject:planet1];
    [self.planets addObject:planet2];
    [self.planets addObject:planet3];
    [self.planets addObject:planet4];
    [self.planets addObject:planet5];
    [self.planets addObject:planet6];
    [self.planets addObject:planet7];
    [self.planets addObject:planet8];
*/
    
    self.planets = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *planetData in [AstronomicalData allKnownPlanets]) {
        NSString *imageName = [NSString stringWithFormat:@"%@.jpg", planetData[PLANET_NAME]];
        OWSpaceObject *planet = [[OWSpaceObject alloc] initWithData:planetData andImage:[UIImage imageNamed:imageName]];
        [self.planets addObject:planet];
    }

    
    NSMutableDictionary *myDictionary = [[NSMutableDictionary alloc]init];
    NSString *firstColor = @"red";
    [myDictionary setObject:firstColor forKey:@"firetruck color"];
    [myDictionary setObject:@"blue" forKey:@"ocean color"];
    [myDictionary setObject:@"yellow" forKey:@"star color"];
    NSLog(@"%@", myDictionary);
    
    NSString *blueString = [myDictionary objectForKey:@"ocean color"];
    NSLog(@"ocean color = %@", blueString);
    
    // converting a primitive numbers into objects
    NSNumber *myNumber = [NSNumber numberWithInt: 5];
    NSLog(@"NSNumber = %@", myNumber);
    float oldFloat = 3.14;
    NSNumber *floatyNumber = [NSNumber numberWithFloat:oldFloat];
    NSLog(@"New floaty number: %@", floatyNumber);
    // a short cut
    NSLog(@"This is an NSNumber: %@",@42);
    
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // In here, we are handling two completely different segues - by determing first who is calling us.
    
    NSLog(@"%@", sender);
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSLog(@"Confirmed - this is from a table view cell");
        if ([segue.destinationViewController isKindOfClass:[OWSpaceImageViewController class]]) {
            NSLog(@"We are headed for the planetary image view controller");
            OWSpaceImageViewController *nextViewController = segue.destinationViewController;
            NSIndexPath *path = [self.tableView indexPathForCell:sender];
            OWSpaceObject *selectedObject;
            
            NSLog(@"Path.section = %i", path.section);
            
            if (path.section == 0) {
                selectedObject = self.planets[path.row];
            } else if (path.section == 1) {
                selectedObject = self.addedSpaceObjects[path.row];
            }
            
            nextViewController.spaceObject = selectedObject;
            
            
        }
    }
    
    if ([sender isKindOfClass:[NSIndexPath class]]) {
        if ([segue.destinationViewController isKindOfClass:[OWSpaceDataViewController class]]) {
            NSLog(@"We are headed for the space data view controller");
            
            OWSpaceDataViewController *targetViewController = segue.destinationViewController;
            NSIndexPath *path = sender;
            OWSpaceObject *selectedObject;
            
            NSLog(@"Path.section = %i", path.section);
            
            if (path.section == 0) {
                selectedObject = self.planets[path.row];
            } else if (path.section == 1) {
                selectedObject = self.addedSpaceObjects[path.row];
            }

            targetViewController.spaceObject = selectedObject;
        }
    }
    
    
    if ([segue.destinationViewController isKindOfClass:
         [OWAddSpaceObjectViewController class]]) {
        OWAddSpaceObjectViewController *addSpaceObjectVC = segue.destinationViewController;
        addSpaceObjectVC.delegate = self;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - OWAddSpaceObjectViewController Delegate
-(void) didCancel {
    NSLog(@"didCancel was called");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) addSpaceObject:(OWSpaceObject *)spaceObject {
    if (!self.addedSpaceObjects) {
        self.addedSpaceObjects = [[NSMutableArray alloc] init];
    }
    [self.addedSpaceObjects addObject:spaceObject];
    NSLog(@"addSpaceObject was called");
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if ([self.addedSpaceObjects count]) {
        NSLog(@"Number of sections is 2");
        return 2;
    } else {
        NSLog(@"Number of sections is 1");
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 1) {
        return [self.addedSpaceObjects count];
    } else {
        return [self.planets count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    if (indexPath.section == 1) {
        // use new Space Object to customize our cell
        // TBA
        OWSpaceObject *planet = [self.addedSpaceObjects objectAtIndex:indexPath.row];
        cell.textLabel.text = planet.name;
        cell.detailTextLabel.text = planet.nickname;
        cell.imageView.image = planet.spaceImage;
        
        
    } else {
        OWSpaceObject *planet = [self.planets objectAtIndex:indexPath.row];
        cell.textLabel.text = planet.name;
        cell.detailTextLabel.text = planet.nickname;
        cell.imageView.image = planet.spaceImage;
    }
    /* customize the appearance of the cells */
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    
    
    
    return cell;
}


#pragma mark UITableView Delegate
-(void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Accessory button was clicked, row: %i", indexPath.row);
    [self performSegueWithIdentifier:@"push to space data" sender:indexPath];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
