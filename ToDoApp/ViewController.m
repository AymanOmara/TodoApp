//
//  ViewController.m
//  ToDoApp
//
//  Created by Ayman Omara on 05/04/2021.
//

#import "ViewController.h"

@interface ViewController ()

@end
bool oldddd;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    oldddd=false;
    UNUserNotificationCenter *center=[UNUserNotificationCenter currentNotificationCenter];
    UNAuthorizationOptions options=UNAuthorizationOptionAlert+UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted,NSError *_Nonnull error){
        oldddd=granted;
    }];
    if(oldddd){
        
        //A a;
        //UNUserNotificationCenter *center=[UNUserNotificationCenter currentNotificationCenter];
        UNMutableNotificationContent *content=[[UNMutableNotificationContent alloc] init];
        content.title=@"Ayman";
        content.subtitle=@"my sub Title";
        content.body=@"My Body";
        content.sound=[UNNotificationSound defaultSound];
        
    NSDate *myDate = [NSDate date];
       
        UNTimeIntervalNotificationTrigger *triger=[UNTimeIntervalNotificationTrigger triggerWithTimeInterval:[myDate timeIntervalSinceReferenceDate]  repeats:false];
        UNNotificationRequest *requet=[UNNotificationRequest requestWithIdentifier:@"request" content:content trigger:triger];
        [center addNotificationRequest:requet withCompletionHandler:nil];
        
    }
}



@end
