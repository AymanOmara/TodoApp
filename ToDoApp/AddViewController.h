//
//  AddViewController.h
//  ToDoApp
//
//  Created by Ayman Omara on 05/04/2021.
//

#import <UIKit/UIKit.h>
#import "ToDoModel.h"
#import "MyProtocol.h"
#import <UserNotifications/UserNotifications.h>
NS_ASSUME_NONNULL_BEGIN

@interface AddViewController : UIViewController
@property id <MyProtocol> delegate;
-(void)alarmWithNotification:(NSString*) str;
-(void)saveToDo:(ToDoModel*)model;
-(void)saveInProgress:(ToDoModel*)model;
-(void)saveDone:(ToDoModel*)model;
@end

NS_ASSUME_NONNULL_END
