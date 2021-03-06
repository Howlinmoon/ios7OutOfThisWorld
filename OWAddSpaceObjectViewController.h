//
//  OWAddSpaceObjectViewController.h
//  Out of this World
//
//  Created by jim Veneskey on 4/8/15.
//  Copyright (c) 2015 Jim Veneskey. All rights reserved.
//

#import <UIKit/UIKit.h>
# import "OWSpaceObject.h"

@protocol OWAddSpaceObjectViewControllerDelegate <NSObject>

@required
-(void) addSpaceObject:(OWSpaceObject *) spaceObject;
-(void) didCancel;


@end

@interface OWAddSpaceObjectViewController : UIViewController

@property (weak, nonatomic) id <OWAddSpaceObjectViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;

@property (strong, nonatomic) IBOutlet UITextField *nicknameTextField;

@property (strong, nonatomic) IBOutlet UITextField *diameterTextField;

@property (strong, nonatomic) IBOutlet UITextField *temperatureTextField;

@property (strong, nonatomic) IBOutlet UITextField *numberOfMoonsTextField;

@property (strong, nonatomic) IBOutlet UITextField *interestingFactTextField;

- (IBAction)cancelButtonPressed:(UIButton *)sender;


- (IBAction)addButtonPressed:(UIButton *)sender;



@end
