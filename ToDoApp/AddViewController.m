#import "AddViewController.h"
#import "ToDoModel.h"
@interface AddViewController (){
UIDatePicker *uiDatePicker;
    ToDoModel *model;
}
@property (weak, nonatomic) IBOutlet UILabel *lblText;
@property (weak, nonatomic) IBOutlet UITextField *nameOutLet;
@property (weak, nonatomic) IBOutlet UITextView *descriptionOutLet;
@property (weak, nonatomic) IBOutlet UITextField *stateOutLet;
@property (weak, nonatomic) IBOutlet UITextField *priorityOutLet;
@property (weak, nonatomic) IBOutlet UIDatePicker *UIDatePicker;
@property NSUserDefaults* defaults;



@end

@implementation AddViewController

NSUserDefaults *defaults;

- (void)viewDidLoad {
    [super viewDidLoad];
    _defaults=[NSUserDefaults standardUserDefaults];
    
    
}

- (IBAction)addNewToDo:(id)sender {
    //[self alarmWithNotification:@"3"];
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss a"];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss a"];
    
    
    
    NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    
    model=[ToDoModel new];
    [model setName:[_nameOutLet text]];
    [model setDescriptionModel:[_descriptionOutLet text]];
    [model setPriority:[_priorityOutLet text]];
    [model setState:[_stateOutLet text]];
    [model setCraetDate:[dateFormatter stringFromDate:[NSDate date]]];
    [model setReminderDate:[ dateFormatter stringFromDate:_UIDatePicker.date]];
    
    if([[_stateOutLet text]isEqualToString:@"todo"]){
        [self saveToDo:model];
    }
    else if([[_stateOutLet text]isEqualToString:@"inprogress"]){
        [self saveInProgress:model];
    }
    else if([[_stateOutLet text]isEqualToString:@"done"]){
        
        [self saveDone:model];
    }
    //[_delegate reciveData:model];
    
    
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)saveToDo:(ToDoModel*)model{

    
    if([_defaults objectForKey:@"todo"]!=nil){
     
     NSData *encodedObject = [_defaults objectForKey:@"todo"];
     NSMutableArray *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
 
     [object addObject:model];
      
     encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
     [_defaults setObject:encodedObject forKey:@"todo"];
     [_defaults synchronize];
 }else{
     NSMutableArray *currentData=[NSMutableArray new];
     [currentData addObject:model];
     NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:currentData];
     [_defaults setObject:encodedObject forKey:@"todo"];
     [_defaults synchronize];
    
 }
}
-(void)saveInProgress:(ToDoModel*)model{
    
    if([_defaults objectForKey:@"inprogress"]!=nil){
     
     NSData *encodedObject = [_defaults objectForKey:@"inprogress"];
     NSMutableArray *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
 
     [object addObject:model];
      
     encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
     [_defaults setObject:encodedObject forKey:@"inprogress"];
     [_defaults synchronize];
 }else{
     NSMutableArray *currentData=[NSMutableArray new];
     [currentData addObject:model];
     NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:currentData];
     [_defaults setObject:encodedObject forKey:@"inprogress"];
     [_defaults synchronize];
    
}
}


-(void)saveDone:(ToDoModel*)model{
    
    if([_defaults objectForKey:@"done"]!=nil){
     
     NSData *encodedObject = [_defaults objectForKey:@"done"];
     NSMutableArray *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
 
     [object addObject:model];
      
     encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
     [_defaults setObject:encodedObject forKey:@"done"];
     [_defaults synchronize];
 }else{
     NSMutableArray *currentData=[NSMutableArray new];
     [currentData addObject:model];
     NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:currentData];
     [_defaults setObject:encodedObject forKey:@"done"];
     [_defaults synchronize];
}
}
@end
