//
//  DoneViewController.h
//  ToDoApp
//
//  Created by Ayman Omara on 06/04/2021.
//

#import <UIKit/UIKit.h>
#import "MyProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface DoneViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,MyProtocol>
@property NSMutableArray <ToDoModel*> *doneArray;
-(void)removeAndAddDone:(ToDoModel*) newTodo;
-(void)saveDoned;
-(void)alarmWithNotificationDone:(NSString*)st;
@end

NS_ASSUME_NONNULL_END
