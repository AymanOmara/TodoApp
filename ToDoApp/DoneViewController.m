//
//  DoneViewController.m
//  ToDoApp
//
//  Created by Ayman Omara on 06/04/2021.
//

#import "DoneViewController.h"
#import "ToDoModel.h"
#import "DetailedViewController.h"
#import "ToDoList.h"
#import "InProgressViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface DoneViewController ()
@property (weak, nonatomic) IBOutlet UITableView *donetable;
@property NSUserDefaults *userDefaults;

@end

@implementation DoneViewController


    NSData *doneData;
    NSUserDefaults *doneDefaults;
    bool doneOld;

-(void)viewDidLoad {
    [super viewDidLoad];
    [self alarmWithNotificationDone:@"1234"];
    doneDefaults=[NSUserDefaults standardUserDefaults];
    doneData = [doneDefaults objectForKey:@"done"];
    _doneArray=[NSMutableArray new];

    [self getFromUserDefaults];

}
-(void)viewWillAppear:(BOOL)animated{
    
    [self getFromUserDefaults];
    [_donetable reloadData];
    
}
 
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"donecell" forIndexPath:indexPath];
    cell.textLabel.text=[[_doneArray objectAtIndex:indexPath.row]name];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_doneArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailedViewController *details = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailedViewController"];
    
    
    details.toDo = [_doneArray objectAtIndex:indexPath.row];
    details.tododelegate=self;
    
    [self.navigationController pushViewController:details animated:YES];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {

        [_doneArray removeObjectAtIndex:indexPath.row];
        [self saveDoned];
        [_donetable reloadData];

    }
}
-(void)getFromUserDefaults{
    _userDefaults = [NSUserDefaults standardUserDefaults];
    if([_userDefaults objectForKey:@"done"]!=nil){
            NSData *encodedObject = [_userDefaults objectForKey:@"done"];
            NSMutableArray *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
        _doneArray=object;
        
}
}
-(void)saveDoned{
    if([_userDefaults objectForKey:@"done"]!=nil){
        NSData *encodedObject = [_userDefaults objectForKey:@"done"];
        encodedObject = [NSKeyedArchiver archivedDataWithRootObject:_doneArray];
        [_userDefaults setObject:encodedObject forKey:@"done"];
        [_userDefaults synchronize];
    }else{
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:_doneArray];
        [_userDefaults setObject:encodedObject forKey:@"done"];
        [_userDefaults synchronize];
        }
}
-(void)reciveData:(ToDoModel*)todo andnewtodo: (ToDoModel*)newTodo{
    [_donetable reloadData];
    [_doneArray removeObject:todo];
    [_doneArray addObject:newTodo];
    [self saveDoned];
    
    InProgressViewController *inProg=[InProgressViewController new];
    ToDoList *toDoList=[ToDoList new];
    if([[newTodo state] isEqualToString:@"inprogress"]){
        //AddViewController *myAddView=[AddViewController new];
        //[myAddView saveInProgress:newTodo];
        //[[inProg inProgressArray] addObject:newTodo];
        [inProg removeAndAdd:newTodo];

        [_doneArray removeObject:todo];
        [toDoList saveToDoT];
        [_donetable reloadData];
    }
    else if([[newTodo state] isEqualToString:@"todo"]){
        [_doneArray removeObject:todo];
        [[toDoList array] addObject:newTodo];
        [toDoList saveToDoT];
        [_donetable reloadData];
        
    }
    else if([[newTodo state] isEqualToString:@"done"]){
        [_doneArray removeObject:todo];
        [_doneArray addObject:newTodo];
        [self saveDoned];
        [_donetable reloadData];
    
    
   
}
}
-(void)removeAndAddDone:(ToDoModel*) newTodo{
    [_doneArray addObject:newTodo];
    [self saveDoned];
    [_donetable reloadData];
}



-(void)alarmWithNotificationDone:(NSString*) str{

printf("method alarm is called");
doneOld=TRUE;
UNUserNotificationCenter *center=[UNUserNotificationCenter currentNotificationCenter];
UNAuthorizationOptions options=UNAuthorizationOptionAlert+UNAuthorizationOptionSound;
[center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted,NSError *_Nonnull error){
    doneOld=granted;
}];
if(doneOld){
    if ([_doneArray count]>0) {
        NSString *date =[_doneArray lastObject].reminderDate;
    }
   NSDateFormatter *formate=[NSDateFormatter new];

    UNMutableNotificationContent *content=[[UNMutableNotificationContent alloc] init];
    content.title=@"Ayman";
    content.subtitle=@"my sub Title";
    content.body=@"My Body";
    content.sound=[UNNotificationSound defaultSound];
//
//    UNTimeIntervalNotificationTrigger *triger=[UNTimeIntervalNotificationTrigger triggerWithTimeInterval:[formate dateFromString:data]*100 repeats:NO];
//    UNNotificationRequest *requet=[UNNotificationRequest requestWithIdentifier:@"request" content:content trigger:triger];
//    [center addNotificationRequest:requet withCompletionHandler:nil];

    
}
}
@end
