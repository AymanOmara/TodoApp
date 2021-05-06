//
//  InProgressViewController.m
//  ToDoApp
//
//  Created by Ayman Omara on 06/04/2021.
//

#import "InProgressViewController.h"
#import "ToDoModel.h"
#import "DetailedViewController.h"
#import <UserNotifications/UserNotifications.h>
@interface InProgressViewController ()
@property (weak, nonatomic) IBOutlet UITableView *inProgresstableOutLet;
@property NSUserDefaults *userDefaults;

@end

@implementation InProgressViewController{
    
    NSData *data;
    NSUserDefaults *defaultsTwo;
    ToDoModel *myModel;
    bool inprogressOld;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    defaultsTwo=[NSUserDefaults standardUserDefaults];
    data = [defaultsTwo objectForKey:@"inprogress"];
    _inProgressArray=[NSMutableArray new];

    [self getFromUserDefaults];

}
-(void)upDateUI{
    [_inProgresstableOutLet reloadData];
}
-(void)viewWillAppear:(BOOL)animated{
    //defaultsTwo=[NSUserDefaults standardUserDefaults];
    [self getFromUserDefaults];
    [_inProgresstableOutLet reloadData];
    
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"inprogresscell" forIndexPath:indexPath];
    cell.textLabel.text=[[_inProgressArray objectAtIndex:indexPath.row]name];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_inProgressArray count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailedViewController *details = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailedViewController"];
    
            details.toDo = [_inProgressArray objectAtIndex:indexPath.row];
            details.tododelegate=self;
    [self.navigationController pushViewController:details animated:YES];
  
}
-(void)getFromUserDefaults{
    _userDefaults = [NSUserDefaults standardUserDefaults];
    if([_userDefaults objectForKey:@"inprogress"]!=nil){
            NSData *encodedObject = [_userDefaults objectForKey:@"inprogress"];
            NSMutableArray *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
        _inProgressArray=object;
        
}
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_inProgressArray removeObjectAtIndex:indexPath.row];
        [self saveInProgressT];
        [_inProgresstableOutLet reloadData];

    }
}


-(void)reciveData:(ToDoModel*)todo andnewtodo: (ToDoModel*)newTodo{
   //to do the old object
    [_inProgresstableOutLet reloadData];
    [_inProgressArray removeObject:todo];
    [_inProgressArray addObject:newTodo];
    [self saveInProgressT];
}
-(void)saveInProgressT{
    if([_userDefaults objectForKey:@"inprogress"]!=nil){
        NSData *encodedObject = [_userDefaults objectForKey:@"inprogress"];
        encodedObject = [NSKeyedArchiver archivedDataWithRootObject:_inProgressArray];
        [_userDefaults setObject:encodedObject forKey:@"inprogress"];
        [_userDefaults synchronize];
    }else{
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:_inProgressArray];
        [_userDefaults setObject:encodedObject forKey:@"inprogress"];
        [_userDefaults synchronize];
        }
}
-(void)removeAndAdd:(ToDoModel*) newTodo{
    _inProgressArray=[NSMutableArray new];
    [_inProgressArray addObject:newTodo];
    [self saveInProgressT];
    printf("%d my array count",[_inProgressArray count]);
    
    [_inProgresstableOutLet reloadData];
}


-(void)alarmWithNotification:(NSString*) str{

printf("method alarm is called");
inprogressOld=TRUE;
UNUserNotificationCenter *center=[UNUserNotificationCenter currentNotificationCenter];
UNAuthorizationOptions options=UNAuthorizationOptionAlert+UNAuthorizationOptionSound;
[center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted,NSError *_Nonnull error){
    inprogressOld=granted;
}];
if(inprogressOld){
    if ([_inProgressArray count]>0) {
        NSString *date =[_inProgressArray lastObject].reminderDate;
    }
   NSDateFormatter *formate=[NSDateFormatter new];

    UNMutableNotificationContent *content=[[UNMutableNotificationContent alloc] init];
    content.title=@"Ayman";
    content.subtitle=@"my sub Title";
    content.body=@"My Body";
    content.sound=[UNNotificationSound defaultSound];
//
//    UNTimeIntervalNotificationTrigger *triger=[UNTimeIntervalNotificationTrigger triggerWithTimeInterval:[formate dateFromString:data] repeats:NO];
//    UNNotificationRequest *requet=[UNNotificationRequest requestWithIdentifier:@"request" content:content trigger:triger];
//    [center addNotificationRequest:requet withCompletionHandler:nil];

    
}
}



@end
