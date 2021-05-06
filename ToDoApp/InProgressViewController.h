//
//  InProgressViewController.h
//  ToDoApp
//
//  Created by Ayman Omara on 06/04/2021.
//

#import <UIKit/UIKit.h>
#import "MyProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface InProgressViewController : UIViewController<MyProtocol>
-(void)saveInProgressT;
-(void)upDateUI;
-(void)removeAndAdd:(ToDoModel*) newTodo;
@property NSMutableArray <ToDoModel*> *inProgressArray;
@end

NS_ASSUME_NONNULL_END
