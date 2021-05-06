//
//  DetailedViewController.m
//  ToDoApp
//
//  Created by Ayman Omara on 07/04/2021.
//

#import "DetailedViewController.h"
#import "ToDoList.h"
#import "ToDoModel.h"
#import "AddViewController.h"
#import "DoneViewController.h"
#import "InProgressViewController.h"


@interface DetailedViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameOutLet;
@property (weak, nonatomic) IBOutlet UITextView *descriptionOutLet;
@property (weak, nonatomic) IBOutlet UITextField *priorityOutLet;
@property (weak, nonatomic) IBOutlet UILabel *dateOfCraetionOutlet;
@property (weak, nonatomic) IBOutlet UILabel *reminderDate;
@property (weak, nonatomic) IBOutlet UITextField *stateOutlet;
@property ToDoModel *model;
@end

@implementation DetailedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _nameOutLet.text=[_toDo name];
    _descriptionOutLet.text=[_toDo descriptionModel];
    _stateOutlet.text=[_toDo state];
    _priorityOutLet.text=[_toDo priority];
    _reminderDate.text=[_toDo reminderDate];
    _dateOfCraetionOutlet.text=[_toDo craetDate];

}


- (IBAction)doneAction:(id)sender {

    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss a"];
    
    _model=[ToDoModel new];
    [_model setName:[_nameOutLet text]];
    [_model setDescriptionModel:[_descriptionOutLet text]];
    [_model setPriority:[_priorityOutLet text]];
    [_model setState:[_stateOutlet text]];
    [_model setCraetDate:[dateFormatter stringFromDate:[NSDate date]]];
    [_model setReminderDate:[_reminderDate text]];
      

    
    
    [_tododelegate  reciveData:self.toDo andnewtodo:_model];
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
