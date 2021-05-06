//
//  ToDoList.h
//  ToDoApp
//
//  Created by Ayman Omara on 05/04/2021.
//

#import <UIKit/UIKit.h>
#import "MyProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface ToDoList : UIViewController <UITableViewDelegate,UITableViewDataSource,MyProtocol>
-(void)saveToDoT;
@property NSMutableArray <ToDoModel*> *array;
@end

NS_ASSUME_NONNULL_END
