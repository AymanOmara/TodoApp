//
//  ToDoList.m
//  ToDoApp
//
//  Created by Ayman Omara on 05/04/2021.
//

#import "ToDoList.h"
#import "ToDoModel.h"
#import "AddViewController.h"
#import "DetailedViewController.h"
#import "DoneViewController.h"
#import "InProgressViewController.h"
@interface ToDoList ()

@property (weak, nonatomic) IBOutlet UITableView *tableViewOutLet;
@property NSUserDefaults *userDefaults;
@property NSUserDefaults* myNewDefaults;
@end

@implementation ToDoList
- (IBAction)goToAddView:(id)sender {
    AddViewController *addViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"AddViewController"];
    addViewController.delegate=self;
    [self.navigationController pushViewController:addViewController animated:YES];

}

NSData *data;
NSUserDefaults *defaultsTwo;
bool old;

-(void)viewDidLoad {
    [super viewDidLoad];
    
    defaultsTwo=[NSUserDefaults standardUserDefaults];
    data = [defaultsTwo objectForKey:@"todo"];
    _array=[NSMutableArray new];

    [self getFromUserDefaults];
    [self alarmWithNotification:@"12"];

}

-(void)viewWillAppear:(BOOL)animated{
    [self getFromUserDefaults];
    [_tableViewOutLet reloadData];
    
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text=[[_array objectAtIndex:indexPath.row]name];
//    [_array removeObjectAtIndex:indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_array count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {

        [_array removeObjectAtIndex:indexPath.row];
        [self saveToDoT];
        [_tableViewOutLet reloadData];

    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailedViewController *details = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailedViewController"];
    
    
            details.toDo = [_array objectAtIndex:indexPath.row];
            details.tododelegate=self;
        
    [self.navigationController pushViewController:details animated:YES];
}
-(void)reciveData:(ToDoModel*)todo andnewtodo: (ToDoModel*)newTodo{

    InProgressViewController *inProg=[InProgressViewController new];
    DoneViewController *done=[DoneViewController new];
    
    if([[newTodo state] isEqualToString:@"inprogress"]){
        
        [inProg removeAndAdd:newTodo];
        //array is the array
        [_array removeObject:todo];
        [self saveToDoT];
        
        [_tableViewOutLet reloadData];
    }
    else if([[newTodo state] isEqualToString:@"todo"]){
        [_array removeObject:todo];
        [_array addObject:newTodo];
        [self saveToDoT];
        [_tableViewOutLet reloadData];
        
    }
    else if([[newTodo state] isEqualToString:@"done"]){
        [_array removeObject:todo];
        [done removeAndAddDone:newTodo];
        //[_array addObject:newTodo];
        [self saveToDoT];
        //[done saveDoned];
        [_tableViewOutLet reloadData];
        
    }
   
//
//    DoneViewController *done=[DoneViewController new];
//
//     if([[newTodo state] isEqualToString:@"done"]){
//
//         [[done doneArray] addObject:newTodo];
//         [done saveDoned];
//         
//         
//    }
//    else if([[newTodo state] isEqualToString:@"inprogress"]){
//            
//        
//        [array removeObject:todo];
//        [self saveToDoT];
////        [_tableViewOutLet reloadData];
//        //[myAddView saveInProgress:newTodo];

//       // [inProg upDateUI];
//        // [[inProg inProgressArray] addObject:newTodo];
//        //[inProg saveInProgressT];
//
//        //[inProg saveInProgressT];
//        [_tableViewOutLet reloadData];
//        
//        
//        
//
//        
//    }

}

-(void)getFromUserDefaults{
    _userDefaults = [NSUserDefaults standardUserDefaults];
    if([_userDefaults objectForKey:@"todo"]!=nil){
            NSData *encodedObject = [_userDefaults objectForKey:@"todo"];
            NSMutableArray *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
        _array=object;
        
}
}
-(void)saveToDoT{
    if([_userDefaults objectForKey:@"todo"]!=nil){
        NSData *encodedObject = [_userDefaults objectForKey:@"todo"];
        encodedObject = [NSKeyedArchiver archivedDataWithRootObject:_array];
        [_userDefaults setObject:encodedObject forKey:@"todo"];
        [_userDefaults synchronize];
    }else{
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:_array];
        [_userDefaults setObject:encodedObject forKey:@"todo"];
        [_userDefaults synchronize];
        }
}
    
-(void)alarmWithNotification:(NSString*) str{

    printf("method alarm is called");
    old=TRUE;
    UNUserNotificationCenter *center=[UNUserNotificationCenter currentNotificationCenter];
    UNAuthorizationOptions options=UNAuthorizationOptionAlert+UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted,NSError *_Nonnull error){
        old=granted;
    }];
    if(old){
        if ([_array count]>0) {
            NSString *date =[_array lastObject].reminderDate;
        }


       NSDateFormatter *formate=[NSDateFormatter new];
//        NSDate *d= [formate dateFromString:date];
//
        UNMutableNotificationContent *content=[[UNMutableNotificationContent alloc] init];
        content.title=@"Ayman";
        content.subtitle=@"my sub Title";
        content.body=@"My Body";
        content.sound=[UNNotificationSound defaultSound];


        UNTimeIntervalNotificationTrigger *triger=[UNTimeIntervalNotificationTrigger triggerWithTimeInterval:20/*[formate dateFromString:data]*/ repeats:NO];
        UNNotificationRequest *requet=[UNNotificationRequest requestWithIdentifier:@"request" content:content trigger:triger];
        [center addNotificationRequest:requet withCompletionHandler:nil];

        
    }
}
    



@end
