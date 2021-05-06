//
//  DetailedViewController.h
//  ToDoApp
//
//  Created by Ayman Omara on 07/04/2021.
//

#import <UIKit/UIKit.h>
#import "ToDoModel.h"
#import "MyProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailedViewController : UIViewController
@property ToDoModel *toDo;
@property id <MyProtocol> tododelegate;
@end

NS_ASSUME_NONNULL_END
